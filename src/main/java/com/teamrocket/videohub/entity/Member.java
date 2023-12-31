package com.teamrocket.videohub.entity;

import lombok.*;

import java.time.LocalDateTime;

@ToString @Getter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {

    private String userAccount;
    private String userPassword;
    private String userDisplayName;
    private String userEmail;
    private Auth userAuth;
    private LocalDateTime userRegDate;
}
