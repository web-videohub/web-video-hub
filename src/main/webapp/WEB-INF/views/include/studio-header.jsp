<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <style>
        .dropdown {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-secondary {
            border-radius: 50%;
            width: 50px;
            height: 50px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-secondary img {
            width: 50px;
            height: 50px;
        }
        .drop-p {
            margin-bottom: 0;
        }
        .dropdown-menu hr {
            margin: 5px;
        }
        .drop-p:hover {
            background-color: #fff;
        }
        .drop-p:active {
            background-color: #fff;
            color: #000;
        }
    </style>
</head>
<body>
<%
  String userName = "";

    Cookie[] cookies = request.getCookies();
    for (Cookie c : cookies) {
        if(c.getName().equals("login")) {
            userName = c.getValue();
        }
    }
%>
<header>
    <div class="headerDiv">
        <div class="headerContainer">
            <div class="menu">
                <button class="dropdownMenu" type="button">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a href="/studio" class="">
                    <img class="mainLogo" src="/assets/img/studioTitle.png" alt="">
                </a>
            </div>
            <form class="searchForm" action="" method="">
                <input class="searchInput" type="search" placeholder="채널에서 검색">
                <button class="searchBtn" type="submit">검색</button>
            </form>
            <div class="dropdown">
                <button class="btn btn-secondary" type="button" id="dropdownMenuButton1"
                        data-bs-toggle="dropdown" aria-expanded="false">
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li><p class="dropdown-item drop-p">${sessionScope.login.userDisplayName}</p></li>
                    <li><p class="dropdown-item drop-p">${sessionScope.login.userAccount}</p></li>
                    <hr>
                    <li><a class="dropdown-item" href="/studio">내 채널 보기</a></li>
                    <li><a class="dropdown-item" href="/setting">설정</a></li>
                    <li><a class="dropdown-item" href="#">로그아웃</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<script>
    const profilePath = `${sessionScope.login.userProfile}`;

    const $image = document.createElement('img');
    $image.src = "local" + profilePath;
    $image.alt = "profile image";

    const imageContainer = document.getElementById('dropdownMenuButton1');
    imageContainer.appendChild($image);
</script>
</body>
</html>