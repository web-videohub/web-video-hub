package com.teamrocket.videohub.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class VideoUploadController {
    @GetMapping("/upload")
    public String uploadForm() {

        log.info("/upload GET");

        return "upload/upload-form";
    }
}
