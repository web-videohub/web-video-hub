<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/userPage.css">
    <title>${channelName}님의 페이지</title>
</head>
<body>
    <%-- css 모음 --%>
    <jsp:include page="include/static-head.jsp"/>
    <%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
    <jsp:include page="include/header.jsp"/>

    <%-- 기본 왼쪽 상태바 --%>
    <div class="leftDiv index-left">
        <div class="offcanvas-body index-side">
            <ul class="navbar-nav flex-grow-1 pe-3">

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
                <c:if test="${sessionScope.login.userAccount} == ${channelAccount}">
                    <li class="nav-item">
                        <a class="nav-link home" href="/userPage">
                            <span class="lnr lnr-user"></span>
                            내 채널
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.login.userAccount} != ${channelAccount}">
                    <li class="nav-item">
                        <a class="nav-link" href="/userPage">
                            <span class="lnr lnr-user"></span>
                            내 채널
                        </a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="/studio">
                        <img class="mini" src="/assets/img/miniHub.png" alt="">
                        스튜디오
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
    <div class="leftDiv2 index-left2">
        <div class="offcanvas-body index-side2">
            <ul class="navbar-nav flex-grow-1 pe-3">
                <li class="nav-item2">
                    <a class="nav-link active" aria-current="page" href="/">
                        <span class="lnr lnr-home"></span><br>
                        <span class="sideText">홈</span>
                    </a>
                </li>
                <li class="nav-item2">
                    <a class="nav-link" href="/subs">
                        <span class="lnr lnr-book"></span><br>
                        <span class="sideText">구독</span>
                    </a>
                </li>
                <c:if test="${sessionScope.login.userAccount} == ${channelAccount}">
                    <li class="nav-item2">
                        <a class="nav-link home" href="/studio">
                            <span class="lnr lnr-user"></span><br>
                            <span class="sideText">나</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.login.userAccount} != ${channelAccount}">
                    <li class="nav-item2">
                        <a class="nav-link" href="/studio">
                            <span class="lnr lnr-user"></span><br>
                            <span class="sideText">나</span>
                        </a>
                    </li>
                </c:if>
                <li class="nav-item2">
                    <a class="nav-link" href="/setting">
                        <span class="lnr lnr-cog"></span><br>
                        <span class="sideText">설정</span>
                    </a>
                </li>

            </ul>
        </div>
    </div>
    <div class="channelContainer">
        <div class="profileBox">
<%--            <img src="/local${sessionScope.login.userProfile}" alt="profile image" class="pimg"/>--%>
            <img src="/assets/img/rabbit.png" alt="profile image" class="pimg"/>
            <div class="channelProfile">
                <p class="channelName">${channelName}</p>
<%--                <p class="channelName">김다빈</p>--%>
                <p class="channelAccount">@${channelAccount} ＊ 구독자 ${subCount}명 ＊ 동영상 ${videoCount}개</p>
<%--                <p class="channelAccount">@kimdaveen ㆍ 구독자 0명 ㆍ 동영상 0개</p>--%>
                <c:if test="${sessionScope.login.userAccount} != ${channelAccount}">
                    <button type="button" class="subscribe_B">구독</button>
                </c:if>
                <c:if test="${sessionScope.login.userAccount} == ${channelAccount}">
                    <button type="button" class="subscribe_B">스튜디오</button>
                </c:if>
            </div>
        </div>
        <span>채널 최신 동영상</span>
        <hr>
        <div class="chVideoDiv">
            <c:forEach var="v" items="${vList}">
                <div class="channelVideoList">
                    <a class="chVideo" href="#">
                        <img id="chImg" src="/local${v.thumbnailUrl}" alt="thumbnail" data-videoId="${v.videoId}"/>
                    </a>
                    <div class="chContainer">
                        <div class="channelVideo">
                            <a class="miniTitle" href="#">
                                <span class="chTitle" data-videoId="${v.videoId}">
                                    ${v.videoTitle}
                                </span>
                            </a>
                            <span class="chViewcount">
                                    조회수 ${v.videoViewCount}회ㆍ${v.videoUploadDate}
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
<script>
    $thumbnail = document.querySelector('.chVideo');
    $chTitle = document.querySelector('.chTitle');
    $thumbnail.addEventListener('click', e => {
            window.location.href = "/showmv?videoId=" + e.target.dataset.videoid;
    });
    $chTitle.addEventListener('click', e => {
            window.location.href = "/showmv?videoId=" + e.target.dataset.videoid;
    });


    function formatTimeAgo(timestamp) {
        const currentTime = new Date();
        const targetTime = new Date(timestamp);
        const timeDifference = currentTime - targetTime;

        const minutes = Math.floor(timeDifference / (1000 * 60));
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        const months = Math.floor(days / 30);
        const years = Math.floor(days / 365);

        if (years > 0) {
            return `\${years}년 전`;
        } else if (months > 0) {
            return `\${months}개월 전`;
        } else if (days > 0) {
            return `\${days}일 전`;
        } else if (hours > 0) {
            return `\${hours}시간 전`;
        } else if (minutes > 0) {
            return `\${minutes}분 전`;
        } else {
            return '방금 전';
        }
    }




    let pageWidth;
    let $canvasBody = document.querySelector('.index-side');
    let $leftDiv = document.querySelector('.index-left');
    let $leftDiv2 = document.querySelector('.index-left2');
    let $headerBtn = document.getElementById("headerBtn");
    let $headerBtn2 = document.getElementById("headerBtn2");
    const side1 = 1;
    const side2 = 2;
    let isClick = side1;

    function checkWidth() {
        console.log(pageWidth);
        if (pageWidth >= 1200) {
            if (isClick === side1) {
                $leftDiv2.style.display = 'none';
                $leftDiv.style.display = 'flex';
                $headerBtn2.style.display = 'flex';
                $headerBtn.style.display = 'none';
            }
            if (isClick === side2){
                $leftDiv2.style.display = 'flex';
                $leftDiv.style.display = 'none';
                $headerBtn2.style.display = 'flex';
                $headerBtn.style.display = 'none';
            }


        }
        else if (pageWidth > 640) {
            $leftDiv.style.display = 'none';
            $leftDiv2.style.display = 'flex';
            $headerBtn2.style.display = 'none';
            $headerBtn.style.display = 'flex';
        }
        else if (pageWidth <= 640){
            $leftDiv2.style.display = 'none';
            $leftDiv.style.display = 'none';
            $headerBtn2.style.display = 'none';
            $headerBtn.style.display = 'flex';
        }
    }
    $headerBtn2.addEventListener('click', e => {

        if (isClick === side1) {
            $leftDiv2.style.display = 'flex';
            $leftDiv.style.display = 'none';
            isClick = side2;
        } else if (isClick === side2){
            $leftDiv.style.display = 'flex';
            $leftDiv2.style.display = 'none';
            isClick = side1;
        }
        console.log("현재상태 : " + isClick);
    })

    // 첫 화면크기 반영
    window.onload = function () {
        pageWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        checkWidth();
    };

    window.addEventListener('resize', function() {
        pageWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        checkWidth();
    });
</script>
</body>
</html>