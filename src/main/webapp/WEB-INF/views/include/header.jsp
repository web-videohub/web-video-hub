<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
    <div class="headerDiv">
        <div class="headerContainer">
            <div class="menu">
                <button class="dropdownMenu" type="button">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a href="/" class="">
                    <img class="mainLogo" src="/assets/img/testLogo.png" alt="">
                </a>
            </div>
            <form class="searchForm" action="" method="">
                <input class="searchInput" type="search" placeholder="검색">
                <button class="searchBtn" type="submit">검색</button>
            </form>
            <div class="btns">
                <button class="upload" href="#">upload</button>
<%--                <button class="mypage" href="#">info</button>--%>
                <div class="infoDropDown">
                    <button class="infoDropBtn">info</button>
                    <div class="infoContent">
                        <%--<a>${nickName}(${account})</a>--%>
                        <a>닉네임(계정명)</a>
                        <a href="#">내 채널 보기</a>
                        <a href="/setting">설정</a>
                        <a href="#">로그아웃</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


</header>
