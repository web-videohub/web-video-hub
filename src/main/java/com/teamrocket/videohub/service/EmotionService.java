package com.teamrocket.videohub.service;

import com.teamrocket.videohub.dto.request.EmotionPostRequestDTO;
import com.teamrocket.videohub.entity.Emotion;
import com.teamrocket.videohub.repository.EmotionMapper;
import com.teamrocket.videohub.repository.VideoMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmotionService {
    private final VideoMapper videoMapper;
    private final EmotionMapper emotionMapper;

    // 이모션 목록 조회
    public Emotion getEmotion(int videoId, String userAccount) {

        // DB에서 해당 동영상의 이모션 여부 조회
        Emotion emotion = emotionMapper.findOne(videoId, userAccount);

        if(emotion == null) {
            log.warn("emotion not found!");
        }

        return emotion;
    }

    public void saveEmotion(Emotion emotion) throws SQLException{
        log.debug("emotion save service execute!");

        boolean flag = emotionMapper.save(emotion.getVideoId(), emotion.getUserAccount(), emotion.getVideoLike(), emotion.getVideoHate());

        if(!flag) {
            log.warn("emotion save failed!");
            throw new SQLException("이모션 저장 실패!");
        }

        if (emotion.getVideoLike() == 1)
            videoMapper.upLikeCount(emotion.getVideoId());
    }

    public void modify(EmotionPostRequestDTO dto) throws Exception{
        Emotion emotion = emotionMapper.findOne(1, "smg0218");
        // POSTMAN 테스트 용으로 임시처리
        emotionMapper.modify(1, "smg0218", dto.getVideoLike(), dto.getVideoHate());
        if (emotion.getVideoLike() == 1)
            videoMapper.downLikeCount(1);
    }
}
