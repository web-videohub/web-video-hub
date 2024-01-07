package com.teamrocket.videohub.dto.request;

import lombok.*;

@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmotionPostRequestDTO {
    private String account;
    private int videoId;
    private int videoLike;
    private int videoHate;
}
