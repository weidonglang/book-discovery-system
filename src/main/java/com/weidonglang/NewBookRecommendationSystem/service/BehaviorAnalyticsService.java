package com.weidonglang.NewBookRecommendationSystem.service;

import com.weidonglang.NewBookRecommendationSystem.dto.BehaviorDashboardDto;
import com.weidonglang.NewBookRecommendationSystem.dto.BehaviorLogEntryDto;
import com.weidonglang.NewBookRecommendationSystem.dto.BookActivityStatDto;
import com.weidonglang.NewBookRecommendationSystem.dto.BookDto;
import com.weidonglang.NewBookRecommendationSystem.dto.NamedCountStatDto;
import com.weidonglang.NewBookRecommendationSystem.dto.RecommendationStrategyDto;
import com.weidonglang.NewBookRecommendationSystem.dto.SearchKeywordStatDto;
import com.weidonglang.NewBookRecommendationSystem.dto.SearchLogEntryDto;

import java.util.List;

public interface BehaviorAnalyticsService {
    BehaviorDashboardDto buildDashboard(Integer limit, Integer recentDays);

    List<BehaviorLogEntryDto> findRecentBehaviorLogs(Integer limit);

    List<SearchLogEntryDto> findRecentSearchLogs(Integer limit);

    List<BehaviorLogEntryDto> findRecentBehaviorByUser(Long userId, Integer limit);

    List<BehaviorLogEntryDto> findRecentBehaviorByBook(Long bookId, Integer limit);

    List<SearchKeywordStatDto> findTopKeywords(Integer limit, Integer recentDays);

    List<BookActivityStatDto> findTopClickedBooks(Integer limit, Integer recentDays);

    List<BookActivityStatDto> findTopBorrowedBooks(Integer limit, Integer recentDays);

    List<NamedCountStatDto> findTopCategories(Integer limit, Integer recentDays);

    List<NamedCountStatDto> findTopAuthors(Integer limit, Integer recentDays);

    List<NamedCountStatDto> findTopTags(Integer limit, Integer recentDays);

    List<NamedCountStatDto> findTopPublishers(Integer limit, Integer recentDays);

    RecommendationStrategyDto getRecommendationStrategy(Integer recentDays);

    List<BookDto> findPopularBooks(Integer limit, Integer recentDays);
}
