<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영상 화면</title>
    <link rel="stylesheet" href="/assets/css/detail.css?after">
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
            <video src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                   controls width="auto" height="auto">
            </video>
            <div class="video_info">
                <h1>${v.videoTitle}</h1>
                <div class="video_user_bbox">
                    <a href="#"><img src="/assets/img/profile.jpeg"></a>
                    <div class="video_info_user_bbox">
                        <a href="#">${v.uploadUserDisplayName}</a>
                        <p>구독자 0명</p>
                    </div>
                    <div class="video_review_btn_o">
                        <button type="button" class="subscribe_B">구독</button>
                    </div>
                    <div class="video_review_btn_t">
                        <button type="button" class="like_B">${v.videoLike}좋아요</button>
                        <button type="button" class="hate_B">싫어요</button>
                        <button type="button" class="share_B">공유</button>
                    </div>
                </div>

                <div class="video_info_bbox">
                    <p>업로드 일자: ${v.uploadDate}</p>
                    <p>조회수: ${v.videoViewCount}</p>
                    <p>영상 설명: ${v.videoContent}</p>
                </div>
            </div>
            <div class="box3">
                <!-- [댓글 입력창 구역] 댓글 기능 무료 서비스(백엔드 일부 포함): https://velog.io/@ybseo/HTML-%EB%8C%93%EA%B8%80-%EA%B8%B0%EB%8A%A5-%EC%B6%94%EA%B0%80%ED%95%98%EA%B8%B0-Disqus -->
                <form id="messageForm" name="messageForm">
                    <div class="form-group">
                        <div class="input-group clearfix">
                            <div class="bbox1">
                                <img src="/assets/img/profile.jpeg">
                                <p>Test_user</p>
                            </div>
                            <div class="bbox1_1">
                                <input type="text" id="message" placeholder="댓글 추가..." autocomplete="off"
                                       class="form-control"/>
                                <input type="text" style="display: none">
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="review_B">댓글</button>
                        </div>
                    </div>
                </form>
                <ul class="chat_list">
                    <li>
                        <div class="chat_list_profile">
                            <a href="#"><img src="/assets/img/profile.jpeg"></a>
                        </div>
                        <div class="chat_list_profile_name">
                            <a href="#"><p>Test_name</p></a>
                        </div>
                        <table>
                            <tr>
                                <td><p>삭제용 테스트 댓글 :d</p></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="review_btns_one">
                                        <button type="button" class="like_bb">좋아요</button>
                                        <button type="button" class="hate_bb">싫어요</button>
                                    </div>
                                </td>
                                <td>
                                    <div class="review_btns_two">
                                        <button type="button" onclick="toggleDropdown()" class="dropbox_bb">...</button>
                                        <div id="myDropdown" class="dropdown-content">
                                            <a href="#">수정</a>
                                            <a href="#">삭제</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </li>
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
                            <p class="bbox_text_sub">거짓말을밥먹듯이하는인간</p>
                            <p class="bbox_text_sub">조회수 666만 · ${v.uploadDate}</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- 드롭다운 메뉴 테스트 자바스크립트 코드 -->
<script src="./assets/js/testDropmenu.js"></script>
</body>
</html>