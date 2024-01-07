package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Video;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

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

    List<Video> findMyVideo(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type, @Param("account") String account);

    void deleteVideos(List<Integer> videoIds);

    List<Video> findAllCh(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type, String channelName);

    List<Video> findAllSub(@Param("pageSize") int pageSize, @Param("offset") int offset, @Param("type") String type, String account);
}
