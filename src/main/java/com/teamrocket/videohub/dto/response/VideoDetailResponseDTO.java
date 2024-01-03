package com.teamrocket.videohub.dto.response;

import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.util.DateUtils;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter @ToString
@EqualsAndHashCode
public class VideoDetailResponseDTO {
    private final int videoId;
    private final String uploadUser;
    private final String uploadUserDisplayName;
    private final String uploadUserProfileImage;
    private final String videoTitle;
    private final String uploadDate;
    private final String videoContent;
    private final String videoCategory;
    private final String videoUrl;
    private final int videoLike;
    private final int videoViewCount;

    public VideoDetailResponseDTO(Video video) {
        this.videoId = video.getVideoId();
        this.uploadUser = video.getVideoUploadUser();
        this.uploadUserDisplayName = video.getUserDisplayName();
        this.uploadUserProfileImage = video.getUploadUserProfileImage();
        this.uploadDate = DateUtils.makePrettierDateString(video.getVideoUploadDate());
        this.videoTitle = video.getVideoTitle();
        this.videoContent = video.getVideoContent();
        this.videoCategory = video.getVideoCategory();
        this.videoUrl = video.getVideoUrl();
        this.videoLike = video.getVideoLike();
        this.videoViewCount = video.getVideoViewCount();
    }
}
