<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 채널</title>
    <link rel="stylesheet" href="/assets/css/studio-header.css">
    <link rel="stylesheet" href="/assets/css/studio.css">
</head>
<body>
<jsp:include page="include/studio-header.jsp"/>
<jsp:include page="include/static-head.jsp"/>

<div class="studioDiv">
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
                    <a class="nav-link" href="/subs">
                        <span class="lnr lnr-book"></span>
                        구독
                    </a>
                </li>
                <hr>
                <li class="nav-item">
                    <a class="nav-link" href="/studio">나 ></a>
                </li>
                <li class="nav-item home">
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
        <a href="/studio/upload">동영상 업로드</a>
    </div>
</div>
</body>
</html>