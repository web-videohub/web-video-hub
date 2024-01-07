package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.response.UserInfoResponseDTO;
import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.services.MemberService;
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
    private final MemberService memberService;

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

    @GetMapping("/loadMoreVideosSub")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideosSub(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type, String account
    ) {
        List<Video> videos = videoService.getVideosSub(pageSize, pageNumber, type, account);
        log.warn("구독한 채널의 영상들 : {}", videos);
        return ResponseEntity.ok(videos);
    }
    @GetMapping("/loadMoreVideosSub")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideosSub(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type, String account
    ) {
        List<Video> videos = videoService.getVideosSub(pageSize, pageNumber, type, account);
        log.warn("구독한 채널의 영상들 : {}", videos);
        return ResponseEntity.ok(videos);
    }

    @GetMapping("/loadMoreVideosDetail")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideosDetail(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type
    ) {
        List<Video> videos = videoService.getVideosDetail(pageSize, pageNumber, type);

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
        log.info("이거보세ㅐㅇ쇼!!!  :" + videos.toString());
        model.addAttribute("keyword", keyword);

        log.error("vList : {}", videos);

        return "/search";
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

    @GetMapping("/userPage")
    public String userPage(
            Model model,
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type,
            String channelName
    ) {
        log.info("유저 페이지");
        UserInfoResponseDTO user = memberService.getChannelInfo(channelName);
        List<Video> videos = videoService.getChannelVideos(pageSize, pageNumber, type, channelName);

        log.info("이거에용: {}", user);
//        log.info("이거에용: {}", channelName);
        model.addAttribute("user", user);
        model.addAttribute("vList", videos);

        return "userPage";
    }
}
