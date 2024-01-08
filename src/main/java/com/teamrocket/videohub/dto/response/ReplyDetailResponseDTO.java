package com.teamrocket.videohub.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.teamrocket.videohub.entity.Reply;
import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Setter @Getter @ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReplyDetailResponseDTO {
    private long rno;
    private String text;

    @JsonFormat(pattern = "yyyy년 MM월 dd일 HH:MM")
    private LocalDateTime regDate;
    private String account;
    private String accountUserName;
    private String profile;

    // 엔티티를 DTO로 바꿔주는 메서드(생성자)
    public ReplyDetailResponseDTO(Reply reply) {
        this.rno = reply.getReplyNo();
        this.text = reply.getReplyText();
        this.regDate = reply.getReplyDate();
        this.account = reply.getAccount();
    }
}
