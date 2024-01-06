package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Video;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface VideoMapper {
    void save(Video video);

    Video findOne(int videoId);

    List<Video> findAll(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type);

    void upViewCount(int videoId);

    void upLikeCount(int videoId);

    void downLikeCount(int videoId);

    List<Video> findSearch(@Param("pageSize") int pageSize, @Param("offset") int offset, String keyword);

    List<Video> findAllCh(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type, String channelName);

    List<Video> findAllSub(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type, String account);
}
