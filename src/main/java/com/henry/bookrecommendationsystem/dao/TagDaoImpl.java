package com.henry.bookrecommendationsystem.dao;

import com.henry.bookrecommendationsystem.entity.Tag;
import com.henry.bookrecommendationsystem.repository.TagRepository;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Codex
 * @since 01/04/2026
 */
@Component
public class TagDaoImpl implements TagDao {
    private final TagRepository tagRepository;

    public TagDaoImpl(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    @Override
    public TagRepository getRepository() {
        return tagRepository;
    }

    @Override
    public List<Tag> findAllActive() {
        return getRepository().findAllByMarkedAsDeletedFalseOrderByNameAsc();
    }
}
