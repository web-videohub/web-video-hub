package com.teamrocket.videohub.dto.response;

import lombok.*;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserInfoResponseDTO {
    private String channelAccount;
    private String channelName;
    private String channelEmail;
    private String channelProfile;
    private int subCount;
    private int videoCount;
}
