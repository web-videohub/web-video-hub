package com.teamrocket.videohub.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;

@RestController
@RequestMapping("/api/images")
public class ImageController {

    @Value("${file.upload.root-path}")
    private String imagePath;

    @GetMapping("/{imageName:.+}")
    public ResponseEntity<FileSystemResource> getImage(@PathVariable String imageName) {

        String filaPath = imagePath + "/" +imageName;

        FileSystemResource resource = new FileSystemResource(new File(filaPath));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);

        return ResponseEntity.ok()
                .headers(headers)
                .body(resource);
    }
}
