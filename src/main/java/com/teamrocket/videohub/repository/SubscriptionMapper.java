package com.teamrocket.videohub.repository;

import com.teamrocket.videohub.entity.Subscription;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SubscriptionMapper {
    Integer find(Subscription subs);
    boolean save(Subscription subscription);

    boolean delete(Subscription subscription);

}
