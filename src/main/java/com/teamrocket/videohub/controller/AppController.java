package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.services.VideoService;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@AllArgsConstructor
public class AppController {

    private final VideoService videoService;

    @GetMapping("/")
    public String home(
            Model model,
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize
    ) {
      log.info("어서오시고");

        List<Video> videos = videoService.getVideos(pageSize, pageNumber);

        model.addAttribute("vList", videos);

        log.error("videos : {}", videos);

        return "index";
    }

    @GetMapping("/loadMoreVideos")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideos(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize
    ) {
        List<Video> videos = videoService.getVideos(pageSize, pageNumber);
        return ResponseEntity.ok(videos);
    }

    @RequestMapping("/showmv")
    public String showmv() {
        log.info("영상 채널");

        return "detail";
    }

    @RequestMapping("/setting")
    public String setting() {
        log.info("설정페이지");

        return "setting";

    }
}
