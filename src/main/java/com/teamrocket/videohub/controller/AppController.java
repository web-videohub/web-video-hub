package com.teamrocket.videohub.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class AppController {
    @RequestMapping("/")
    public String home() {
      log.info("어서오시고");

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
}
