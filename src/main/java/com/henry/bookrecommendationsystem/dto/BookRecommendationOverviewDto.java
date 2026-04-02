package com.henry.bookrecommendationsystem.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * @author Codex
 * @since 02/04/2026
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookRecommendationOverviewDto {
    private String title;
    private List<BookRecommendationShelfDto> shelves;
}
