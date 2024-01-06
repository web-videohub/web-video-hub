package com.teamrocket.videohub.dto.response;

import lombok.*;

import java.util.List;

@Setter @Getter @ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyListResponseDTO {
    private int count; // 총 댓글 수
    private List<ReplyDetailResponseDTO> replies; // 실제 댓글 리스트
}
