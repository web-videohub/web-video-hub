package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Member;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class MemberMapperTest {

    @Autowired
    MemberMapper memberMapper;

    @Autowired
    PasswordEncoder encoder;

    @Test
    @DisplayName("회원가입에 성공해야함")
    void saveTest() {
        //given
        Member member = Member.builder()
                .userAccount("yongseop")
                .userPassword(encoder.encode("dydtjq1234"))
                .userDisplayName("김용섭섭")
                .build();
        //when
        boolean save = memberMapper.save(member);
        //then
        assertTrue(save);
    }


}