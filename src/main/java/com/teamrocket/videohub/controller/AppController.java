package com.teamrocket.videohub.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class AppController {
    @RequestMapping("/")
    public String home() {
      log.info("어서오시고");

      return "index";
    }


    // 비디오 상세보기 요청 (/detail : GET)
    @GetMapping("/detail")
    public String detail(int videoId, @ModelAttribute("s")  Model model) {
        log.info("/board/detail : GET!");
        // model.addAttribute("b", videoService.getDetail(videoId));

        return "/detail";
    }
}
