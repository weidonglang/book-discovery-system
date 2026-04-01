package com.henry.bookrecommendationsystem.transformer;

import com.henry.bookrecommendationsystem.dto.TagDto;
import com.henry.bookrecommendationsystem.entity.Tag;
import com.henry.bookrecommendationsystem.transformer.base.BaseTransformer;
import com.henry.bookrecommendationsystem.transformer.mapper.TagMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * @author Codex
 * @since 01/04/2026
 */
@Component
@AllArgsConstructor
public class TagTransformer implements BaseTransformer<Tag, TagDto, TagMapper> {
    private final TagMapper tagMapper;

    @Override
    public TagMapper getMapper() {
        return tagMapper;
    }
}
