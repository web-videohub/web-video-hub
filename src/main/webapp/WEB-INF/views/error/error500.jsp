<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css">
    <meta charset="UTF-8">
    <title>500 Error</title>
    <style>
        /* 구글 폰트 */
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap');

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #dcdcdc;
            height: 100vh;

            font-family: 'Noto Sans KR', sans-serif;
            font-weight: bold;
        }

        .content {
            width: 70vw;
            height: 70vh;
            padding: 3rem;
            font-size: 2rem;
            border-radius: 1rem;
            background-color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            gap: 10px;
        }

        .goHome {
            text-decoration-line: none;
            color: #000;
            border: 2px solid black;
            border-radius: 5rem;
            width: 200px;
            height: 70px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
        }

        #headerBtn2 {
            display: none;
        }
    </style>
</head>
<body>
<jsp:include page="../include/static-head.jsp"/>
<%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
<jsp:include page="../include/header.jsp"/>
<div class="wrapper">
    <div class="content">
        <img src="/assets/img/hubTitle.png" alt="404">
        <h1>500 페이지를 찾을 수 없습니다.</h1>
        <h2>현재 주소창의 URL을 확인하세요</h2>
        <a href="/" class="goHome">홈으로 이동</a>
    </div>
</div>
</body>
</html>