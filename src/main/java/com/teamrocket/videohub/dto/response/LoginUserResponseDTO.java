package com.teamrocket.videohub.dto.response;

import lombok.*;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class LoginUserResponseDTO {
    private String userAccount;
    private String userDisplayName;
    private String userEmail;
    private String userAuth;
    private String userProfile;
}
