package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.services.VideoService;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String home(
            Model model,
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "16") int pageSize,
            HttpSession session
    ) {
      log.info("어서오시고");

        List<Video> videos = videoService.getVideos(pageSize, pageNumber);

        Model vList = model.addAttribute("vList", videos);

        log.error("vList : {}", vList);

        return "index";
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

    @GetMapping("/detail")
    public String detail(int videoId, Model model) {
        log.info("비디오 상세 페이지");
        model.addAttribute("v", videoService.getDetail(videoId));
        return "detail";
    }
}
