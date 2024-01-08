<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/subs.css">
    <link rel="stylesheet" href="/assets/css/filter.css">
    <title>구독채널 최신영상</title>

    <style>
        .loader {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>
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
            <li class="nav-item home">
                <a class="nav-link" href="/subs">
                    <span class="lnr lnr-book"></span>
                    구독
                </a>
            </li>
            <hr>
            <c:if test="${sessionScope.login != null}">
                <li class="nav-item">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">나 ></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
                        <span class="lnr lnr-user"></span>
                        내 채널
                    </a>
                </li>
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
            </c:if>
            <c:if test="${sessionScope.login == null}">
                <div class="left-login-btn">
                    <p>로그인하면 동영상에 좋아요를 표시하고 댓글을 달거나 구독할 수 있습니다.</p>
                    <a class="login" href="/login">
                        <span class="lnr lnr-user"></span>
                        로그인
                    </a>
                </div>
            </c:if>
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
            <li class="nav-item2 home">
                <a class="nav-link" href="/subs">
                    <span class="lnr lnr-book"></span><br>
                    <span class="sideText">구독</span>
                </a>
            </li>
            <c:if test="${sessionScope.login != null}">
                <li class="nav-item2">
                    <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
                        <span class="lnr lnr-user"></span><br>
                        <span class="sideText">나</span>
                    </a>
                </li>
                <li class="nav-item2">
                    <a class="nav-link" href="/setting">
                        <span class="lnr lnr-cog"></span><br>
                        <span class="sideText">설정</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
</div>
<c:if test="${sessionScope.login != null}">
    <div class="mainContainer">
        <div class="subContainer">
            <div class="subDiv">
                <span class="subTitle">최신순</span>
            </div>
                <%-- 서버에 업로드된 영상들이 연속적으로 나타날 div --%>
            <div class="videoListDiv">

            </div>
            <div id="loader" class="loader" style="text-align: center; visibility: hidden"></div>
        </div>
    </div>
</c:if>
<c:if test="${sessionScope.login == null}">
    <div class="nonLogin">
        <h2>새로운 동영상을 놓치지 마세요.</h2>
        <span>즐겨찾는 Video hub 채널의 업데이트를 확인하려면 로그인하세요.</span>
        <a class="login" href="/login">
            <span class="lnr lnr-user"></span>
            로그인
        </a>
    </div>
</c:if>
<script>

    const options = {
        root: null,
        rootMargin: '0px',
        threshold: 0.5,
    };


    const handleIntersection = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                loadData(selectedValue);
            }
        });
    };


    const observer = new IntersectionObserver(handleIntersection, options);


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

    const loadData = async (type) => {
        console.log('loadData function called');
        if (loading) return;

        loading = true;
        loader.style.visibility = "visible";

        setTimeout(async () => {
            try {
                const response = await fetch(`/loadMoreVideosSub?pageNumber=\${pageNumber}&pageSize=12&type=` + type + `&account=${sessionScope.login.userAccount}`);
                const newVideos = await response.json();

                if (newVideos.length > 0) {
                    newVideos.forEach(video => {
                        const newItem = document.createElement('div');
                        newItem.className = 'videoDiv';
                        newItem.setAttribute('data-videoId', `\${video.videoId}`);
                        newItem.innerHTML = `<a class="video" href="#"><img id="videoImg" src="/local\${video.thumbnailUrl}" alt="thumbnail" data-videoId="\${video.videoId}"/></a>` +
                            `<div class="profileContainer"><div class="profile"><img class="profile" src="/local\${video.userProfileImage}" alt="profile image"  data-uploader="\${video.videoUploadUser}"/></div>` +
                            `<div class="videoInfoDiv"><a class="titleA" href="#"><span class="title" data-videoId="\${video.videoId}">\${video.videoTitle}</span></a>` +
                            `<span class="uploader" data-uploader="\${video.videoUploadUser}">\${video.userDisplayName}</span><span class="viewcount">조회수 \${video.videoViewCount}회ㆍ\${formatTimeAgo(video.videoUploadDate)}</span></div></div>`;
                        videoListDiv.appendChild(newItem);

                        newItem.addEventListener('click', e => {
                            if (!e.target) return;
                            console.log(e.target.className);
                            if (e.target.id === 'videoImg' || e.target.className === 'title') {
                                window.location.href = "/showmv?videoId=" + e.target.dataset.videoid;
                            }
                            if (e.target.className === 'profile' || e.target.className === 'uploader') {
                                window.location.href = "/userPage?channelName=" + e.target.dataset.uploader;
                            }
                        });
                    });

                    pageNumber++;


                } else {
                    observer.unobserve(loader);
                    console.log('Observer unobserved');
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            } finally {
                loading = false;
                loader.style.visibility = "hidden";
            }
        }, 500);
    };
    const loader = document.getElementById('loader');
    const videoListDiv = document.querySelector('.videoListDiv');
    let loading = false;
    let pageNumber = 1;


    document.addEventListener("DOMContentLoaded", function () {
        observer.observe(loader);
    });

    const $radioButtons = document.querySelectorAll('input[type=radio][name=filter]');
    let selectedRadioButton = null;
    let selectedValue = null;

    $radioButtons.forEach((radio) => {
        radio.addEventListener('change', function (radio) {
            selectedValue = this.value;
            document.querySelector('.videoListDiv').innerHTML = '';
            pageNumber = 1;
            loadData(selectedValue);
            observer.observe(loader);

            console.log(selectedValue);
            if (selectedRadioButton) {
                selectedRadioButton.parentNode.style.background = '';
                selectedRadioButton.parentNode.style.color = '';
            }


            this.parentNode.style.background = '#F2B950';
            this.parentNode.style.color = '#fff';

            selectedRadioButton = this;
        })
    });

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
            if (isClick === side2) {
                $leftDiv2.style.display = 'flex';
                $leftDiv.style.display = 'none';
                $headerBtn2.style.display = 'flex';
                $headerBtn.style.display = 'none';
            }


        } else if (pageWidth > 640) {
            $leftDiv.style.display = 'none';
            $leftDiv2.style.display = 'flex';
            $headerBtn2.style.display = 'none';
            $headerBtn.style.display = 'flex';
        } else if (pageWidth <= 640) {
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
        } else if (isClick === side2) {
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

    window.addEventListener('resize', function () {
        pageWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        checkWidth();
    });
</script>
</body>
</html>