package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.request.LoginRequestDTO;
import com.teamrocket.videohub.dto.request.SignUpRequestDTO;
import com.teamrocket.videohub.dto.response.LoginUserResponseDTO;
import com.teamrocket.videohub.entity.Member;
import com.teamrocket.videohub.repository.MemberMapper;
import com.teamrocket.videohub.services.LoginResult;
import com.teamrocket.videohub.services.MemberService;
import com.teamrocket.videohub.utils.upload.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import static com.teamrocket.videohub.services.LoginResult.*;
import static com.teamrocket.videohub.utils.LoginUtils.LOGIN_KEY;
import static com.teamrocket.videohub.utils.LoginUtils.isLogin;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @Value("${file.upload.root-path}")
    private String rootPath;

    private String uri;

    @GetMapping("/login")
    public String login(HttpServletRequest request,
                        Model model) {
        log.info("/login GET");

        uri = request.getHeader("Referer");
        if (uri != null && !uri.contains("/login")) {
            request.getSession().setAttribute("prevPage", uri);
        }

        log.info("uri : {}", uri);

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

            String prevPage = (String) request.getSession().getAttribute("prevPage");
            if(prevPage != null && !prevPage.isEmpty()) {
                return "redirect:" + prevPage;
            } else {
                return "redirect:/";
            }
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
    public String register(SignUpRequestDTO dto) {
        String savePath = FileUtil.uploadFile(dto.getProfileImage(), rootPath);
        log.warn("file : {}", dto.getProfileImage());

        boolean flag = memberService.join(dto, savePath);
        return flag ? "redirect:/login" : "redirect:/register";
    }

    @GetMapping("/find-pw")
    public String findPassword() {
        System.out.println("비밀번호 찾기 화면");

        return "/members/find-pw";
    }
    @PostMapping("/find-pw")
    public String findPw(String newPassword, String account) {
        System.out.println("비밀번호 찾기 처리");

        log.info("new password : {}", newPassword);
        log.info("modify by account : {}", account);

        memberService.modifyPassword(account, newPassword);

        return "redirect:/login";
    }

    @GetMapping("/log-out")
    public String logOut(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        if(isLogin(session)) {
            session.removeAttribute(LOGIN_KEY);

            session.invalidate();
            return "redirect:/";
        }

        return "redirect:/members/login";
    }

    @GetMapping("/update")
    public String updateNickname(String account, String nickname, HttpSession session, LoginUserResponseDTO dto) {
        log.error("account : {}, nickname : {}", account, nickname);
        memberService.updateNickname(account, nickname);
        log.warn("session: {}", session.getAttribute(LOGIN_KEY));
        Member member = memberService.getMember(account);
        log.info("member: {}", member);

        LoginUserResponseDTO build = LoginUserResponseDTO.builder()
                .userAccount(member.getUserAccount())
                .userAuth(member.getUserAuth().name())
                .userEmail(member.getUserEmail())
                .userDisplayName(member.getUserDisplayName())
                .userProfile(member.getUserProfileImage())
                .build();

        session.setAttribute(LOGIN_KEY, build);

        return "redirect:/setting";
    }

}
