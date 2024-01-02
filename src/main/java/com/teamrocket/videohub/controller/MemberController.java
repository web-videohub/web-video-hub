package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.request.LoginRequestDTO;
import com.teamrocket.videohub.dto.request.SignUpRequestDTO;
import com.teamrocket.videohub.repository.MemberMapper;
import com.teamrocket.videohub.services.LoginResult;
import com.teamrocket.videohub.services.MemberService;
import com.teamrocket.videohub.utils.upload.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;

import static com.teamrocket.videohub.services.LoginResult.*;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String login() {
        log.info("/login GET");

        return "members/sign-in";
    }

    @PostMapping("/login")
    public String login(
            LoginRequestDTO dto,
            RedirectAttributes ra,
            HttpServletResponse response,
            HttpServletRequest request
    ) {

        log.info("/members/sign-in POST!");
        log.info("parameter : {}", dto);

        LoginResult result = memberService.authenticate(dto, request.getSession(), response);
        log.info("parameter: {}", dto);

        ra.addFlashAttribute("msg", result);

        if(result == SUCCESS) {
            memberService.maintainLoginState(request.getSession(), dto.getUserAccount());

            return "redirect:/";
        }
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String register() {
        return "/members/sign-up";
    }

    @GetMapping("/check")
    @ResponseBody
    public ResponseEntity<?> check(String type, String keyword) {
        log.info("/members/check?type={}&keyword={} ASYNC GET", type, keyword);
        boolean flag = memberService.checkDuplicateValue(type, keyword);
        return ResponseEntity.ok().body(flag);
    }

    @GetMapping("/modify")
    @ResponseBody
    public ResponseEntity<?> consistent(String account, String email) {
        log.info("member/modify{}{}", account, email);
        boolean flag = memberService.checkConsistentValue(account, email);
        log.info("중복체크 결과: {}", flag);
        return ResponseEntity.ok().body(flag);
    }

    @PostMapping("/register")
    public String register(SignUpRequestDTO dto, @RequestParam("thumbnail")MultipartFile file) {
        log.info("file-name : {}", file.getOriginalFilename());
        log.info("file-size : {}KB", file.getSize() / 1024.0);
        log.info("file-type : {}", file.getContentType());

        String rootPath = "/Users/yongseopkim/Desktop/videoHub/upload/profile";
        File root = new File(rootPath);

        if(!root.exists()) root.mkdirs();

        String uploadedFilePath = FileUtil.uploadFile(file, rootPath);

        dto.setUserProfileImg(uploadedFilePath);
        log.info("file path : {}", uploadedFilePath);
        log.info("parameter : {}", dto);


        boolean flag = memberService.join(dto);
        return flag ? "redirect:/login" : "redirect:/register";
    }

    @GetMapping("/find-pw")
    public String findPassword() {
        System.out.println("비밀번호 찾기 화면");

        return "/members/findx-pw";
    }
    @PostMapping("/find-pw")
    public String findPw() {
        System.out.println("비밀번호 찾기 처리");

        return "";
    }

}
