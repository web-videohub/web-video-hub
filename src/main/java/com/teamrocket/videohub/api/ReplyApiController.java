package com.teamrocket.videohub.api;

import com.teamrocket.videohub.dto.request.ReplyModifyRequestDTO;
import com.teamrocket.videohub.dto.request.ReplyPostRequestDTO;
import com.teamrocket.videohub.dto.response.ReplyDetailResponseDTO;
import com.teamrocket.videohub.entity.Reply;
import com.teamrocket.videohub.services.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/replies")
public class ReplyApiController {
    private final ReplyService replyService;

    // 댓글 목록 조회 요청
    @GetMapping("/{videoId}")
    public ResponseEntity<?> list(
            @PathVariable long videoId,
            @RequestParam(defaultValue = "1") int pageNumber,
            @RequestParam(defaultValue = "12") int pageSize) {

        log.info("/api/v1/replies/{}?pageNumber={}&pageSize={} : GET!", videoId, pageSize, pageNumber);

        List<ReplyDetailResponseDTO> replyList = replyService.getReplyList(videoId, pageSize, pageNumber);

        log.warn("replies : {}", replyList);

        return ResponseEntity
                .ok()
                .body(replyList)
                ;
    }

    // 댓글 등록 요청 처리
    @PostMapping
    public ResponseEntity<?> create(@Validated @RequestBody ReplyPostRequestDTO dto
    , BindingResult result
    , HttpSession session) {
        if(result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }

        log.info("/api/v1/replies : POST");
        log.debug("reuqest parameter : {}", dto);

        try {
            List<ReplyDetailResponseDTO> replyList = replyService.register(dto, session);
            return ResponseEntity.ok().body(replyList);
        } catch (SQLException e) {
            log.warn("500 status code response!! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    // 댓글 삭제
    @DeleteMapping("/{replyNo}")
    public ResponseEntity<?> remove(@PathVariable Long replyNo) {
        if (replyNo == null) {
            return ResponseEntity
                    .badRequest()
                    .body("댓글 번호를 보내주세요!")
                    ;
        }

        log.info("/api/v1/replies/{} : DELETE", replyNo);

        try {
            List<ReplyDetailResponseDTO> replyList = replyService.delete(replyNo);

            return ResponseEntity
                    .ok()
                    .body(replyList)
                    ;
        } catch (Exception e) {
            return ResponseEntity
                    .internalServerError()
                    .body(e.getMessage())
                    ;
        }
    }
    
    
    // 댓글 수정
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<?> update(
            @Validated @RequestBody ReplyModifyRequestDTO dto
            , BindingResult result) {
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString())
                    ;
        }
        log.info("/api/v1/replies PUT/PATCH");
        log.debug("parameter: {}", dto);

        try {
            List<ReplyDetailResponseDTO> replyList = replyService.modify(dto);
            return ResponseEntity.ok().body(replyList);
        } catch (Exception e) {
            log.warn("internal server error! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

}
