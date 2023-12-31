package com.teamrocket.videohub.api;

import com.teamrocket.videohub.dto.request.EmotionPostRequestDTO;
import com.teamrocket.videohub.entity.Emotion;
import com.teamrocket.videohub.entity.Video;
import com.teamrocket.videohub.services.EmotionService;
import com.teamrocket.videohub.services.VideoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Objects;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/emotion")
public class EmotionApiController {
    private final EmotionService emotionService;
    private final VideoService videoService;

    // 좋아요, 싫어요 상태 조회 요청
    @GetMapping("/{videoId}")
    public ResponseEntity<?> emote(@PathVariable int videoId,
                                  @Validated @RequestParam String account) {
        log.info("/api/v1/emotion/{}?account={} : GET!", videoId, account);

        Emotion emotion = emotionService.getEmotion(videoId, account);

        log.info("emotion : {}", emotion);

        return ResponseEntity
                .ok()
                .body(Objects.requireNonNullElse(emotion, false))
                ;

    }

    // 좋아요, 싫어요 등록 요청 처리
    @PostMapping
    public ResponseEntity<?> addEmote(
            @Validated @RequestBody EmotionPostRequestDTO dto,
            BindingResult result,
            HttpSession session) {

        // 입력값 검증에 걸리면 400번 코드와 함께 메시지를 클라이언트에 전송
        if(result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString())
                    ;
        }

//        emotion.setUserAccount(((LoginUserResponseDTO) session.getAttribute(LOGIN_KEY)).getUserAccount());
        log.info("/api/v1/emotion : POST");
        log.warn("request parameter : {}", dto);

        try {
            emotionService.saveEmotion(dto); // emotion 정보를 집어넣는 부분
            Video video = videoService.getVideo(dto.getVideoId());
            dto.setLikeCount(video.getVideoLike());
            return ResponseEntity.ok().body(dto);
        } catch (SQLException e) {
            log.warn("500 status code response!! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    // 좋아요, 싫어요 삭제 요청 처리
    @DeleteMapping("/{videoId}/{account}/{likeCount}")
    public ResponseEntity<?> deleteEmote(@PathVariable int videoId,
                                         @PathVariable String account, @PathVariable int likeCount, HttpServletResponse response) {
        if (videoId == 0 || account == null) {
            return ResponseEntity
                    .badRequest()
                    .body("비디오 아이디와 계정명을 보내주세요!")
                    ;
        }

        log.info("/api/v1/replies/{}/{} : DELETE", videoId, account);

        try {
            Emotion emotion = emotionService.getEmotion(videoId, account);
            log.error("emotion : {}", emotion);
            log.error("like count : {}", emotion.getLikeCount());

            //emotion.setLikeCount();
            boolean flag = emotionService.delete(videoId, account);

            return ResponseEntity
                    .ok()
                    .body(emotion)
                    ;
        } catch (Exception e) {
            return ResponseEntity
                    .internalServerError()
                    .body(e.getMessage())
                    ;
        }
    }

    // 좋아요, 싫어요 상태 수정 요청 처리
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<?> update(
            @Validated @RequestBody EmotionPostRequestDTO dto
            , BindingResult result
    ) {
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }
        log.info("/api/v1/emote PUT/PATCH");
        log.debug("parameter: {}", dto);

        try {
            emotionService.modify(dto);
            Video video = videoService.getVideo(dto.getVideoId());
            dto.setLikeCount(video.getVideoLike());
            return ResponseEntity.ok().body(dto);
        } catch (Exception e) {
            log.warn("internal server error! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }
}
