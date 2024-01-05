package com.teamrocket.videohub.dto.request;

import com.teamrocket.videohub.entity.Video;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

@EqualsAndHashCode
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VideoUploadRequestDTO {

    private String videoTitle;
    private String videoContent;

    @NotBlank
    private String videoCategory;
    private MultipartFile videoUrl;
    private MultipartFile thumbnailUrl;

    public Video toEntity(String videoPath, String thumbnailPath) {
        return Video.builder()
                .videoTitle(videoTitle)
                .videoContent(videoContent)
                .videoCategory(videoCategory)
                .videoUrl(videoPath)
                .thumbnailUrl(thumbnailPath)
                .build();
    }
}
