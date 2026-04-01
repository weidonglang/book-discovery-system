package com.henry.bookrecommendationsystem.repository;

import com.henry.bookrecommendationsystem.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Codex
 * @since 01/04/2026
 */
@Repository
public interface TagRepository extends JpaRepository<Tag, Long> {
    List<Tag> findAllByMarkedAsDeletedFalseOrderByNameAsc();
}
