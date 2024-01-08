package com.teamrocket.videohub.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class LocalResourceConfig implements WebMvcConfigurer {

    @Value("${file.uploadVideo.root-path}")
    private String rootPath;

    @Value("${file.upload.root-path}")
    private String imageRootPath;

    @Value("${file.uploadThumbnail.root-path}")
    private String rootThumbnailPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/local/**")
                .addResourceLocations("file:" + rootPath, "file:" + imageRootPath, "file:" + rootThumbnailPath);

    }
}
