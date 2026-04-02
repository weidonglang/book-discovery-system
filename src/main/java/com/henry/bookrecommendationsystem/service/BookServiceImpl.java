package com.henry.bookrecommendationsystem.service;

import com.henry.bookrecommendationsystem.dao.BookDao;
import com.henry.bookrecommendationsystem.dao.BookLoanDao;
import com.henry.bookrecommendationsystem.dao.UserBookRateDao;
import com.henry.bookrecommendationsystem.dto.BookDto;
import com.henry.bookrecommendationsystem.dto.BookFilterPaginationRequest;
import com.henry.bookrecommendationsystem.dto.BookRecommendationOverviewDto;
import com.henry.bookrecommendationsystem.dto.BookRecommendationShelfDto;
import com.henry.bookrecommendationsystem.dto.TagDto;
import com.henry.bookrecommendationsystem.dto.base.pagination.FilterPaginationRequest;
import com.henry.bookrecommendationsystem.dto.base.response.PaginationResponse;
import com.henry.bookrecommendationsystem.entity.Book;
import com.henry.bookrecommendationsystem.entity.BookLoan;
import com.henry.bookrecommendationsystem.entity.UserBookRate;
import com.henry.bookrecommendationsystem.transformer.BookTransformer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author Henry Azer
 * @since 07/11/2022
 */
@Slf4j
@Service

public class BookServiceImpl implements BookService {
    private static final int MIN_OF_RECOMMENDED_BOOKS = 14;
    private static final int DEFAULT_RECOMMENDATION_LIMIT = 8;
    private static final int DETAIL_RECOMMENDATION_LIMIT = 6;
    private final BookTransformer bookTransformer;
    private final BookDao bookDao;
    private final AuthorService authorService;
    private final BookCategoryService bookCategoryService;
    private final PublisherService publisherService;
    private final TagService tagService;
    private final UserReadingInfoService userReadingInfoService;
    private final BookLoanDao bookLoanDao;
    private final UserService userService;
    private final UserBookRateDao userBookRateDao;

    @Autowired
    public BookServiceImpl(BookTransformer bookTransformer, BookDao bookDao, AuthorService authorService, BookCategoryService bookCategoryService, PublisherService publisherService, TagService tagService, UserReadingInfoService userReadingInfoService, BookLoanDao bookLoanDao, UserService userService, UserBookRateDao userBookRateDao) {
        this.bookTransformer = bookTransformer;
        this.bookDao = bookDao;
        this.bookCategoryService = bookCategoryService;
        this.publisherService = publisherService;
        this.tagService = tagService;
        this.userReadingInfoService = userReadingInfoService;
        this.authorService = authorService;
        this.bookLoanDao = bookLoanDao;
        this.userService = userService;
        this.userBookRateDao = userBookRateDao;
    }

    public BookServiceImpl(BookTransformer bookTransformer, BookDao bookDao, AuthorService authorService, BookCategoryService bookCategoryService, PublisherService publisherService, TagService tagService, UserReadingInfoService userReadingInfoService, BookLoanDao bookLoanDao) {
        this(bookTransformer, bookDao, authorService, bookCategoryService, publisherService, tagService, userReadingInfoService, bookLoanDao, null, null);
    }

    public BookServiceImpl(BookTransformer bookTransformer, BookDao bookDao, AuthorService authorService, UserReadingInfoService userReadingInfoService) {
        this(bookTransformer, bookDao, authorService, null, null, null, userReadingInfoService, null, null, null);
    }

    @Override
    public BookDao getDao() {
        return bookDao;
    }

    @Override
    public BookTransformer getTransformer() {
        return bookTransformer;
    }

    @Override
    public BookDto create(BookDto dto) {
        log.info("BookService: create() called");
        normalizeBookRelations(dto);
        normalizeInventoryForCreate(dto);
        return getTransformer().transformEntityToDto(getDao().create(getTransformer().transformDtoToEntity(dto)));
    }

