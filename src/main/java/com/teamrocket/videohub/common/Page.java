package com.teamrocket.videohub.common;

import lombok.*;

@Getter @Setter @ToString
@AllArgsConstructor
public class Page {
    private int pageNo; // 클라이언트가 보낸 페이지 번호
    private int amount; // 클라이언트가 보낸 목록게시물 수

    public Page() {
        this.pageNo = 1;
        this.amount = 20;
    }

    public int getPageStart() {
        return (pageNo - 1) * amount;
    }
}
