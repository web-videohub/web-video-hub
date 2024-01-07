package com.teamrocket.videohub.services;

import com.teamrocket.videohub.entity.Subscription;
import com.teamrocket.videohub.repository.MemberMapper;
import com.teamrocket.videohub.repository.SubscriptionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class SubscribeService {

    private final MemberMapper memberMapper;
    private final SubscriptionMapper subscriptionMapper;

    public Subscription findSubs(Subscription subs) {
        log.debug("구독 조회 서비스 실행!");

        Subscription subss = subscriptionMapper.find(subs);

        return subss;
    }

    public boolean AddSubs(Subscription subs) {
        log.debug("구독 추가 서비스 실행!");

        memberMapper.upSubCount(subs.getSubReceiver());

        return subscriptionMapper.save(subs);
    }

    public boolean RemoveSubs(Subscription subs) {
        log.debug("구독 취소 서비스 실행!");

        memberMapper.downSubCount(subs.getSubReceiver());

        return subscriptionMapper.delete(subs);
    }
}
