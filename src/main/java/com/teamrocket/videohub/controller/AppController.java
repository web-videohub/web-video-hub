package com.teamrocket.videohub.controller;

import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.repository.VideoMapper;
import com.teamrocket.videohub.services.VideoService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@AllArgsConstructor
public class AppController {

    private final VideoService videoService;
    private final VideoMapper videoMapper;

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
        log.error("type : {}", type);
        List<Video> videos = videoService.getVideos(pageSize, pageNumber, type);
        log.warn("videos : {}", videos);
        return ResponseEntity.ok(videos);
    }

    @GetMapping("/loadMyVideoInfo")
    @ResponseBody
    public ResponseEntity<List<Video>> loadMyVideoInfo(
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize,
            String type,
            String account
    ) {
        List<Video> mine = videoService.findMine(pageSize, pageNumber, type, account);
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
    public String showmv(
            Model model
            , int videoId
    ) {
        log.info("영상 채널");

        Video video = videoService.getVideo(videoId);

        model.addAttribute("v", video);

        log.error("videos : {}", video);

        return "detail";
    }
  
    @GetMapping("/search")
    public String search(String keyword, Model model) {
        log.info("/search Page: GET! {}", keyword);

        List<Video> videos = videoService.getVideoSearch(pageSize, pageNumber, keyword);

        model.addAttribute("vList", videos);
        log.info("이거보세ㅐㅇ쇼!!!  :" + videos.toString());
        model.addAttribute("keyword", keyword);
        return "/search";
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


//     @GetMapping("/detail")
//     public String detail(int videoId, Model model) {
//         log.info("비디오 상세 페이지");
//         model.addAttribute("v", videoService.getDetail(videoId));
//         return "detail";

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
            String type

    ) {
        log.info("유저 페이지");

          List<Video> videos = videoService.getVideos(pageSize, pageNumber, type);

          model.addAttribute("vList", videos);

        return "userPage";
    }
}
