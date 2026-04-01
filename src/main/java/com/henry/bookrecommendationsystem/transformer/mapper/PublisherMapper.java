package com.henry.bookrecommendationsystem.transformer.mapper;

import com.henry.bookrecommendationsystem.dto.PublisherDto;
import com.henry.bookrecommendationsystem.entity.Publisher;
import com.henry.bookrecommendationsystem.transformer.mapper.base.BaseMapper;
import com.henry.bookrecommendationsystem.transformer.mapper.base.GenericMapperConfiguration;
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;

/**
 * @author Codex
 * @since 01/04/2026
 */
@Mapper(componentModel = "spring", injectionStrategy = InjectionStrategy.CONSTRUCTOR, config = GenericMapperConfiguration.class)
public interface PublisherMapper extends BaseMapper<Publisher, PublisherDto> {
}
