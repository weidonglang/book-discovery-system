package com.weidonglang.NewBookRecommendationSystem.service;

import com.weidonglang.NewBookRecommendationSystem.dto.BookSearchResponseDto;

public interface ResourceSearchService {
    BookSearchResponseDto searchByBm25(String query, Integer limit);

    BookSearchResponseDto searchResources(String query, Integer limit);
}
