package com.henry.bookrecommendationsystem.service;

import com.henry.bookrecommendationsystem.dao.BookDao;
import com.henry.bookrecommendationsystem.dto.BookDto;
import com.henry.bookrecommendationsystem.dto.BookFilterPaginationRequest;
import com.henry.bookrecommendationsystem.dto.TagDto;
import com.henry.bookrecommendationsystem.dto.base.pagination.FilterPaginationRequest;
import com.henry.bookrecommendationsystem.dto.base.response.PaginationResponse;
import com.henry.bookrecommendationsystem.entity.Book;
import com.henry.bookrecommendationsystem.transformer.BookTransformer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.util.LinkedHashSet;
import java.util.List;
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
    private final BookTransformer bookTransformer;
    private final BookDao bookDao;
    private final AuthorService authorService;
    private final BookCategoryService bookCategoryService;
    private final PublisherService publisherService;
    private final TagService tagService;
    private final UserReadingInfoService userReadingInfoService;

    @Autowired
    public BookServiceImpl(BookTransformer bookTransformer, BookDao bookDao, AuthorService authorService, BookCategoryService bookCategoryService, PublisherService publisherService, TagService tagService, UserReadingInfoService userReadingInfoService) {
        this.bookTransformer = bookTransformer;
        this.bookDao = bookDao;
        this.bookCategoryService = bookCategoryService;
        this.publisherService = publisherService;
        this.tagService = tagService;
        this.userReadingInfoService = userReadingInfoService;
        this.authorService = authorService;
    }

    public BookServiceImpl(BookTransformer bookTransformer, BookDao bookDao, AuthorService authorService, UserReadingInfoService userReadingInfoService) {
        this(bookTransformer, bookDao, authorService, null, null, null, userReadingInfoService);
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
        return getTransformer().transformEntityToDto(getDao().create(getTransformer().transformDtoToEntity(dto)));
    }

    @Override
    public BookDto update(BookDto dto, Long id) {
        log.info("BookService: update() called");
        Optional<Book> book = getDao().findById(id);
        if (book.isEmpty())
            throw new EntityExistsException("Book not found for id: " + id);

        normalizeBookRelations(dto);
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
        return getTransformer().transformEntityToDto(getDao().findAllBooksByCategoriesAndLimit(
                userReadingInfoService.findUserReadingInfo().getUserBookCategories().stream().map(
                        userBookCategoryDto -> userBookCategoryDto.getCategory().getName()
                ).collect(Collectors.toList()), MIN_OF_RECOMMENDED_BOOKS));
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
