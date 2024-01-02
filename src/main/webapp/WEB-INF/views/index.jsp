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
        <div class="offcanvas-body">
            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">
                        <span class="lnr lnr-home"></span>
                        홈
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <span class="lnr lnr-book"></span>
                        구독
                    </a>
                </li>
                <hr>
                <li class="nav-item">
                    <a class="nav-link" href="/studio">나 ></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/studio">
                        <span class="lnr lnr-user"></span>
                        내 채널
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/setting">
                        <span class="lnr lnr-cog"></span>
                        설정
                    </a>
                </li>

            </ul>
        </div>
    </div>
    <div class="mainContainer">
        <div class="subContainer">
            <%-- 영상 리스트를 렌더링할때 조건을 건다 (최신영상, 인기많은영상, 최다조회수영상 등)--%>
            <jsp:include page="include/filter.jsp"/>

            <%-- 서버에 업로드된 영상들이 연속적으로 나타날 div --%>
            <div class="videoListDiv">
                <c:forEach var="v" items="${vList}">
                    <div class="videoDiv">
                        <div class="video">
                            ${v.video}
                        </div>
                        <div class="profileContainer">
                            <div class="profile"></div>
                            <div class="videoInfoDiv">
                                <span class="title">${v.title}</span>
                                <span class="uploader">${v.uploader}</span>
                                <span class="viewcount">${v.viewCount} § ${s.lastTime} 전</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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