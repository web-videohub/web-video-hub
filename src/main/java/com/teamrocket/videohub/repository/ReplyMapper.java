package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.dto.response.ReplyDetailResponseDTO;
import com.teamrocket.videohub.entity.Reply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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
    List<Reply> findAll(@Param("videoId") long videoId, @Param("pageSize") int pageSize, @Param("offset") int offset);

    // 댓글 총 개수 조회
    int count(long videoId);
}
