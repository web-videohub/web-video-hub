<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/setting.css">
    <title>설정</title>
</head>
<body>
    <%-- css 모음 --%>
    <jsp:include page="include/static-head.jsp"/>
    <%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
    <jsp:include page="include/header.jsp"/>


    <div class="settingDiv">
        <%-- 설정 상태바 --%>
            <div class="leftDiv">
                <div class="offcanvas-body">
                    <h4>설정</h4>
                    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                        <li class="nav-item dd home" id="pageA">
                            <a class="nav-link active" aria-current="page" href="#">
                                계정
                            </a>
                        </li>
                        <li class="nav-item dd subHome">
                            <a class="nav-link" href="#" id="pageB">
                                웹사이트 정보
                            </a>
                        </li>


                    </ul>
                </div>
            </div>
            <div class="mainContainer" id="page1">
                <span class="boldTitle">내 Video hub 채널</span><br>
                <span>Video hub에 공개되는 본인의 채널을 설정하세요.</span>
                <div class="channelSetDiv">
                    <span>내 채널</span>
                    <a href="/studio">
                        <img src="/local${sessionScope.login.userProfile}" alt="profile image" class="profileIMG"/>
                    </a>
                    <p class="userName">${sessionScope.login.userDisplayName}(${sessionScope.login.userAccount})</p>
                </div>

                <hr>

                <span class="boldTitle">내 계정</span><br>
                <span>Video hub 계정의 정보를 설정하세요.</span>
                <div class="accountSetDiv">
                    <span>Video hub 계정</span>
                    <a href="#">계정정보 변경하기</a>
                </div>
            </div>
            <div class="mainContainer" id="page2">
                안녕하세요 팀 로켓 입니다.
            </div>
    </div>
<script>
    let $pageA = document.getElementById("pageA");
    let $pageB = document.getElementById("pageB");
    let $page1 = document.getElementById("page1");
    let $page2 = document.getElementById("page2");
    let check = 1;
    let $setting = document.querySelector('.home');
    let $websiteInfo = document.querySelector('.subHome');

    $pageA.addEventListener('click', e => {
        $page1.style.display = 'flex';
        $page2.style.display = 'none';
        $setting.style.background = '#dedede';
        $websiteInfo.style.background = 'white';
    })
    $pageB.addEventListener('click', e => {
        $page1.style.display = 'none';
        $page2.style.display = 'flex';
        $websiteInfo.style.background = '#dedede';
        $setting.style.background = 'white';
    })
</script>
</body>
</html>