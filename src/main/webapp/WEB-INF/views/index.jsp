<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/index.css">
    <link rel="stylesheet" href="/assets/css/filter.css">
    <title>VideoHub</title>

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
        <jsp:include page="include/filter.jsp"/>

        <div class="videoListDiv">

        </div>
        <div id="loader" class="loader" style="text-align: center; visibility: hidden"></div>
    </div>
</div>
<script>

    const options = {
        root: null,
        rootMargin: '0px',
        threshold: 0.5,
    };


    const handleIntersection = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                console.log("Intersection observed!");
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
                const response = await fetch(`/loadMoreVideos?pageNumber=\${pageNumber}&pageSize=12&type=` + type);
                const newVideos = await response.json();

                if (newVideos.length > 0) {
                    newVideos.forEach(video => {
                        const newItem = document.createElement('div');
                        newItem.className = 'videoDiv';
                        newItem.innerHTML = `<a class="video"><img src="/local\${video.thumbnailUrl}" alt="thumbnail"/></a>` +
                            `<div class="profileContainer"><div class="profile"><img src="/local\${video.userProfileImage}" alt="profile image"/></div>` +
                            `<div class="videoInfoDiv"><a class="titleA" href="#"><span class="title">\${video.videoTitle}</span></a>` +
                            `<span class="uploader">\${video.videoUploadUser}</span><span class="viewcount">조회수 \${video.videoViewCount}회ㆍ\${formatTimeAgo(video.videoUploadDate)}</span></div></div>`;
                        videoListDiv.appendChild(newItem);
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
        }, 1000);
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

    const $all = document.getElementById('all');

    (() => {
        $all.click();
    })();

</script>
</body>
</html>