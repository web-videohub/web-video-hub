package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.request.VideoUploadRequestDTO;
import com.teamrocket.videohub.services.VideoService;
import com.teamrocket.videohub.utils.upload.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;

@Controller
@Slf4j
@RequiredArgsConstructor
public class VideoUploadController {

    @Value("${file.uploadVideo.root-path}")
    private String rootPath;

    private final VideoService videoService;

    @GetMapping("/studio/upload")
    public String uploadForm() {

        log.info("/upload GET");

        return "upload/upload-form";
    }

    @PostMapping("/upload")
    public String uploadVideo(VideoUploadRequestDTO dto, HttpSession session) {
        log.debug("attached file name : {}", dto.getVideoUrl().getOriginalFilename());
        log.info("parameter : {}", dto);

        String savePath = FileUtil.uploadVideo(dto.getVideoUrl(), rootPath);
        log.error("save path: {}", savePath);



        videoService.insertVideo(dto, session, savePath);
        return "studio";
    }
}
