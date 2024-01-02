package com.teamrocket.videohub.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter @ToString
public enum Auth {

    COMMON("일반회원", 1)
    , ADMIN("관리자", 2);

    private String description; // 권한 설명
    private int authNumber;     // 권한 번호
}
