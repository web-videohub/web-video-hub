package com.teamrocket.videohub.services;

import com.teamrocket.videohub.entity.Subscription;
import com.teamrocket.videohub.repository.SubscriptionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class SubscribeService {
    private final SubscriptionMapper subscriptionMapper;

    public boolean findSubs(Subscription subs) {
        log.debug("구독 조회 서비스 실행!");

        Integer subsId = subscriptionMapper.find(subs);

        return subsId != null;
    }

    public boolean AddSubs(Subscription subs) {
        log.debug("구독 추가 서비스 실행!");

        return subscriptionMapper.save(subs);
    }

    public boolean RemoveSubs(Subscription subs) {
        log.debug("구독 취소 서비스 실행!");

        return subscriptionMapper.delete(subs);
    }
}
