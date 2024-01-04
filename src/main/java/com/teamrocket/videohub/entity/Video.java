package com.teamrocket.videohub.entity;

import com.teamrocket.videohub.dto.request.VideoUploadRequestDTO;
import lombok.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;

@ToString
@Getter
@Setter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Video {

    private int videoId;
    private LocalDateTime videoUploadDate;
    private String videoUploadUser;
    private int videoLike;
    private int videoHate;
    private String videoTitle;
    private String videoContent;
    @Setter
    private String videoCategory;
    private int videoViewCount;

    @Setter
    private String videoUrl;

    @Setter
    private String thumbnailUrl;

    private String userProfileImage;

    public Video(VideoUploadRequestDTO dto) {
        convertInputData(dto);
        timeFormat();
        this.videoId = getVideoId();
        this.videoViewCount = getVideoViewCount();
    }

    public Video(ResultSet rs) throws SQLException {
        this.videoId = rs.getInt("video_id");
        this.videoUploadDate = rs.getTimestamp("video_upload_date").toLocalDateTime();
        this.videoUploadUser = rs.getString("video_upload_user");
        this.videoLike = rs.getInt("video_like");
        this.videoHate = rs.getInt("video_hate");
        this.videoTitle = rs.getString("video_title");
        this.videoContent = rs.getString("video_content");
        this.videoCategory = rs.getString("video_category");
        this.videoViewCount = rs.getInt("video_view_count");
        this.videoUrl = rs.getString("video_url");
        this.userProfileImage = rs.getString("user_profile_image");
    }

    private void timeFormat() {
        this.videoUploadDate = LocalDateTime.now();
    }

    private void convertInputData(VideoUploadRequestDTO dto) {
        this.videoTitle = dto.getVideoTitle();
        this.videoContent = dto.getVideoContent();
    }
}
