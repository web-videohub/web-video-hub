<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영상 화면</title>
<%--    <title>${video.videoTitle}</title>--%>
    <style>
        .back_bg {
            background-color: #F2E6E6;
        }
        li {
            list-style-type: none;
        }
        .container_group {
            display: flex;
            justify-content: center;
        }
        .box1 {
            width: 700px;
            height: 400px;
            background-color: #011F25;
            float: left;
        }
        .box2 {
            background-color: #BD9A8E;
            width: 300px;
            height: auto;
            float: left;
        }
        .box2 .video_list_Algorithm li{
            margin: 50px;
        }
        .box3 {
            width: 700px;
            height: auto;
        }
        .box3 ul li a img {
            width: 45px;
            height: 45px;
        }
        .video_sumnail {
            background-color: #6292BE;
            float: left;
            width: 200px;
            height: 100px;
        }
        .chat_list {
            background-color: #B5C1D1;
        }
    </style>
</head>
<body class="back_bg">
<%--    header 넣는 부분   --%>
<%--    영상 컨테이너       --%>
    <div class="container">
        <div class="container_group">
            <div class="box1">
                <video src = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" controls width="700" height="400">
                </video>
                <div class="box3">
                    <form id="messageForm" name="messageForm">
                        <div class="form-group">
                            <div class="input-group clearfix">
                                <input type="text" id="message" placeholder="메시지를 입력하시오..." autocomplete="off" class="form-control"/>
                                <input type="text" style="display: none">
                                <button type="button" class="primary">취소</button>
                                <button type="button" class="primary">댓글</button>
                            </div>
                        </div>
                    </form>
                    <ul class="chat_list">
                        <li>
                            <a href="#"><img src="/assets/img/cal.png">nickname</a>
                            <p>just do it.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="box2">
                <ul class="video_list_Algorithm">
                    <li>
                        <a href = "https://naver.com">
                            <div class="video_sumnail">img</div>
                        </a>
                    </li>
                    <li>
                        <a href = "https://naver.com">
                            <div class="video_sumnail">img</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>