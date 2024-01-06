package com.teamrocket.videohub.dto.request;

import com.teamrocket.videohub.entity.Reply;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyPostRequestDTO {
    @NotBlank
    @Size(min = 1, max = 300)
    private String text; // 댓글 내용

    @NotBlank
    private String account; //댓글 작성자

    @NotNull
    private long videoId; // 원본 글번호

    // dto를 entity로 바꾸는 변환 메서드
    public Reply toEntity() {
        return Reply.builder()
                .replyText(this.text)
                .account(this.account)
                .videoId(this.videoId)
                .build()
                ;
    }
}
