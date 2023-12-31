package com.teamrocket.videohub.services;

import com.teamrocket.videohub.dto.request.LoginRequestDTO;
import com.teamrocket.videohub.dto.request.SignUpRequestDTO;
import com.teamrocket.videohub.dto.response.LoginUserResponseDTO;
import com.teamrocket.videohub.dto.response.UserInfoResponseDTO;
import com.teamrocket.videohub.entity.Member;
import com.teamrocket.videohub.repository.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.teamrocket.videohub.services.LoginResult.*;
import static com.teamrocket.videohub.utils.LoginUtils.LOGIN_KEY;

@Service 
@Slf4j
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder encoder;

    public boolean join(SignUpRequestDTO dto, String savePath) {
        return memberMapper.save(dto.toEntity(encoder, savePath));
    }

    public LoginResult authenticate(
            LoginRequestDTO dto,
            HttpSession session,
            HttpServletResponse response
    ) {
        Member foundMember = getMember(dto.getUserAccount());

        if(foundMember==null) {
            log.info("{} - 회원가입이 필요함", dto.getUserAccount());
            return NO_ACC;
        }

        String inputPassword = dto.getUserPassword();
        String realPassword = foundMember.getUserPassword();

        if(!encoder.matches(inputPassword, realPassword)) {
            log.info("비밀번호가 일치하지 않음");
            return NO_PW;
        }

        log.info("{}님 로그인 성공", foundMember.getUserAccount());
        return SUCCESS;

    }

    public Member getMember(String userAccount) {
        return memberMapper.findMember(userAccount);
    }

    public void maintainLoginState(HttpSession session, String userAccount) {
        Member member = getMember(userAccount);

        log.info("member : {}", member);

        LoginUserResponseDTO dto = LoginUserResponseDTO.builder()
                .userAccount(member.getUserAccount())
                .userDisplayName(member.getUserDisplayName())
                .userEmail(member.getUserEmail())
                .userAuth(member.getUserAuth().name())
                .userProfile(member.getUserProfileImage())
                .build();

        log.info("dto : {}", dto);
        session.setAttribute(LOGIN_KEY, dto);
        session.setMaxInactiveInterval(60 * 60);
    }

    public boolean checkDuplicateValue(String type, String keyword) {
        return memberMapper.isDuplicate(type, keyword);
    }

    public boolean checkConsistentValue(String account, String email) {
        return memberMapper.isConsistent(account, email);
    }

    public boolean modifyPassword(String account, String newPassword) {
        return memberMapper.modifyPassword(account, encoder.encode(newPassword));
    }

    public UserInfoResponseDTO getChannelInfo(String channelName) {
        Member member = memberMapper.findName(channelName);
        Member video = memberMapper.countVideo(channelName);
        Member sub = memberMapper.countSub(channelName);

        UserInfoResponseDTO dto = UserInfoResponseDTO.builder()
                .channelAccount(member.getUserAccount())
                .channelName(member.getUserDisplayName())
                .channelEmail(member.getUserEmail())
                .channelProfile(member.getUserProfileImage())
                .videoCount(video.getVideoCount())
                .subCount(sub.getSubCount())
                .build();

        log.info("영상수" + video.getVideoCount());
        log.info("구독자수" + sub.getSubCount());

        return dto;
//        return memberMapper.findMember();
    }

    public boolean updateNickname(String account, String nickname) {
        return memberMapper.updateNickname(account, nickname);
    }

}
