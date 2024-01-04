package com.teamrocket.videohub;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
@Slf4j
public class ErrorController {

    @GetMapping("/404")
    public String error404() {
        log.warn("404에러임");
        return "error/error404";
    }

    @GetMapping("/500")
    public String error500() {
        log.error("500에러임 ㅅㄱ");
        return "error/error500";
    }
}
