<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/setting.css?after">
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">

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
                <span class="menu_o_txt">계정</span>
                <br>
                <span class="boldTitle">내 Video hub 채널</span><br>
                <span>Video hub에 공개되는 본인의 채널을 설정하세요.</span>
                <div class="channelSetDiv">
                    <span class="setting_box_title">내 채널</span>
                    <a href="/studio">
                        <img src="/local${sessionScope.login.userProfile}" alt="profile image" class="profileIMG"/>
                    </a>
                    <p class="userName">${sessionScope.login.userDisplayName}(${sessionScope.login.userAccount})</p>
                </div>

                <hr>

                <span class="boldTitle">내 계정</span><br>
                <span class="user_text_margin">Video hub 계정의 정보를 설정하세요.</span>
                <div class="accountSetDiv">
                    <div class="accountSetDiv_title">
                        <span>Video hub 계정</span>
                    </div>
                    <div class="accountSetDiv_link">
                        <a href="#">계정정보 변경하기</a>
                    </div>
                </div>
                <div class="user_setting_container">
                    <div class="user_setting_container_group">
                        <div class="settings_id">
                            <span class="setting_box_title">Id</span>
                            <input type="text" id="user_id" placeholder="아이디(4자 이상)" class="setting_box_user_id"/>
                        </div>
                        <div class="settings_pw">
                            <span class="setting_box_title">Password</span>
                            <span class="password_warming">비밀번호 안전성:</span>
                            <p class="password_warming">8자 이상 특수문자 포함하여 입력하세요. 다른 사이트에서 쓰는 비밀번호나 애완동물의 이름처럼 추측하기 쉬운 이름은 사용하지 마세요.</p>
                            <input type="text" id="user_pw" placeholder="새 비밀번호" class="setting_box_user_pw"/>
                        </div>
                        <div class="settings_em">
                            <span class="setting_box_title">Email</span>
                            <input type="text" id="user_em" placeholder="이메일 예: you@example.com" class="setting_box_user_em"/>
                        </div>
                        <div class="settings_nn">
                            <span class="setting_box_title">Nickname</span>
                            <input type="text" id="user_nn" placeholder="닉네임(한글)" class="setting_box_user_nn"/>
                        </div>
                        <button type="button" class="change_infobtn">변경하기</button>
                    </div>
                </div>
            </div>

            <div class="mainContainer" id="page2">
                <div class="mainContainer_team_group">
                    <h1>Team Rocket</h1>
                    <span>안녕하십니까. 사이트를 개발한 Rocket 팀입니다.</span>
                    <span>저희는 YouTube를 모티브하여 회원 간 영상 공유할 수 있는 사이트를 개발하였습니다.</span><br>

                    <h2>Team 소개</h2>
                    <div class="team_user_box">
                        <div class="team_user">
                            <img src="/assets/img/profile.jpeg">
                            <span>Name/Front</span>
                            <p>한줄소개 텍스트</p>
                        </div>
                        <div class="team_user">
                            <img src="/assets/img/profile.jpeg">
                            <span>Name/Front</span>
                            <p>한줄소개 텍스트</p>
                        </div>
                        <div class="team_user">
                            <img src="/assets/img/profile.jpeg">
                            <span>Name/Front</span>
                            <p>한줄소개 텍스트</p>
                        </div>
                        <div class="team_user">
                            <img src="/assets/img/profile.jpeg">
                            <span>Name/Front</span>
                            <p>한줄소개 텍스트</p>
                        </div>
                    </div>
                    <h3>프로젝트 소개</h3>
                </div>

                <hr>
                <div class="rocket_team_github">
                    <a href="https://github.com/web-videohub/web-video-hub"><span class="lnr lnr-earth"></span>Github</a>
                </div>
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