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
                <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">나 ></a>
            </li>
            <c:if test="${sessionScope.login.userAccount eq user.channelAccount}">
                <li class="nav-item home">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
                        <span class="lnr lnr-user"></span>
                        내 채널
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionScope.login.userAccount ne user.channelAccount}">
                <li class="nav-item">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
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
            <c:if test="${sessionScope.login.userAccount eq user.channelAccount}">
                <li class="nav-item2 home">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
                        <span class="lnr lnr-user"></span><br>
                        <span class="sideText">나</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionScope.login.userAccount ne user.channelAccount}">
                <li class="nav-item2">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
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
        <img src="/local${user.channelProfile}" alt="profile image" class="pimg"/>
        <div class="channelProfile">
            <p class="channelName">${user.channelName}</p>
            <p class="channelEmail">이메일: ${user.channelEmail}</p>
            <%--                <p class="channelName">김다빈</p>--%>
            <p class="channelAccount">@${user.channelAccount} ＊ 구독자 ${user.subCount}명 ＊ 동영상 ${user.videoCount}개</p>
            <%--                <p class="channelAccount">@kimdaveen ㆍ 구독자 0명 ㆍ 동영상 0개</p>--%>
            <c:if test="${sessionScope.login.userAccount ne user.channelAccount}">
                <button type="button" class="subscribe_B">구독</button>
            </c:if>
            <c:if test="${sessionScope.login.userAccount eq user.channelAccount}">
                <a href="/studio" class="studioBtn chBtn">스튜디오</a>
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
    const URL = '/api/v1/subscribe';
    const userAccount = '${sessionScope.login.userAccount}';
    const receiverAccount = '${user.channelAccount}';
    console.log(userAccount);
    console.log(receiverAccount);
    const $subBtn = document.querySelector('.subscribe_B');

    // 서버에 실시간으로 비동기통신을 해서 JSON을 받아오는 함수
    function fetchGetSub() {
        fetch(URL + `/${sessionScope.login.userAccount}/${user.channelAccount}`)
            .then(res => res.json())
            .then(flag => {
                if (flag) {
                    $subBtn.classList.add('chBtn2');
                    $subBtn.style.display = 'block';
                    $subBtn.style.width = '110px';
                    $subBtn.textContent = '구독취소';
                    $subBtn.style.background = '#EBEBEB';
                    $subBtn.style.color = 'black';
                    $subBtn.removeEventListener('click', makeSub);
                    $subBtn.addEventListener('click', e => {
                        fetchDeleteSub();
                    });
                } else {
                    $subBtn.classList.add('chBtn');
                    $subBtn.style.display = 'block';
                    $subBtn.style.width = '80px';
                    $subBtn.textContent = '구독';
                    $subBtn.style.background = 'black';
                    $subBtn.style.color = 'white';
                    $subBtn.removeEventListener('click', fetchDeleteSub);
                    $subBtn.addEventListener('click', e => {
                        makeSub();
                    })
                }

            })
        ;
    }

    function fetchDeleteSub() {
        const requestInfo = {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        };
        fetch(URL + `/${sessionScope.login.userAccount}/${user.channelAccount}`, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    $subBtn.classList.add('chBtn');
                    $subBtn.classList.remove('chBtn2');
                    $subBtn.style.width = '80px';
                    $subBtn.textContent = '구독';
                    $subBtn.style.background = 'black';
                    $subBtn.style.color = 'white';
                    $subBtn.removeEventListener('click', fetchDeleteSub);
                    $subBtn.addEventListener('click', e => {
                        makeSub();
                    })
                    return res.json();
                } else {
                    alert('구독취소 실패!');
                    return res.text();
                }
            })
    }


    function makeSub() {
        // 서버로 보낼 데이터
        const payload = {
            subSender: userAccount,
            subReceiver: receiverAccount
        };

        // GET방식을 제외한 요청의 정보 만들기
        const requestInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };
        fetch(URL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    $subBtn.classList.add('chBtn2');
                    $subBtn.classList.remove('chBtn');
                    $subBtn.style.width = '110px';
                    $subBtn.textContent = '구독취소';
                    $subBtn.style.background = '#EBEBEB';
                    $subBtn.style.color = 'black';
                    $subBtn.removeEventListener('click', makeSub);
                    $subBtn.addEventListener('click', e => {
                        fetchDeleteSub();
                    });
                    return res.json();
                } else {
                    return res.text();
                }
            })
    }

    // const $CancelBtn = document.getElementById('cancel');
    // $CancelBtn.addEventListener('click', e => {
    //
    // });
    // // 구독을 이미 한 사람이라면..
    // $subBtn.style.width = '110px';
    // $subBtn.textContent = '구독취소';
    // $subBtn.setAttribute("id", "cancel");
    // // 구독을 안 한 사람이라면..




    let $thumbnail = document.querySelectorAll('.chVideo');
    $thumbnail.forEach(function ($thumbnail) {
        $thumbnail.addEventListener('click', e => {
            window.location.href = "/showmv?videoId=" + e.target.dataset.videoid;
        });
    });
    let $chTitle = document.querySelectorAll('.chTitle');
    $chTitle.forEach(function ($chTitle) {
        $chTitle.addEventListener('click', e => {
            window.location.href = "/showmv?videoId=" + e.target.dataset.videoid;
        });
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

    (() => {
        // 구독여부 확인하기
        fetchGetSub();
    })();
</script>
</body>
</html>