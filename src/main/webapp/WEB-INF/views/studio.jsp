<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Studio</title>
    <link rel="stylesheet" href="/assets/css/studio-header.css">
    <link rel="stylesheet" href="/assets/css/studio.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="include/studio-header.jsp"/>
<%-- css 모음 --%>
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
        <a href="/studio/upload">동영상 업로드</a>
    </div>
</div>
</body>
</html>