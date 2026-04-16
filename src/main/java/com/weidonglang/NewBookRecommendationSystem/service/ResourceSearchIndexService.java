package com.weidonglang.NewBookRecommendationSystem.service;

public interface ResourceSearchIndexService {
    long rebuildResourceIndex();

    void indexResource(Long resourceId);
}
