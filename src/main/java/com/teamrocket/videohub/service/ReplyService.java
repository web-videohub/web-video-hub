package com.teamrocket.videohub.service;

import com.teamrocket.videohub.common.Page;
import com.teamrocket.videohub.common.PageMaker;
import com.teamrocket.videohub.dto.request.ReplyModifyRequestDTO;
import com.teamrocket.videohub.dto.request.ReplyPostRequestDTO;
import com.teamrocket.videohub.dto.response.ReplyDetailResponseDTO;
import com.teamrocket.videohub.dto.response.ReplyListResponseDTO;
import com.teamrocket.videohub.entity.Member;
import com.teamrocket.videohub.entity.Reply;
import com.teamrocket.videohub.repository.MemberMapper;
import com.teamrocket.videohub.repository.ReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.ListIterator;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReplyService {
    private final MemberMapper memberMapper;
    private final ReplyMapper replyMapper;

    // 댓글 목록 조회
    public ReplyListResponseDTO getList(long videoId, Page page) {

        // DB에서 댓글 정보 조회
        List<ReplyDetailResponseDTO> replies = replyMapper.findAll(videoId, page)
                .stream()
                .map(ReplyDetailResponseDTO::new)
                .collect(Collectors.toList());

        for (ReplyDetailResponseDTO reply : replies) {
            Member member = memberMapper.findMember(reply.getAccount());
            reply.setAccountUserName(member.getUserDisplayName());
            reply.setProfile(member.getUserProfileImage());
        }

        // DB에서 총 댓글 수 조회
        int count = replyMapper.count(videoId);

        return ReplyListResponseDTO.builder()
                .replies(replies)
                .count(count)
                .pageInfo(new PageMaker(page, count))
                .build();
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
        return getList(dto.getVideoId(), new Page(1, 5));
    }

    // 댓글 삭제
    @Transactional // 트랜잭션(예외처리) 자동화
    public ReplyListResponseDTO delete(long replyNo) throws Exception {
        Reply reply = replyMapper.findOne(replyNo);
        long videoId = reply.getVideoId();

        replyMapper.delete(replyNo);

        return getList(videoId, new Page(1, 20));
    }

    // 댓글 수정 처리
    public ReplyListResponseDTO modify(ReplyModifyRequestDTO dto) throws Exception {

        replyMapper.modify(dto.toEntity());

        return getList(dto.getVideoId(), new Page(1, 20));
    }
}
