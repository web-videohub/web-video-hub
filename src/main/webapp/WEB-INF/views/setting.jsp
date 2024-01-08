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
                <a href="#" class="showContainer">계정정보 변경하기</a>
            </div>
        </div>
        <div class="user_setting_container" style="display: none">

            <form action="/update" class="user_setting_container_group">
                <div class="settings_id">
                    <input type="text" value="${sessionScope.login.userAccount}" style="visibility: hidden" name="account">
                    <div class="span-container">
                        <span class="setting_box_title">닉네임</span>
                        <span class="nickname-chk">가나다</span>
                    </div>
                    <input type="text" id="user_id" placeholder="닉네임" class="setting_box_user_id" name="nickname"/>
                </div>
                <div class="btnContainer">
                <button type="submit" class="change_infobtn">변경하기</button>
                </div>
            </form>


        </div>
    </div>

    <div class="mainContainer" id="page2">
        <div class="mainContainer_team_group">
            <h1>Team Rocket</h1>
            <span>안녕하세요! 사이트를 개발한 Rocket 팀입니다.</span>
            <span>저희는 YouTube를 모티브로 회원 간 영상 공유할 수 있는 사이트를 제작했습니다.</span><br>

            <h2>Team 소개</h2>
            <a class="org" href="https://github.com/web-videohub/web-video-hub">프로젝트 깃허브 링크</a>
            <div class="team_user_box">
                <div class="team_user">
                    <img src="/assets/img/team1.png">
                    <span>팀장_김용섭/Back</span>
                    <a href="https://github.com/yongseopK">깃허브 링크</a>
                </div>
                <div class="team_user">
                    <img src="/assets/img/team2.jpg">
                    <span>김다빈/Front</span>
                    <a href="https://github.com/daveen99">깃허브 링크</a>
                </div>
                <div class="team_user">
                    <img src="/assets/img/team3.jpg">
                    <span>태은선/Front</span>
                    <a href="https://github.com/sarimiro56">깃허브 링크</a>
                </div>
                <div class="team_user">
                    <img src="/assets/img/team4.png">
                    <span>송민건/Back</span>
                    <a href="https://github.com/smg0218">깃허브 링크</a>
                </div>
            </div>
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

    let checkName = false;


    const $modifyBtn = document.querySelector('.showContainer');
    const $container = document.querySelector('.user_setting_container');

    const $userIdInput = document.getElementById('user_id');
    const $idChk = document.querySelector('.nickname-chk');


    // 닉네임 검증
    (function () {
        const namePattern = /^[가-힣]+$/;
        const currentUserName = `${sessionScope.login.userDisplayName}`;
        console.log(currentUserName);

        $userIdInput.addEventListener('keyup', e => {
            const userIdValue = $userIdInput.value;

            if (userIdValue.trim() === '') {
                $userIdInput.style.borderColor = 'red';
                $idChk.innerHTML = '<b style="color: red;">[이름을 입력해주세요]</b>';
                checkName = false;
            } else if (!namePattern.test(userIdValue)) {
                $userIdInput.style.borderColor = 'red';
                $idChk.innerHTML = '<b style="color: red;">[이름은 한글로 입력해주세요]</b>';
                checkName = false;
            } else if (userIdValue === currentUserName) {
                $userIdInput.style.borderColor = 'red';
                $idChk.innerHTML = '<b style="color: red;">[현재 닉네임과 같습니다.]</b>';
                checkName = false;
            } else {
                fetch('check?type=displayName&keyword=' + userIdValue)
                    .then(res => res.json())
                    .then(flag => {
                        if (flag) {
                            $userIdInput.style.borderColor = 'red';
                            $idChk.innerHTML = '<b style="color: red;">[닉네임이 중복됐습니다.]</b>';
                            checkName = false;
                        } else {
                            $userIdInput.style.borderColor = 'skyblue';
                            $idChk.innerHTML = '';
                            checkName = true;
                        }
                    });
            }
        });
    })();

    $modifyBtn.addEventListener('click', e => {
        e.preventDefault();
        $container.style.display = 'block';
    });

    $userIdInput.placeholder = `${sessionScope.login.userDisplayName} (변경하지 않으시려면 입력하지 마세요)`


</script>
</body>
</html>