package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Reply;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReplyMapperTest {
    @Autowired
    ReplyMapper replyMapper;

    @Test
    @DisplayName("아이디가 smg0218인 유저가 100개의 댓글을 video_id가 test_id인 게시물에 등록한다.")
    void bulkInsertTest() {
        //given
//        for(int i=1; i<100; i++) {
//            Reply r = Reply.builder()
//                    .replyText("테스트" + i)
//                    .replyWriter("smg0218")
//                    .videoId("test_id")
//                    .account("smg0218")
//                    .build();
//
//            System.out.println("r = " + r);
//
//            replyMapper.save(r);
//        }
        Reply r = Reply.builder()
                .replyText("테스트")
                .videoId(1)
                .account("smg0218")
                .build();

        //when
        boolean flag = replyMapper.save(r);

        //then
        assertTrue(flag);
    }

}