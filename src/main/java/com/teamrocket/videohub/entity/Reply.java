package com.teamrocket.videohub.entity;

import lombok.*;

import java.time.LocalDateTime;
@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reply {

    private long replyNo;
    @Setter
    private String replyText;
    private LocalDateTime replyDate;
    @Setter
    private long videoId;
    @Setter
    private String account;
}
