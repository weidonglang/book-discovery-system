package com.henry.bookrecommendationsystem.dto;

import com.henry.bookrecommendationsystem.dto.base.BaseDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author Codex
 * @since 01/04/2026
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PublisherDto extends BaseDto {
    private Long id;
    private String name;
    private String description;
    private String country;
    private String websiteUrl;
}
