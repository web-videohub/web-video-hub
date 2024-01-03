package com.teamrocket.videohub.services;

import com.teamrocket.videohub.dto.request.VideoUploadRequestDTO;
import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.repository.VideoMapper;
import com.teamrocket.videohub.utils.LoginUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class VideoService {

    private final VideoMapper videoMapper;

    public void insertVideo(VideoUploadRequestDTO dto, HttpSession session, String savePath) {
        Video video = dto.toEntity(savePath);
        video.setVideoUploadUser(LoginUtils.getCurrentLoginMemberAccount(session));
        videoMapper.save(video);
    }

    public List<Video> getVideos(int pageSize, int pageNumber) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findAll(pageSize, offset);
    }
}

