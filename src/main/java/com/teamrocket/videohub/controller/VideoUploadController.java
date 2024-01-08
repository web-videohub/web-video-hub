package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.request.VideoUploadRequestDTO;
import com.teamrocket.videohub.services.VideoService;
import com.teamrocket.videohub.utils.upload.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class VideoUploadController {

    @Value("${file.uploadVideo.root-path}")
    private String rootVideoPath;

    @Value("${file.uploadThumbnail.root-path}")
    private String rootThumbnailPath;

    private final VideoService videoService;

    @GetMapping("/studio/upload")
    public String uploadForm() {

        log.info("/upload GET");

        return "upload/upload-form";
    }

    @PostMapping("/upload")
    public String uploadVideo(VideoUploadRequestDTO dto, HttpSession session, Model model) {
        log.debug("attached file name : {}", dto.getVideoUrl().getOriginalFilename());
        log.info("parameter : {}", dto);

        Map<String, String> map = FileUtil.uploadVideo(dto.getVideoUrl(), dto.getThumbnailUrl(), rootVideoPath, rootThumbnailPath);
        String videoPath = map.get("videoPath");
        String thumbnailPath = map.get("thumbnailPath");

        videoService.insertVideo(dto, session, videoPath, thumbnailPath);

        String keyword = "all";
        model.addAttribute("keyword", keyword);
        return "/studio";
    }
}
