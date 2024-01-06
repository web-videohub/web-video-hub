package com.teamrocket.videohub.api;

import com.teamrocket.videohub.dto.request.EmotionPostRequestDTO;
import com.teamrocket.videohub.dto.response.LoginUserResponseDTO;
import com.teamrocket.videohub.entity.Emotion;
import com.teamrocket.videohub.service.EmotionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.concurrent.ExecutionException;

import static com.teamrocket.videohub.utils.LoginUtils.LOGIN_KEY;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/emotion")
public class EmotionApiController {
    private final EmotionService emotionService;

    // 좋아요, 싫어요 상태 조회 요청
    @GetMapping("/{videoId}")
    public ResponseEntity<?> emote(@PathVariable int videoId,
                                  @Validated @RequestParam LoginUserResponseDTO dto) {
        log.info("/api/v1/emotion/{} : GET!", videoId);

        Emotion emotion = emotionService.getEmotion(videoId, dto.getUserAccount());

        if(emotion == null)
            return null;

        return ResponseEntity
                .ok()
                .body(emotion)
                ;
    }

    // 좋아요, 싫어요 등록 요청 처리
    @PostMapping()
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
        log.info("request parameter : {}", dto);
        log.debug("request parameter : {}", dto);

        try {
            emotionService.saveEmotion(new Emotion("smg0218", 1, dto.getVideoLike(), dto.getVideoHate())); // emotion 정보를 집어넣는 부분
            return ResponseEntity.ok().body(dto);
        } catch (SQLException e) {
            log.warn("500 status code response!! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
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
            return ResponseEntity.ok().body(dto);
        } catch (Exception e) {
            log.warn("internal server error! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }
}