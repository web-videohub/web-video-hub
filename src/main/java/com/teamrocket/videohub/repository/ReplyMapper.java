package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.dto.response.ReplyListResponseDTO;
import com.teamrocket.videohub.entity.Reply;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyMapper {

    // 댓글 등록
    boolean save(Reply reply);

    // 댓글 수정
    boolean modify(Reply reply);

    // 댓글 삭제
    boolean delete(long replyNo);

    // 댓글 개별 조회
    Reply findOne(long replyNo);

    // 댓글 전체 목록 조회
    ReplyListResponseDTO findAll(long videoId, int pageSize, int offset);

    // 댓글 총 개수 조회
    int count(long videoId);
}
