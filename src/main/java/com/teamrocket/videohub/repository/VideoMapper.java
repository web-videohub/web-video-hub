package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Video;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VideoMapper {
    void save(Video video);

    Video findOne(int videoId);

    void upviewCount(int videoId);


}
