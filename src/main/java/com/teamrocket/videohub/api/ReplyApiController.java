package com.teamrocket.videohub.api;

import com.teamrocket.videohub.common.Page;
import com.teamrocket.videohub.dto.request.ReplyModifyRequestDTO;
import com.teamrocket.videohub.dto.request.ReplyPostRequestDTO;
import com.teamrocket.videohub.dto.response.ReplyListResponseDTO;
import com.teamrocket.videohub.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/replies")
public class ReplyApiController {
    private final int PAGE_ROW_COUNT = 20;
    private final ReplyService replyService;

    // 댓글 목록 조회 요청
    @GetMapping("/{videoId}")
    public ResponseEntity<?> list(@PathVariable long videoId) {
        log.info("/api/v1/replies/{} : GET!", videoId);

        Page page = new Page();
        page.setPageNo(1);
        page.setAmount(20);

        ReplyListResponseDTO replies = replyService.getList(videoId, page);

        return ResponseEntity
                .ok()
                .body(replies)
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
            ReplyListResponseDTO responseDTO = replyService.register(dto, session);
            return ResponseEntity.ok().body(responseDTO);
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
            ReplyListResponseDTO responseDTO = replyService.delete(replyNo);

            return ResponseEntity
                    .ok()
                    .body(responseDTO)
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
            ReplyListResponseDTO responseDTO = replyService.modify(dto);
            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            log.warn("internal server error! caused by : {}", e.getMessage());
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

}
