package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.dto.response.UserInfoResponseDTO;
import com.teamrocket.videohub.dto.response.VideoDetailResponseDTO;
import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.repository.VideoMapper;
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
    private final VideoMapper videoMapper;
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

    @GetMapping("/loadMoreVideos")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideos(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type
    ) {
        List<Video> videos = videoService.getVideos(pageSize, pageNumber, type);

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

    @GetMapping("/loadMyVideoInfo")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMyVideoInfo(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type, String account, String keyword
    ) {
        log.info("들어온 스튜디오 검색어는?: {}", keyword);
        List<Video> mine = videoService.findMine(pageSize, pageNumber, type, account, keyword);
        log.info("mine : {}", mine);

        return ResponseEntity.ok(mine);
    }

    @DeleteMapping("/delete-checked-video")
    public ResponseEntity<?> deleteVideos(@RequestBody List<Integer> videoIds) {
        log.info("요청 옴?");
        videoMapper.deleteVideos(videoIds);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/showmv")
    public String showmv(Model model, int videoId) {
        log.info("영상 채널");

        VideoDetailResponseDTO dto = videoService.getVideoDetailInfo(videoId);

        log.warn("VideoDetailResponseDTO : {}", dto);

        model.addAttribute("v", dto);

        return "/detail";
    }

    @GetMapping("/search")
    public String search(String keyword, Model model) {
        log.info("/search Page: GET! {}", keyword);
        model.addAttribute("keyword", keyword);
        if (keyword.isEmpty()) {
            return "/index";
        }
        return "/search";
    }
    @GetMapping("/searchStudio")
    public String searchStudio(String keyword, Model model) {
        log.info("스튜디오 검색어: {}", keyword);
        String re_key = "";
        if (keyword.isEmpty()) {
            re_key = "all";
        } else {
            re_key = keyword;
        }
        model.addAttribute("keyword", re_key);

        return "/studio";
    }

    @GetMapping("/loadSearch")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMoreVideosSearch(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type, String keyword
    ) {
        List<Video> videos = videoService.getVideoSearch(pageSize, pageNumber, type, keyword);
        log.info("검색된 영상들: {}", videos);
        return ResponseEntity.ok(videos);
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
