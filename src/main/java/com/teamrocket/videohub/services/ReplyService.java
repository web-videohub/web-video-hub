package com.teamrocket.videohub.services;

import com.teamrocket.videohub.dto.request.ReplyModifyRequestDTO;
import com.teamrocket.videohub.dto.request.ReplyPostRequestDTO;
import com.teamrocket.videohub.dto.response.ReplyListResponseDTO;
import com.teamrocket.videohub.entity.Reply;
import com.teamrocket.videohub.repository.MemberMapper;
import com.teamrocket.videohub.repository.ReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReplyService {
    private final MemberMapper memberMapper;
    private final ReplyMapper replyMapper;

    // 댓글 목록 조회
    public ReplyListResponseDTO getReplyList(long videoId, int pageSize, int pageNumber) {
        int offset = (pageNumber - 1) * pageSize;
        return replyMapper.findAll(videoId, pageSize, offset);
    }

    // 댓글 등록 서비스
    public ReplyListResponseDTO register(ReplyPostRequestDTO dto, HttpSession session) throws SQLException {
        log.debug("댓글 등록 서비스 실행!");

        // dto를 entity로 변환
        Reply reply = dto.toEntity();
//        reply.setAccount(getCurrentLoginMemberAccount(session));

        boolean flag = replyMapper.save(reply);

        if(!flag) {
            log.warn("댓글 등록 실패!");
            throw new SQLException("댓글 저장 실패!");
        }

        // 등록이 성공하면 새롭게 갱신된 1페이지 댓글 내용을 재 조회해서 응답한다.
        return getReplyList(dto.getVideoId(), 1, 12);
    }

    // 댓글 삭제
    @Transactional // 트랜잭션(예외처리) 자동화
    public ReplyListResponseDTO delete(long replyNo) throws Exception {
        Reply reply = replyMapper.findOne(replyNo);
        long videoId = reply.getVideoId();

        replyMapper.delete(replyNo);

        return getReplyList(videoId, 1, 12);
    }

    // 댓글 수정 처리
    public ReplyListResponseDTO modify(ReplyModifyRequestDTO dto) throws Exception {

        replyMapper.modify(dto.toEntity());

        return getReplyList(dto.getVideoId(), 1, 12);
    }
}