    @Override
    public BookDto update(BookDto dto, Long id) {
        log.info("BookService: update() called");
        Optional<Book> book = getDao().findById(id);
        if (book.isEmpty())
            throw new EntityExistsException("Book not found for id: " + id);

        normalizeBookRelations(dto);
        normalizeInventoryForUpdate(dto, book.get());
        getTransformer().updateEntity(dto, book.get());
        return getTransformer().transformEntityToDto(getDao().update(book.get()));
    }

    @Override
    public void deleteById(Long id) {
        log.info("BookService: deleteById() called");
        Optional<Book> optionalBook = getDao().findById(id);
        if (optionalBook.isEmpty())
            throw new EntityExistsException("Book not found for id: " + id);

        Book book = optionalBook.get();
        book.setMarkedAsDeleted(true);
        getDao().update(book);
    }

    private void normalizeBookRelations(BookDto dto) {
        dto.setAuthor(authorService.findById(dto.getAuthor().getId()));
        if (bookCategoryService != null && dto.getCategory() != null) {
            dto.setCategory(bookCategoryService.findById(dto.getCategory().getId()));
        }
        if (publisherService != null) {
            dto.setPublisher(dto.getPublisher() == null || dto.getPublisher().getId() == null
                    ? null
                    : publisherService.findById(dto.getPublisher().getId()));
        }
        if (tagService != null) {
            Set<TagDto> normalizedTags = dto.getTags() == null
                    ? new LinkedHashSet<>()
                    : dto.getTags().stream()
                    .filter(tagDto -> tagDto.getId() != null)
                    .map(tagDto -> tagService.findById(tagDto.getId()))
                    .collect(Collectors.toCollection(LinkedHashSet::new));
            dto.setTags(normalizedTags);
        }
    }

    private void normalizeInventoryForCreate(BookDto dto) {
        Integer totalCopies = dto.getTotalCopies() == null ? 1 : dto.getTotalCopies();
        if (totalCopies < 1) {
            throw new EntityExistsException("Total copies must be at least 1.");
        }
        dto.setTotalCopies(totalCopies);
        dto.setAvailableCopies(totalCopies);
    }

    private void normalizeInventoryForUpdate(BookDto dto, Book existingBook) {
        Integer totalCopies = dto.getTotalCopies() == null ? existingBook.getTotalCopies() : dto.getTotalCopies();
        if (totalCopies < 1) {
            throw new EntityExistsException("Total copies must be at least 1.");
        }
        long activeLoans = bookLoanDao == null
                ? Math.max(0, existingBook.getTotalCopies() - existingBook.getAvailableCopies())
                : bookLoanDao.countActiveLoansByBookId(existingBook.getId());
        if (totalCopies < activeLoans) {
            throw new EntityExistsException("Total copies cannot be lower than active borrowed copies.");
        }
        dto.setTotalCopies(totalCopies);
        dto.setAvailableCopies((int) (totalCopies - activeLoans));
    }

    @Override
    public List<BookDto> findAllBooksByAuthorId(Long authorId) {
        log.info("BookService: findAllBooksByAuthorId() called");
        return getTransformer().transformEntityToDto(getDao().findAllBooksByAuthorId(authorId));
    }

    @Override
    public PaginationResponse<BookDto> findAllBooksPaginatedAndFiltered(FilterPaginationRequest<BookFilterPaginationRequest> bookFilterPaginationRequest) {
        log.info("BookService: findAllBooksPaginatedAndFiltered() called");
        return buildPaginationResponse(getDao().findAllBooksPaginatedAndFiltered(bookFilterPaginationRequest));
    }

    @Override
    public List<BookDto> findAllRecommendedBooks() {
        log.info("BookService: findAllRecommendedBooks() called");
        List<Book> recommendedBooks = recommendByPreferredCategories(findActiveBooks(), Collections.emptySet(), MIN_OF_RECOMMENDED_BOOKS);
        if (recommendedBooks.isEmpty()) {
            recommendedBooks = findPopularBookEntities(MIN_OF_RECOMMENDED_BOOKS, Collections.emptySet());
        }
        return getTransformer().transformEntityToDto(recommendedBooks);
    }

