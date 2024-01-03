<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/index.css">
    <link rel="stylesheet" href="/assets/css/filter.css">
    <title>메인화면</title>

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
<div class="leftDiv">
    <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
            <li class="nav-item home">
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
    <div class="subContainer">
        <%-- 영상 리스트를 렌더링할때 조건을 건다 (최신영상, 인기많은영상, 최다조회수영상 등)--%>
        <jsp:include page="include/filter.jsp"/>

        <%-- 서버에 업로드된 영상들이 연속적으로 나타날 div --%>
        <div class="videoListDiv">
<%--            <c:forEach var="v" items="${vList}">--%>
<%--                <div class="videoDiv">--%>
<%--                    <a class="video">--%>
<%--                        <img src="/local${v.thumbnailUrl}" alt="thumbnail"/>--%>
<%--                    </a>--%>
<%--                    <div class="profileContainer">--%>
<%--                        <div class="profile">--%>
<%--                            <img src="/local${v.userProfileImage}" alt="profile image"/>--%>
<%--                        </div>--%>
<%--                        <div class="videoInfoDiv">--%>
<%--                            <a class="titleA" href="#"><span class="title">${v.videoTitle}</span></a>--%>
<%--                            <span class="uploader">${v.videoUploadUser}</span>--%>
<%--                            <span class="viewcount">${v.videoViewCount} § ${v.videoUploadDate}</span>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:forEach>--%>
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

</script>
</body>
</html>