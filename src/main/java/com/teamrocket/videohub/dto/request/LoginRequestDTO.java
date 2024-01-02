package com.teamrocket.videohub.dto.request;

import lombok.*;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginRequestDTO {
    private String userAccount;
    private String userPassword;
}
