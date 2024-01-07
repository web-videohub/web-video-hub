package com.teamrocket.videohub.entity;

import lombok.*;
/*
    user_account varchar(30) primary key,
    video_id int,
    video_like int default 0,
    video_hate int default 0,
 */
@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Emotion {
    private String userAccount;
    private int videoId;
    private int videoLike;
    private int videoHate;
}
