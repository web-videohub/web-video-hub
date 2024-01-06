package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Emotion;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmotionMapper {
    boolean save(int videoId, String userAccount, int videoLike, int videoHate);

    Emotion findOne(int videoId, String userAccount);

    boolean modify(int videoId, String userAccount, int videoLike, int videoHate);

    boolean delete(long emotionId);
}
