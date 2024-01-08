<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 채널</title>
    <link rel="stylesheet" href="/assets/css/studio-header.css">
    <link rel="stylesheet" href="/assets/css/studio.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

    <!-- https://linearicons.com/free#cdn -->
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
</head>
<body>
<jsp:include page="include/studio-header.jsp"/>
<%--<jsp:include page="include/static-head.jsp"/>--%>

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
            <li class="nav-item">
                <a class="nav-link" href="/userPage?channelName=${sessionScope.login.userAccount}">
                    <span class="lnr lnr-user"></span>
                    내 채널
                </a>
            </li>
            <li class="nav-item  home">
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
            <li class="nav-item2 home">
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

        </ul>
    </div>
</div>
<div class="mainContainer">
    <div class="top">
        <%--            <a href="/studio/upload">동영상 업로드</a>--%>
        <button class="btn-hover color-9" id="go-upload-form">동영상 업로드</button>
        <button class="btn-hover color-8" id="deleteBtn" type="button">체크된 동영상 삭제</button>
    </div>

    <div class="video-table">
        <table>
            <thead>
            <tr>
                <th class="allsel">전체선택<input type="checkbox" class="select-all"/></th>
                <th class="video-th">동영상</th>
                <th>제목</th>
                <th>날짜</th>
                <th>조회수</th>
                <th>댓글</th>
                <th>좋아요</th>
                <th>싫어요</th>
            </tr>
            </thead>
            <tbody class="video-tbody">
            <tr>

            </tr>
            </tbody>
            <tfoot>
            <td colspan="8" class="tablefoot"></td>
            </tfoot>
        </table>
    </div>
    <div id="loader" class="loader" style="text-align: center; visibility: hidden"></div>
</div>

<script>

    const $goUploadForm = document.getElementById('go-upload-form');

    $goUploadForm.onclick = e => {
        window.location.href = "/studio/upload";
    };


    function formatDate(isoDateString) {
        const dateObj = new Date(isoDateString);
        const year = dateObj.getFullYear();
        const month = ("0" + (dateObj.getMonth() + 1)).slice(-2);
        const day = ("0" + dateObj.getDate()).slice(-2);
        const hours = ("0" + dateObj.getHours()).slice(-2);
        const minutes = ("0" + dateObj.getMinutes()).slice(-2);
        return `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
    }

    const options = {
        root: null,
        rootMargin: '0px',
        threshold: 0.5,
    };


    const handleIntersection = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                loadData("ee");
                console.log("옵저버 작동됨");
            }
        });
    };


    const observer = new IntersectionObserver(handleIntersection, options);

    const $videoTbody = document.querySelector('.video-tbody');
    const $loader = document.getElementById('loader');

    const loadData = async (type) => {
        if (loading) return;

        loading = true;
        $loader.style.visibility = "visible";

        setTimeout(async () => {
            try {
                const response = await fetch(`/loadMyVideoInfo?pageNumber=\${pageNumber}&pageSize=12&account=${sessionScope.login.userAccount}&type=` + type + `&keyword=${keyword}`);
                const myVideos = await response.json();
                console.log(myVideos);

                if (myVideos.length > 0) {
                    console.log("데이터 불러와짐");
                    myVideos.forEach(video => {
                        const newItem = document.createElement('tr');

                        newItem.innerHTML = `
                            <td><input type="checkbox" data-videoId="\${video.videoId}"></td>
                            <td><img src="/local\${video.thumbnailUrl}" alt="동영상 사진" /></td>
                            <td>\${video.videoTitle}</td>
                            <td>\${formatDate(video.videoUploadDate)}</td>
                            <td>\${video.videoViewCount}회</td>
                            <td>\${video.replyCount}개</td>
                            <td>\${video.videoLike}개</td>
                            <td>\${video.videoHate}개</td>
                        `;

                        $videoTbody.appendChild(newItem);
                    });

                    pageNumber++;
                } else {
                    observer.unobserve($loader);
                }
            } catch (e) {
                console.error(e);
            } finally {
                loading = false;
                $loader.style.visibility = "hidden";
            }
        }, 5


        00)
    }

    let loading = false;
    let pageNumber = 1;


    document.addEventListener("DOMContentLoaded", function () {
        observer.observe($loader);
    });

    document.querySelector('.select-all').addEventListener('change', e => {
        let checkboxes = document.querySelectorAll('.video-tbody input[type="checkbox"]');
        for (let checkbox of checkboxes) {
            checkbox.checked = e.target.checked;
        }
    });


    document.getElementById('deleteBtn').addEventListener('click', async function() {
        // Collect all checked checkbox values (video Ids)
        let checkedVideos = Array.from(document.querySelectorAll('.video-tbody input[type="checkbox"]:checked')).map(chk => chk.getAttribute('data-videoId'));

        // Check if there are checked videos
        if (checkedVideos.length > 0) {
            try {
                const response = await fetch('/delete-checked-video', {
                    method: 'delete',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(checkedVideos),
                });
                if(response.ok) {
                    alert('선택된 동영상이 삭제됐습니다.');
                    window.location.href = '/studio';
                } else {
                    alert('에러가 발생했습니다.');
                }
            } catch(err) {
                console.error(err);
            }
        } else {
            alert('동영상을 선택해주세요');
        }
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

    const $all = document.getElementById('all');

    (() => {
        $all.click();

    })();




</script>
</body>
</html>