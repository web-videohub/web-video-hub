package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.services.VideoService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@AllArgsConstructor
public class AppController {

    private final VideoService videoService;

    @GetMapping("/")
    public String home() {
      //log.info("어서오시고");
      //
      //  List<Video> videos = videoService.getVideos(pageSize, pageNumber, type);
      //
      //  model.addAttribute("vList", videos);
      //
      //  log.error("videos : {}", videos);
        return "index";
    }

    @GetMapping("/loadMoreVideos")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideos(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type
    ) {
        log.error("type : {}", type);
        List<Video> videos = videoService.getVideos(pageSize, pageNumber, type);
        log.warn("videos : {}", videos);
        return ResponseEntity.ok(videos);
    }



    @GetMapping("/showmv")
    public String showmv(Model model, int videoId) {
        log.info("영상 채널");

        Video video = videoService.getVideo(videoId);

        model.addAttribute("v", video);

        return "/detail";
    }

    @GetMapping("/search")
    public String search(String keyword, Model model,
                         @RequestParam(defaultValue = "1") int pageNumber,
                         @RequestParam(defaultValue = "16") int pageSize,
                         HttpSession session) {
        log.info("/search Page: GET! {}", keyword);
        List<Video> videos = videoService.getVideoSearch(pageSize, pageNumber, keyword);

        log.error("videos : {}", videos);
        model.addAttribute("vList", videos);
        model.addAttribute("keyword", keyword);

        return "/index";
    }

    @RequestMapping("/setting")
    public String setting() {
        log.info("설정페이지");

        return "setting";

    }

    @GetMapping("/subs")
    public String subs() {
        log.info("구독 현황 페이지");

        return "subs";
    }
}
