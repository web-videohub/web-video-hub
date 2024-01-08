package com.teamrocket.videohub.dto.response;

import lombok.*;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class EmotionResponseDTO {
    private int videoLike;
    private int videoHate;
}
