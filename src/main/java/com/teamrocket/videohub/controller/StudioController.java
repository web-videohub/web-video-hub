package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.response.LoginUserResponseDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

import static com.teamrocket.videohub.utils.LoginUtils.LOGIN_KEY;

@Controller
@Slf4j
public class StudioController {

    @GetMapping("/studio")
    public String studio(HttpSession session) {

        LoginUserResponseDTO loginUser = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);
        log.info("/studio GET");


        return "studio";
    }

}
