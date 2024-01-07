package com.teamrocket.videohub.services;

import com.teamrocket.videohub.dto.request.VideoUploadRequestDTO;
import com.teamrocket.videohub.dto.response.VideoDetailResponseDTO;
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

    public void insertVideo(VideoUploadRequestDTO dto, HttpSession session, String videoPath, String thumbnailPath) {
        Video video = dto.toEntity(videoPath, thumbnailPath);
        video.setVideoUploadUser(LoginUtils.getCurrentLoginMemberAccount(session));
        videoMapper.save(video);
    }

    public List<Video> getVideos(int pageSize, int pageNumber, String type) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findAll(pageSize, offset, type);
    }

    public List<Video> getVideosDetail(int pageSize, int pageNumber, String type) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findAllDetail(pageSize, offset, type);
    }

    public Video getVideo(int videoId) {
        videoMapper.upViewCount(videoId);

        return videoMapper.findOne(videoId);
    }

    public List<Video> getVideoSearch(int pageSize, int pageNumber, String keyword) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findSearch(pageSize, offset, keyword);
    }

    public List<Video> getChannelVideos(int pageSize, int pageNumber, String type, String channelName) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findAllCh(pageSize, offset, type, channelName);
    }

    public List<Video> getVideosSub(int pageSize, int pageNumber, String type, String account) {
        int offset = (pageNumber - 1) * pageSize;
        return videoMapper.findAllSub(pageSize, offset, type, account);
    }

    public VideoDetailResponseDTO getVideoDetailInfo(int videoId) {
        videoMapper.upViewCount(videoId);

        Video video = videoMapper.findOneDetail(videoId);

        return new VideoDetailResponseDTO(video);
    }
}

