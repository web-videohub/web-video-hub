<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/index.css">
    <link rel="stylesheet" href="/assets/css/filter.css">
    <title>메인화면</title>
</head>
<body>
    <%-- css 모음 --%>
    <jsp:include page="include/static-head.jsp"/>
    <%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
    <jsp:include page="include/header.jsp"/>


    <%-- 기본 왼쪽 상태바 --%>
    <div class="leftDiv">
        왼쪽 상태바 입니다.
    </div>
    <div class="mainContainer">
        <div class="subContainer">
            <%-- 영상 리스트를 렌더링할때 조건을 건다 (최신영상, 인기많은영상, 최다조회수영상 등)--%>
            <jsp:include page="include/filter.jsp"/>

            <%-- 서버에 업로드된 영상들이 연속적으로 나타날 div --%>
            <div class="videoListDiv">
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">1제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">2제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">3제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">4제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">5제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
                <div class="videoDiv">
                    <div class="video">

                    </div>
                    <div class="profileContainer">
                        <div class="profile"></div>
                        <div class="videoInfoDiv">
                            <span class="title">6제목을 입력해주세요.</span>
                            <span class="uploader">업로더</span>
                            <span class="viewcount">조회수 0회 § 1분 전</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>