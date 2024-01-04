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
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
            <li class="nav-item2">
                <a class="nav-link" href="/studio">
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

        </ul>
    </div>
</div>
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
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const videoListDiv = document.querySelector('.videoListDiv');
        const loader = document.getElementById('loader');
        let loading = false;
        let pageNumber = 1; // 페이지 번호 초기값 추가

        const loadData = async () => {
            console.log('loadData function called');
            // 이미 로딩 중이라면 중복으로 로딩하지 않도록 체크
            if (loading) return;

            loading = true;
            loader.style.visibility = "visible";

            setTimeout(async () => {
                try {
                    const response = await fetch(`/loadMoreVideos?pageNumber=\${pageNumber}&pageSize=12`);
                    const newVideos = await response.json();

                    if (newVideos.length > 0) {
                        newVideos.forEach(video => {
                            const newItem = document.createElement('div');
                            newItem.className = 'videoDiv';
                            newItem.innerHTML = `<a class="video"><img src="/local\${video.thumbnailUrl}" alt="thumbnail"/></a>` +
                                `<div class="profileContainer"><div class="profile"><img src="/local\${video.userProfileImage}" alt="profile image"/></div>` +
                                `<div class="videoInfoDiv"><a class="titleA" href="#"><span class="title">\${video.videoTitle}</span></a>` +
                                `<span class="uploader">\${video.videoUploadUser}</span><span class="viewcount">\${video.videoViewCount} § \${video.videoUploadDate}</span></div></div>`;
                            videoListDiv.appendChild(newItem);
                        });

                        pageNumber++; // 다음 페이지를 위해 페이지 번호를 증가
                    } else {
                        // 데이터가 더 이상 없을 경우, 옵저버 해제
                        observer.unobserve(loader);
                        console.log('Observer unobserved');
                    }
                } catch (error) {
                    console.error('Error fetching data:', error);
                } finally {
                    loading = false;
                    loader.style.visibility = "hidden";
                }
            }, 2000); // 3초
        };

        const options = {
            root: null,
            rootMargin: '0px',
            threshold: 0.5,
        };

        const handleIntersection = (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    console.log("Intersection observed!");
                    loadData();
                    loader.style.display = 'block';
                }
            });
        };

        const observer = new IntersectionObserver(handleIntersection, options);
        observer.observe(loader);

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