    @Override
    public List<BookDto> findPopularBooks(Integer limit) {
        log.info("BookService: findPopularBooks() called");
        return getTransformer().transformEntityToDto(findPopularBookEntities(sanitizeLimit(limit, DEFAULT_RECOMMENDATION_LIMIT), Collections.emptySet()));
    }

    @Override
    public BookRecommendationOverviewDto findRecommendationOverview() {
        log.info("BookService: findRecommendationOverview() called");
        List<Book> activeBooks = findActiveBooks();
        List<BookRecommendationShelfDto> shelves = new ArrayList<>();

        List<Book> popularBooks = findPopularBookEntities(DEFAULT_RECOMMENDATION_LIMIT, Collections.emptySet());
        if (!popularBooks.isEmpty()) {
            shelves.add(buildShelf("popular", "Popular Right Now",
                    "Simple popularity ranking using rating count, average score, and availability.",
                    popularBooks));
        }

        List<Book> preferenceBooks = recommendByPreferredCategories(activeBooks, Collections.emptySet(), DEFAULT_RECOMMENDATION_LIMIT);
        if (!preferenceBooks.isEmpty()) {
            shelves.add(buildShelf("preferences", "Because Of Your Reading Preferences",
                    "Matches the categories you selected in your reading preferences.",
                    preferenceBooks));
        }

        List<Book> activityBooks = recommendByUserActivity(activeBooks, Collections.emptySet(), DEFAULT_RECOMMENDATION_LIMIT);
        if (!activityBooks.isEmpty()) {
            shelves.add(buildShelf("activity", "Based On Your Ratings And Loans",
                    "Derived from the categories and tags in books you rated or borrowed.",
                    activityBooks));
        }

        return new BookRecommendationOverviewDto("Recommendations", shelves);
    }

    @Override
    public BookRecommendationOverviewDto findBookSimilarityRecommendations(Long bookId) {
        log.info("BookService: findBookSimilarityRecommendations() called");
        Book sourceBook = getDao().findById(bookId)
                .filter(book -> !Boolean.TRUE.equals(book.getMarkedAsDeleted()))
                .orElseThrow(() -> new EntityExistsException("Book not found for id: " + bookId));

        List<Book> activeBooks = findActiveBooks().stream()
                .filter(book -> !bookId.equals(book.getId()))
                .collect(Collectors.toList());
        List<BookRecommendationShelfDto> shelves = new ArrayList<>();
        Set<Long> excludedIds = new HashSet<>();
        excludedIds.add(bookId);

        List<Book> sameCategoryBooks = activeBooks.stream()
                .filter(book -> book.getCategory() != null
                        && sourceBook.getCategory() != null
                        && sourceBook.getCategory().getId().equals(book.getCategory().getId()))
                .sorted(Comparator
                        .comparingInt((Book book) -> sharedTagCount(sourceBook, book)).reversed()
                        .thenComparing(popularityComparator()))
                .limit(DETAIL_RECOMMENDATION_LIMIT)
                .collect(Collectors.toList());
        if (!sameCategoryBooks.isEmpty()) {
            shelves.add(buildShelf("same-category", "More In The Same Category",
                    "Books from the same category, ranked by shared tags and popularity.",
                    sameCategoryBooks));
            excludedIds.addAll(sameCategoryBooks.stream().map(Book::getId).collect(Collectors.toSet()));
        }

        Set<Long> sourceTagIds = extractTagIds(sourceBook);
        List<Book> tagSimilarBooks = sourceTagIds.isEmpty()
                ? Collections.emptyList()
                : activeBooks.stream()
                .filter(book -> !excludedIds.contains(book.getId()))
                .filter(book -> sharedTagCount(sourceBook, book) > 0)
                .sorted(Comparator
                        .comparingInt((Book book) -> sharedTagCount(sourceBook, book)).reversed()
                        .thenComparing(popularityComparator()))
                .limit(DETAIL_RECOMMENDATION_LIMIT)
                .collect(Collectors.toList());
        if (!tagSimilarBooks.isEmpty()) {
            shelves.add(buildShelf("shared-tags", "Similar By Tags",
                    "Books sharing one or more tags with the current title.",
                    tagSimilarBooks));
            excludedIds.addAll(tagSimilarBooks.stream().map(Book::getId).collect(Collectors.toSet()));
        }

        if (shelves.isEmpty()) {
            List<Book> fallbackBooks = findPopularBookEntities(DETAIL_RECOMMENDATION_LIMIT, excludedIds);
            if (!fallbackBooks.isEmpty()) {
                shelves.add(buildShelf("fallback", "Readers Also Explore",
                        "Fallback recommendations when the current book has few matching neighbors.",
                        fallbackBooks));
            }
        }

        return new BookRecommendationOverviewDto("Related Books", shelves);
    }

