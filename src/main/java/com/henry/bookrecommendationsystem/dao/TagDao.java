package com.henry.bookrecommendationsystem.dao;

import com.henry.bookrecommendationsystem.dao.base.BaseDao;
import com.henry.bookrecommendationsystem.entity.Tag;
import com.henry.bookrecommendationsystem.repository.TagRepository;

import java.util.List;

/**
 * @author Codex
 * @since 01/04/2026
 */
public interface TagDao extends BaseDao<Tag, TagRepository> {
    List<Tag> findAllActive();
}
