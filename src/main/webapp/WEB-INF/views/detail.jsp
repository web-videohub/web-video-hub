<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영상 화면</title>
    <style>
        .back_bg {
            background-color: #FFFFFF;
        }
        a {
            text-decoration-line: none;
        }
        li {
            list-style-type: none;
        }

        .container {
            margin-top: 100px;
        }
        .container_group {
            display: flex;
            justify-content: space-between;
        }

        /*box 1: 영상, 영상 설명, 댓글 */
        .box1 {
            flex: 1; /* 1부분을 차지하도록 설정 */
            max-width: 70%; /* 최대 70%까지만 차지하도록 설정 */
            box-sizing: border-box; /* 내부 패딩과 테두리를 포함한 전체 크기를 지정 */
            background-color: #8e8f8c;
        }
        .box1 video {
            width: 100%; /* 부모 요소인 .box1의 100%를 차지하도록 설정 */
            height: auto; /* 비율을 유지하면서 너비에 따라 높이 조정 */
            border-radius: 10px;
        }

        .video_info_user_bbox {
            float: left;
        }
        .video_info_user_bbox a {
            text-decoration-line: none;
            color: #000000;
        }
        .video_info_user_bbox p {
            color: #383c46;
        }

        .video_user_bbox {
            display: block;
            margin-right: 10px;
        }
        .video_user_bbox a img {
            width: 45px;
            height: 45px;
            float: left;
        }
        .video_user_bbox .subscribe_B {
            background-color: #000000;
            color: #FFFFFF;
            border-radius: 20px;
            width: 60px;
            height: 36px;
            border: none;
            margin-left: 10px;
            float: left;
        }
        .video_user_bbox .subscribe_B:hover {
            background-color: #272727;
            color: #FFFFFF;
        }
        .like_B, .hate_B, .share_B{
            background-color: #F2F2F2;
            color: #000000;
            border-radius: 20px;
            width: 60px;
            height: 36px;
            border: none;
            margin-left: 5px;
            float: left;
        }
        .like_B:hover, .hate_B:hover, .share_B:hover{
            background-color: #E5E5E5;
        }
        .video_review_btn_t {
            float: right;
        }

        /* 영상 설명 칸 video info bbox */

        .video_info_bbox {
            background-color: #F2F2F2;
            color: #000000;
            border-radius: 10px;
            border: none;
            clear: left;
            width: 100%;
            height: auto;
        }
        .video_info_bbox:hover {
            background-color: #E5E5E5;
        }
        .video_info_bbox p{
            margin: 5px;
        }

        /* box 2: 관심(추천)동영상 목록 */
        .box2 {
            flex: 1; /* 1부분을 차지하도록 설정 */
            max-width: 30%; /* 최대 30%까지만 차지하도록 설정 */
            box-sizing: border-box; /* 내부 패딩과 테두리를 포함한 전체 크기를 지정 */
        }

        .box2 .video_list_Algorithm li {
            margin-top: 10px;
            margin-left: -20px;
            white-space: nowrap; /* 줄바꿈 방지 */
        }

        .box2 .video_list_Algorithm li a {
            text-decoration-line: none;
            color: #000000;
        }

        /* 댓글 리스트 */
        .chat_list {
            background-color: #FFFFFF;
            padding-left: 0px;
            width: 100%;
        }
        .chat_list li {
            margin-top: 20px;
        }
        .chat_list a {
            text-decoration-line: none;
            color: #000000;
        }
        .chat_list_profile {
            float: left;
        }
        .chat_list_profile_name {
            margin: 10px;
            float: left;
        }
        .chat_list table {
            clear: left;
        }

        .like_bb{
            border: none;
            border-radius: 20px;
            padding: 10px;
            background-color: #F2F2F2;
        }
        .hate_bb{
            border: none;
            border-radius: 20px;
            padding: 10px;
            background-color: #F2F2F2;
        }
        .dropbox_bb {
            border: none;
            padding: 10px;
            background-color: #FFFFFF;
        }

        .input-group #message {
            width: 100%;
            height: 40px;
        }
        .input-group img {
            width: 45px;
            height: 45px;
        }

        .bbox1 {
            display: flex;
            flex-direction: column;
            float: left;
        }
        .bbox1_1 {
            float: left;
            width: 90%;
        }
        .bbox2 {
            /*버튼 객체들을 bbox1, bbox1_1이 있는 위치의 다음 줄로 가야함*/
            float: right;
            margin-bottom: 20px;
        }

        .cancel_B{
            padding: 0 16px;
            height: 36px;
            font-size: 14px;
            line-height: 36px;
            border-radius: 18px;
            border: none;
            background-color: #FFFFFF;
            color: #000000;
        }
        .cancel_B:hover{
            background-color: #E5E5E5;
        }
        .review_B {
            padding: 0 16px;
            height: 36px;
            font-size: 14px;
            line-height: 36px;
            border-radius: 18px;
            border: none;
            color: #8e8f8c;
        }

        .clearfix::after {
            content: "";
            display: table;
            clear: both;
        }

        .box3 {
            width: 100%;
            height: auto;
        }
        .box3 ul li a img {
            width: 45px;
            height: 45px;
        }

        .video_sumnail {
            background-color: #F2F2F2;
            float: left;
            width: 168px;
            height: 94px;
            margin-top: 5px;
            margin-right: 10px;
        }
        .bbox_text {
            margin: 11px;
            font-size: 15px;
        }

        /* 창 사이즈에 따른 객체들 사이즈.*/

        @media (max-width: 768px) {
            .container_group {
                flex-direction: column; /* 화면이 작을 때 세로로 배치 */
                align-items: stretch; /* 세로 배치 시에 요소들을 꽉 채움 */
            }

            .box1, .box2 {
                width: 100%; /* 화면이 작을 때 전체 폭을 차지하도록 변경 */
                min-width: 427px;
            }

            .box1 video {
                width: 100%; /* 부모 요소인 .box1의 100%를 차지하도록 설정 */
                height: auto; /* 비율을 유지하면서 너비에 따라 높이 조정 */

                /* 추가된 부분: 최소한의 너비와 높이를 설정 */
                min-width: 427px;
                min-height: 240px;
            }
        }

        @media (max-width: 1200px) {
            .container_group {
                flex-direction: column; /* 세로로 배치 */
            }

            .box1, .box2 {
                width: 100%; /* 전체 폭 차지 */
            }

            .box2 {
                margin-top: 10px; /* box1과의 간격 조절 */
            }
        }

    </style>
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
                <h1>제목 타이틀 : ${v.videoTitle}</h1>
                <div class="video_user_bbox">
                    <a href="#"><img src="/assets/img/japcho.jpg"></a>
                    <div class="video_info_user_bbox">
                        <a href="#">${v.uploadUserDisplayName}Test</a>
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
                                <img src="/assets/img/japcho.jpg">
                                <p>Test_user</p>
                            </div>
                            <div class="bbox1_1">
                                <input type="text" id="message" placeholder="댓글 추가..." autocomplete="off"
                                       class="form-control"/>
                                <input type="text" style="display: none">
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="cancel_B">취소</button>
                            <button type="button" class="review_B">댓글</button>
                        </div>
                    </div>
                </form>
                <ul class="chat_list">
                    <li>
                        <div class="chat_list_profile">
                            <a href="#"><img src="/assets/img/japcho.jpg"></a>
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
                                        <button type="button" class="dropbox_bb">...</button>
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
                            <p class="bbox_text">거짓말을밥먹듯이하는인간</p>
                            <p class="bbox_text">조회수 666만</p>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <div class="video_sumnail">
                            <img src="https://i.ytimg.com/vi/1xaPoq9ovyI/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLAW3tl-dautPg_SczhQwLbRix2YFw">
                        </div>
                        <div class="video_subinfo">
                            <p class="bbox_text">[테스트용 제목] 알고보니 지구멸망이 24시간 남았다?</p>
                            <p class="bbox_text">거짓말을밥먹듯이하는인간</p>
                            <p class="bbox_text">조회수 666만</p>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <div class="video_sumnail">
                            <img src="https://i.ytimg.com/vi/1xaPoq9ovyI/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLAW3tl-dautPg_SczhQwLbRix2YFw">
                        </div>
                        <div class="video_subinfo">
                            <p class="bbox_text">[테스트용 제목] 알고보니 지구멸망이 24시간 남았다?</p>
                            <p class="bbox_text">거짓말을밥먹듯이하는인간</p>
                            <p class="bbox_text">조회수 666만</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