    private List<Book> findActiveBooks() {
        return getDao().findAll().stream()
                .filter(book -> !Boolean.TRUE.equals(book.getMarkedAsDeleted()))
                .collect(Collectors.toList());
    }

    private List<Book> findPopularBookEntities(int limit, Set<Long> excludedIds) {
        return findActiveBooks().stream()
                .filter(book -> !excludedIds.contains(book.getId()))
                .sorted(popularityComparator())
                .limit(limit)
                .collect(Collectors.toList());
    }

    private List<Book> recommendByPreferredCategories(List<Book> activeBooks, Set<Long> excludedIds, int limit) {
        try {
            Set<Long> preferredCategoryIds = userReadingInfoService.findUserReadingInfo().getUserBookCategories().stream()
                    .map(userBookCategoryDto -> userBookCategoryDto.getCategory())
                    .filter(categoryDto -> categoryDto != null && categoryDto.getId() != null)
                    .map(categoryDto -> categoryDto.getId())
                    .collect(Collectors.toSet());
            if (preferredCategoryIds.isEmpty()) {
                return Collections.emptyList();
            }

            return activeBooks.stream()
                    .filter(book -> !excludedIds.contains(book.getId()))
                    .filter(book -> book.getCategory() != null && preferredCategoryIds.contains(book.getCategory().getId()))
                    .sorted(popularityComparator())
                    .limit(limit)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            return Collections.emptyList();
        }
    }

    private List<Book> recommendByUserActivity(List<Book> activeBooks, Set<Long> excludedIds, int limit) {
        if (userService == null || userBookRateDao == null || bookLoanDao == null) {
            return Collections.emptyList();
        }

        try {
            Long userId = userService.getCurrentUser().getId();
            Map<Long, Integer> categoryWeights = new HashMap<>();
            Map<Long, Integer> tagWeights = new HashMap<>();
            Set<Long> interactedBookIds = new HashSet<>(excludedIds);

            for (UserBookRate rate : userBookRateDao.findAllByUserId(userId)) {
                collectInteractionWeights(rate.getBook(), Math.max(1, rate.getRate() == null ? 2 : rate.getRate()), categoryWeights, tagWeights, interactedBookIds);
            }
            for (BookLoan activeLoan : bookLoanDao.findCurrentUserActiveLoans(userId)) {
                collectInteractionWeights(activeLoan.getBook(), 2, categoryWeights, tagWeights, interactedBookIds);
            }
            for (BookLoan historyLoan : bookLoanDao.findCurrentUserLoanHistory(userId)) {
                collectInteractionWeights(historyLoan.getBook(), 1, categoryWeights, tagWeights, interactedBookIds);
            }

            if (categoryWeights.isEmpty() && tagWeights.isEmpty()) {
                return Collections.emptyList();
            }

            return activeBooks.stream()
                    .filter(book -> !interactedBookIds.contains(book.getId()))
                    .map(book -> new AbstractMap.SimpleEntry<>(book, calculateActivityScore(book, categoryWeights, tagWeights)))
                    .filter(entry -> entry.getValue() > 0)
                    .sorted(Comparator
                            .comparingInt((AbstractMap.SimpleEntry<Book, Integer> entry) -> entry.getValue()).reversed()
                            .thenComparing(entry -> safeLong(entry.getKey().getUsersRateCount()), Comparator.reverseOrder())
                            .thenComparing(entry -> safeDouble(entry.getKey().getRate()), Comparator.reverseOrder())
                            .thenComparing(entry -> safeInt(entry.getKey().getAvailableCopies()), Comparator.reverseOrder())
                            .thenComparing(entry -> safeString(entry.getKey().getName())))
                    .map(AbstractMap.SimpleEntry::getKey)
                    .limit(limit)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            return Collections.emptyList();
        }
    }

