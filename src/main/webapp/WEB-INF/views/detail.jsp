<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%--    <title>영상 화면</title>--%>
    <title>${v.videoTitle}</title>

    <link rel="stylesheet" href="/assets/css/detail.css">

    <%--    icon    --%>
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">

</head>
<body class="back_bg">
<%-- css 모음 --%>
<jsp:include page="include/static-head.jsp"/>
<%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
<jsp:include page="include/header.jsp"/>

<%--    영상 컨테이너       --%>
<div class="container">
    <div class="container_group clearfix"> <!-- clearfix 클래스 추가 -->
        <div class="box1">
            <div class="videoContainer">
                <video src="/local${v.videoUrl}"
                       controls width="100%" height="100%">
                </video>
            </div>
            <div class="video_info">
                <h1>${v.videoTitle}</h1>
                <div class="video_user_bbox">
                    <div class="profile-subContainer"style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div class="profile">
                            <a href="#"><img src="/local${v.userProfileImage}" alt="profile image"
                                             class="user-profile-image"/></a>
                            <div class="video_info_user_bbox">
                                <a href="#">${v.videoUploadUser}</a>
                                <p>구독자 0명</p>
                            </div>
                            <div class="video_review_btn_o">
                                <button type="button" class="subscribe_B">구독</button>
                            </div>
                        </div>


                        <div class="video_review_btn_t">
                            <button type="button" class="like_B">${v.videoLike}<span class="lnr lnr-thumbs-up"></span>1.5만
                            </button>
                            <button type="button" class="hate_B"><span class="lnr lnr-thumbs-down"></span></button>
                            <button type="button" class="share_B"><span class="lnr lnr-exit-up"></span></button>
                        </div>
                    </div>


                </div>

                <div class="video_info_bbox">
                    <p>업로드 일자: ${v.videoUploadDate}</p>
                    <p>조회수: ${v.videoViewCount}</p>
                    <p>영상 설명: ${v.videoContent}</p>
                </div>
            </div>
            <div class="box3">
                <form id="messageForm" name="messageForm">
                    <div class="form-group">
                        <div class="input-group clearfix">
                            <div class="bbox1">
                                <img src="/local${sessionScope.login.userProfile}" alt="profile image"
                                     class="profileIMG"/>
                                <p>${sessionScope.login.userDisplayName}<</p>
                            </div>
                            <div class="bbox1_1">
                                <textarea id="message" placeholder="댓글 추가..." autocomplete="off"
                                          class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="review_B" onclick="addComment()">댓글</button>
                        </div>
                    </div>
                </form>
                <ul class="chat_list">
                    <%-- 이 부분은 li가 생성되는 부분이므로 어떠한 첨가도 금함.--%>
                </ul>
            </div>
        </div>
        <div class="box2">
            <ul class="video_list_Algorithm">
                <li>
                    <a href="#">
                        <div class="video_sumnail">
                            <img src="https://i.ytimg.com/vi/1xaPoq9ovyI/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLAW3tl-dautPg_SczhQwLbRix2YFw">
                        </div>
                        <div class="video_subinfo">
                            <p class="bbox_text">[테스트용 제목] 알고보니 지구멸망이 24시간 남았다?</p>
                            <p class="bbox_text_sub">Test_user</p>
                            <p class="bbox_text_sub">조회수 ? · 업로드 : ?</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- 드롭다운 메뉴, 댓글 테스트 자바스크립트 코드 -->
<script src="./assets/js/testDropmenu.js"></script>
<script src="./assets/js/testReviewChat.js"></script>
</body>
</html>
