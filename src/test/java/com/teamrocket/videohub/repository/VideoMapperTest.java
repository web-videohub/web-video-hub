package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Video;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class VideoMapperTest {

    @Autowired
    VideoMapper videoMapper;

    @Test
    @DisplayName("테스트 게시물 30개 추가하기")
    void saveTest() {
        //given
        for(int i = 1; i <= 30; i++) {
            Video build = Video.builder()
                    .videoTitle("테스트용 제목" + i)
                    .videoCategory("health")
                    .videoContent("테스트용 내용" + i)
                    .build();

            videoMapper.save(build);
        }
        //when

        //then
    }


}