    private void collectInteractionWeights(Book book,
                                           int weight,
                                           Map<Long, Integer> categoryWeights,
                                           Map<Long, Integer> tagWeights,
                                           Set<Long> interactedBookIds) {
        if (book == null || Boolean.TRUE.equals(book.getMarkedAsDeleted()) || book.getId() == null) {
            return;
        }
        interactedBookIds.add(book.getId());
        if (book.getCategory() != null && book.getCategory().getId() != null) {
            categoryWeights.merge(book.getCategory().getId(), weight, Integer::sum);
        }
        extractTagIds(book).forEach(tagId -> tagWeights.merge(tagId, weight, Integer::sum));
    }

    private int calculateActivityScore(Book book, Map<Long, Integer> categoryWeights, Map<Long, Integer> tagWeights) {
        int score = 0;
        if (book.getCategory() != null && book.getCategory().getId() != null) {
            score += categoryWeights.getOrDefault(book.getCategory().getId(), 0) * 3;
        }
        for (Long tagId : extractTagIds(book)) {
            score += tagWeights.getOrDefault(tagId, 0) * 2;
        }
        return score;
    }

    private Set<Long> extractTagIds(Book book) {
        if (book == null || book.getTags() == null) {
            return Collections.emptySet();
        }
        return book.getTags().stream()
                .filter(tag -> tag != null && tag.getId() != null)
                .map(tag -> tag.getId())
                .collect(Collectors.toSet());
    }

    private int sharedTagCount(Book sourceBook, Book candidateBook) {
        Set<Long> sourceTagIds = extractTagIds(sourceBook);
        if (sourceTagIds.isEmpty()) {
            return 0;
        }
        int count = 0;
        for (Long candidateTagId : extractTagIds(candidateBook)) {
            if (sourceTagIds.contains(candidateTagId)) {
                count++;
            }
        }
        return count;
    }

    private Comparator<Book> popularityComparator() {
        return Comparator
                .comparingLong((Book book) -> safeLong(book.getUsersRateCount())).reversed()
                .thenComparing((Book book) -> safeDouble(book.getRate()), Comparator.reverseOrder())
                .thenComparing((Book book) -> safeInt(book.getAvailableCopies()), Comparator.reverseOrder())
                .thenComparing(book -> safeString(book.getName()));
    }

    private long safeLong(Long value) {
        return value == null ? 0L : value;
    }

    private double safeDouble(Double value) {
        return value == null ? 0D : value;
    }

    private int safeInt(Integer value) {
        return value == null ? 0 : value;
    }

    private String safeString(String value) {
        return value == null ? "" : value;
    }

    private int sanitizeLimit(Integer limit, int fallback) {
        if (limit == null || limit < 1) {
            return fallback;
        }
        return Math.min(limit, 24);
    }

    private BookRecommendationShelfDto buildShelf(String key, String title, String description, List<Book> books) {
        return new BookRecommendationShelfDto(key, title, description, getTransformer().transformEntityToDto(books));
    }

    // free hosting cause leak algo speed for fetching
//    @Override
//    public List<BookDto> findAllRecommendedBooks() {
//        log.info("BookService: findAllRecommendedBooks() called");
//        UserDto currentUser = userService.getCurrentUser();
//        List<Book> books = collaborativeFilteringRecommender.recommendedBooks(currentUser.getId());
//        if (books.size() < MIN_OF_RECOMMENDED_BOOKS) {
//            books.addAll(getDao().findAllBooksByCategoriesAndLimit(
//                    userReadingInfoService.findUserReadingInfo().getUserBookCategories().stream().map(
//                    userBookCategoryDto -> userBookCategoryDto.getCategory().getName()
//            ).collect(Collectors.toList()), MIN_OF_RECOMMENDED_BOOKS - books.size()));
//        }
//        return getTransformer().transformEntityToDto(books);
//    }
}
