package com.teamrocket.videohub.dto.request;

import com.teamrocket.videohub.entity.Member;
import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@EqualsAndHashCode
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignUpRequestDTO {

    @NotBlank
    @Size(min = 4, max = 20)
    private String userAccount;

    @NotBlank
    private String userPassword;

    @NotBlank
    @Size(min = 2, max = 30)
    private String userDisplayName;

    @NotBlank
    @Email
    private String userEmail;

    @NotBlank
    private MultipartFile profileImage;

    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .userAccount(userAccount)
                .userPassword(encoder.encode(userPassword))
                .userDisplayName(userDisplayName)
                .userEmail(userEmail)
                .userProfileImage(savePath)
                .build();
    }
}
