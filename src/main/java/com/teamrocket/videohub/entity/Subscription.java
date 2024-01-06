package com.teamrocket.videohub.entity;

import lombok.*;

@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Subscription {
    private String subSender;
    private String subReceiver;
}
