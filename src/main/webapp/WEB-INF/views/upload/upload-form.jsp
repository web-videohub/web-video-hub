<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>영상 업로드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/assets/css/studio-header.css">
    <link rel="stylesheet" href="/assets/css/upload-form.css">


    <style>

        /*.upload-box {*/
        /*    width: 512px;*/
        /*    height: 320px;*/
        /*    border: 3px solid black;*/
        /*    border-radius: 10px;*/
        /*    !*display: flex;*!*/
        /*    !*justify-content: center;*!*/
        /*    !*align-items: center;*!*/
        /*    display: inline-block;*/
        /*    color: red;*/
        /*    font-weight: 700;*/
        /*    position: relative;*/
        /*    overflow: hidden;*/
        /*}*/

        /*video {*/
        /*    !*max-width: 100%;*!*/
        /*    !*max-height: 100%;*!*/
        /*    object-fit: none;*/
        /*    width: 512px;*/
        /*    height: 320px;*/
        /*    position: absolute;*/
        /*    top: 50%;*/
        /*    left: 50%;*/
        /*    transform: translate(-50%, -50%);*/
        /*}*/

        /*.thumbnail-box {*/
        /*    border: 3px solid black;*/
        /*    border-radius: 10px;*/
        /*    display: inline-block;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*    color: red;*/
        /*    font-weight: 700;*/
        /*    position: relative;*/
        /*    overflow: hidden;*/
        /*}*/

        /*.thumbnail-box img {*/
        /*    width: 512px;*/
        /*    height: 320px;*/
        /*}*/

        /*.info,*/
        /*textarea {*/
        /*    font-size: 18px;*/
        /*    width: 100%;*/
        /*    padding: 8px;*/
        /*    box-sizing: border-box;*/
        /*    border: 2px solid #000000;*/
        /*    border-radius: 8px;*/
        /*}*/

        /*textarea {*/
        /*    resize: none;*/
        /*    height: 200px;*/
        /*}*/

        /*#video-input,*/
        /*#thumbnail-input {*/
        /*    display: none;*/
        /*}*/

        /*#input-form {*/
        /*    display: none;*/
        /*    !*margin-top: 20px;*!*/
        /*    flex-direction: column;*/
        /*    gap: 20px;*/
        /*}*/

        /*.thumbnailContainer {*/
        /*    display: flex;*/
        /*    gap: 20px;*/
        /*    flex-direction: column;*/
        /*}*/


        /*#upload-btn {*/
        /*    width: 100%;*/
        /*    border-radius: 10px;*/
        /*    height: 50px;*/
        /*    display: none;*/
        /*    background-color: #fff;*/
        /*}*/

        /*.btn-primary {*/
        /*    margin: 20px 0;*/
        /*}*/

        /*#videoName,*/
        /*#thumbnailName {*/
        /*    font-size: 20px;*/
        /*    font-weight: 700;*/
        /*}*/

        /*.videoInfo {*/
        /*    display: flex;*/
        /*    justify-content: space-between;*/
        /*    align-items: baseline;*/

        /*}*/

        /*.form-select {*/
        /*    border: 2px solid black;*/
        /*}*/

        /*#upload-btn {*/
        /*    background-color: #5eb2ff;*/
        /*}*/

        /*#search-thumbnail {*/
        /*    margin: 0;*/
        /*}*/

        /*.studioDiv {*/
        /*    width: 100%;*/
        /*    height: 100%;*/

        /*    display: flex;*/
        /*    justify-content: left;*/
        /*    align-content: center;*/
        /*    flex-direction: row;*/
        /*}*/

        /*.mainContainer {*/
        /*    width: 100%;*/
        /*    height: 100%;*/
        /*    display: flex;*/
        /*    justify-content: center;*/
        /*    align-content: center;*/
        /*    !*padding-left: 180px;*!*/
        /*    padding-top: 80px;*/
        /*    !*background: #8e8f8c;*!*/
        /*}*/

    </style>

</head>
<body>
<jsp:include page="../include/studio-header.jsp"/>
<jsp:include page="../include/static-head.jsp"/>

<%--<div class="studioDiv">--%>
<%--    <div class="mainContainer">--%>
<%--        <div class="mainContainer">--%>
<%--            <form action="/upload" method="post" enctype="multipart/form-data" id="uploadForm">--%>
<%--                <div class="upload-box" id="uploadBox"><img src="/assets/img/videoIcon.png" alt="profile"--%>
<%--                                                            style="height: 130px; width: 130px;"></div>--%>
<%--                <input type="file" name="videoUrl" id="video-input" accept="video/*" onchange="setThumbnail(event)">--%>
<%--                <div class="videoInfo">--%>
<%--                    <button type="button" id="search-video" class="btn btn-primary">영상 선택</button>--%>
<%--                    <p id="videoName" style="display: none"></p>--%>
<%--                </div>--%>

<%--                <div id="input-form">--%>
<%--                    <div class="title">--%>
<%--                        <label for="title">제목</label>--%>
<%--                        <input type="text" id="title" name="videoTitle" class="info" required>--%>
<%--                    </div>--%>

<%--                    <div class="description">--%>
<%--                        <label for="description">간단한 설명</label>--%>
<%--                        <textarea id="description" name="videoContent" rows="4" class="info" required></textarea>--%>
<%--                    </div>--%>

<%--                    <div class="tag">--%>
<%--                        <span>주제를 선택해주세요</span>--%>
<%--                        <select class="form-select" aria-label="Default select example" name="videoCategory">--%>
<%--                            <option selected>-</option>--%>
<%--                            <option value="game">게임</option>--%>
<%--                            <option value="life">일상</option>--%>
<%--                            <option value="animal">동물</option>--%>
<%--                            <option value="nature">자연</option>--%>
<%--                            <option value="dance">댄스</option>--%>
<%--                            <option value="health">헬스</option>--%>
<%--                            <option value="music">음악</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>

<%--                    <div class="thumbnailContainer">--%>
<%--                        <span>썸네일 이미지를 지정해주세요.</span>--%>
<%--                        <div class="thumbnail-box" id="thumbnailBox"><img src="/assets/img/imageIcon.png" alt="profile"--%>
<%--                                                                          style="height: 130px; width: 130px;"></div>--%>
<%--                        <input type="file" name="thumbnailUrl" id="thumbnail-input" accept="image/*"--%>
<%--                               onchange="setThumbnail(event)">--%>
<%--                        <div class="videoInfo">--%>
<%--                            <button type="button" id="search-thumbnail" class="btn btn-primary">이미지 선택</button>--%>
<%--                            <p id="thumbnailName" style="display: none">선택된 이미지 : </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <button onclick="submitForm()" id="upload-btn">동영상 업로드</button>--%>
<%--                </div>--%>

<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>


<form action="/upload" method="post" enctype="multipart/form-data" class="upload-form">
    <div class="studiv">    <!-- flex-direction: coloum -->
        <div class="top">   <!-- flex-direction: row -->
            <h1>동영상 업로드</h1>
<%--            <button class="upload-button" disabled>저장</button>--%>
        </div>

        <div class="bottom">        <!-- flex-direction: row -->
            <div class="left">      <!-- flex-direction: coloum -->
                <div class="titleDiv">  <!-- 선 회색, bddr -->
                    <div class="title-validate">
                        <p class="text">제목</p>
                        <span class="titleChk"></span>
                    </div>
                    <label class="title-label"><input type="text" placeholder="시청자들에게 보여질 제목을 입력해주세요."
                                                      class="title-text" name="videoTitle"></label>
                </div>
                <div class="contentDiv">
                    <div class="content-validate">
                        <p class="text">설명</p>
                        <span class="contentChk"></span>
                    </div>
                    <label class="content-label"><textarea rows="4" placeholder="시청자들에게 동영상에 대해 알려주세요."
                                                           class="content-text" name="videoContent"></textarea></label>
                </div>
                <div class="categoryDiv">
                    <div class="catetoryContainer">
                        <h3>동영상 주제 선택</h3>
                        <p>업로드 할 영상과 어울리는 주제를 선택해주세요.</p>
                        <select class="form-select" aria-label="Default select example" name="videoCategory">
                            <option value="default" selected>-</option>
                            <option value="game">게임</option>
                            <option value="life">일상</option>
                            <option value="animal">동물</option>
                            <option value="nature">자연</option>
                            <option value="dance">댄스</option>
                            <option value="health">헬스</option>
                            <option value="music">음악</option>
                            <option value="not">해당없음</option>
                        </select>
                    </div>
                </div>
                <div class="thumbnailDiv">
                    <h3>미리보기 이미지</h3>
                    <p>동영상의 내용을 알려주는 사진을 선택해주세요.</p>
                    <%-- 썸네일 넣는거 --%>
                    <div class="thumbnailContainer">
                        <div class="thumbnail-box"><img src="/assets/img/imageIcon.png" alt="profile"
                                                        style="height: 130px; width: 130px;"></div>
                        <input type="file" name="thumbnailUrl" accept="image/*" class="thumbnail-input"
                               style="display: none;"
                               onchange="setThumbnail(event)">
                        <div class="videoInfo">
                            <button class="btn-hover color-9 thumbnail-btn" type="button">이미지 선택</button>
                            <span id="thumbnailName" style="display: none;"></span>
                        </div>
                    </div>
                </div>

                <div class="videoDiv">
                    <h3>동영상 업로드</h3>
                    <p>업로드할 동영상을 선택해주세요.</p>
                    <%-- 썸네일 넣는거 --%>
                    <div class="videoContainer">
                        <div class="video-box"><img src="/assets/img/videoIcon.png" alt="profile"
                                                    style="height: 130px; width: 130px;"></div>
                        <input type="file" name="videoUrl" accept="video/*" class="video-input" style="display: none;"
                               onchange="setThumbnail(event)">
                        <div class="videoInfo">
                            <button class="btn-hover color-9 video-btn" type="button">동영상 선택</button>
                            <span id="videoName" style="display: none"></span>
                        </div>
                    </div>
                </div>

            </div>
            <div class="right" style="display: none">     <!-- flex-direction: coloum -->
                <h3>미리보기</h3>
                <div class="preview">
                    <div class="video1">
<%--                        <img id="videoImg" src="/assets/img/winterBG.jpeg" alt="thumbnail"/>--%>
                    </div>
                    <div class="profileContainer">
                        <div class="profile">
                            <img src="/local${sessionScope.login.userProfile}" alt="profile image"/>
                        </div>
                        <div class="videoInfoDiv">
                            <a class="titleA" href="#" style="color: black; text-decoration: none">
                                <span class="preview-title"></span>
                            </a>
                            <span class="uploader">${sessionScope.login.userDisplayName}</span><span class="preview-viewcount"></span>
                        </div>
                    </div>

                </div>
                <div class="uploadBtn">
                    <button class="upload-button btn-hover color-9 video-btn" disabled>업로드</button>
                </div>
            </div>
        </div>
    </div>
</form>

<script>

    const $rightDiv = document.querySelector('.right');

    const $titleDiv = document.querySelector('.titleDiv');
    const $contentDiv = document.querySelector('.contentDiv');

    const $titleInput = document.querySelector('.title-text');
    const $contentInput = document.querySelector('.content-text');

    const $videoBox = document.querySelector('.video-box');
    const $thumbnailBox = document.querySelector('.thumbnail-box');

    const $thumbnailInput = document.querySelector('.thumbnail-input');
    const $videoInput = document.querySelector('.video-input');


    const $searchVideo = document.querySelector('.video-btn');
    const $searchThumbnail = document.querySelector('.thumbnail-btn');

    const $videoName = document.getElementById('videoName');
    const $thumbnailName = document.getElementById('thumbnailName');

    const $titleValidate = document.querySelector('.title-validate');
    const $contentValidate = document.querySelector('.content-validate');

    const $categorySelect = document.querySelector('.form-select');

    const $uploadButton = document.querySelector('.upload-button');

    const $previewTitle = document.querySelector('.preview-title');

    const $previewViewCount = document.querySelector('.preview-viewcount');

    const checkList = [false, false, false, false, false];

    // 제목, 내용 입력값 검증
    $titleInput.onkeyup = e => {
        const titleValue = $titleInput.value;
        // console.log(titleValue);

        $previewTitle.textContent = titleValue;
        $previewViewCount.textContent = `조회수 0회ㆍ방금 전`;

        if (titleValue.trim() === '') {
            $titleDiv.style.borderColor = 'red';
            document.querySelector('.titleChk').innerHTML
                = '<b style="color: red;">제목은 공백일 수 없습니다.</b>';
            checkList[0] = false;
            console.log(titleValue);
        } else {
            $titleDiv.style.borderColor = 'blue';
            document.querySelector('.titleChk').innerHTML ='';
            checkList[0] = true;
            console.log(titleValue);

            if (!checkList.includes(false)) {
                $rightDiv.style.display = 'flex';
                $rightDiv.classList.add('slide-in');
                $uploadButton.disabled = false;

                console.log("다 참이랑께");
            }
        }
    };

    $contentInput.onkeyup = e => {
        const contentValue = $contentInput.value;

        if (contentValue.trim() === '') {
            $contentDiv.style.borderColor = 'red';
            document.querySelector('.contentChk').innerHTML
                = '<b style="color: red;">내용은 공백일 수 없습니다.</b>';
            checkList[1] = false;
            console.log(contentValue);
        } else {
            $contentDiv.style.borderColor = 'blue';
            document.querySelector('.contentChk').innerHTML ='';
            checkList[1] = true;
            console.log(contentValue);


            if (!checkList.includes(false)) {
                $rightDiv.style.display = 'flex';
                $rightDiv.classList.add('slide-in');
                $uploadButton.disabled = false;
                console.log("다 참이랑께");
            }
        }
    };

    // 카테고리 선택 여부 검증
    $categorySelect.onchange = e => {
        checkList[2] = $categorySelect.value !== 'default';

        if (!checkList.includes(false)) {
            $rightDiv.style.display = 'flex';
            $rightDiv.classList.add('slide-in');
            $uploadButton.disabled = false;
            console.log("다 참이랑께");
        }
    };


    // 썸네일 첨부여부 검증
    $thumbnailInput.addEventListener("change", e => {
        checkList[3] = true;

        if (!checkList.includes(false)) {
            $rightDiv.style.display = 'flex';
            $rightDiv.classList.add('slide-in');
            $uploadButton.disabled = false;
            console.log("다 참이랑께");
        }
    });

    // 동영상 첨부여부 검증
    $videoInput.addEventListener("change", e => {
        checkList[4] = true;
        console.log(checkList);
        if (!checkList.includes(false)) {
            $rightDiv.style.display = 'flex';
            $rightDiv.classList.add('slide-in');
            $uploadButton.disabled = false;
            window.scrollTo(0, 0);
            console.log("다 참이랑께");
        }
    });


    $searchVideo.onclick = e => {
        $videoInput.click();
    }

    $searchThumbnail.onclick = e => {
        $thumbnailInput.click();
    }


    $videoInput.addEventListener('change', e => {
            $videoName.style.display = 'inline';
            $searchVideo.textContent = "다시 선택하기";
            setThumbnail(e, $videoBox, 'video');
            displayFileName(e, $videoName);
        }
    );


    $thumbnailInput.onchange = e => {
        $thumbnailName.style.display = 'inline';
        $searchThumbnail.textContent = "다시 선택하기";
        setThumbnail(e, $thumbnailBox, 'img');
        displayFileName(e, $thumbnailName);
    }

    /**
     * 폼을 제출하는 함수
     */
    function submitForm() {
        document.getElementById('uploadForm').submit();
    }

    /**
     *
     * @param event 호출한 이벤트의 e
     * @param box 이미지를 집어넣을 부모 요소
     * @param tag 생성할 요소의 태그
     */
    function setThumbnail(event, box, tag) {
        const reader = new FileReader();

        reader.onload = function (event) {
            box.innerHTML = ''; // Clear existing content


            const $tag = document.createElement(tag);
            $tag.style.border = '2px solid grey';
            $tag.style.borderRadius = '5px';

            $tag.setAttribute('src', event.target.result);
            if ($tag.tagName.toLowerCase() === "video") {
                $tag.setAttribute('controls', 'controls');
                box.appendChild($tag);

            } else if ($tag.tagName.toLocaleLowerCase() === "img") {
                const $previewContainer = document.querySelector('.video1');
                $previewContainer.innerHTML = '';
                $previewContainer.appendChild($tag.cloneNode(true));
                box.appendChild($tag);
            }


            box.style.border = 'none';

        };
        reader.readAsDataURL(event.target.files[0]);
    }

    /**
     *
     * @param event 호출한 이벤트의 e
     * @param tag 텍스트가 들어갈 요소
     */
    function displayFileName(event, tag) {
        const fileName = event.target.files[0].name;
        tag.textContent = "선택된 파일 : " + cutString(fileName, 40);
    }

    /**
     *
     * @param str 변환 전 텍스트
     * @param maxLength 글자를 자를 지점
     * @returns {*|string} 변환된 텍스트
     */
    function cutString(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }


    // 스타일 변경 부분
    $titleInput.addEventListener('focus', evt => {
        $titleDiv.style.borderColor = 'blue';
    });

    $titleInput.addEventListener('blur', evt => {
        $titleDiv.style.borderColor = 'grey';
    });

    $contentInput.addEventListener('focus', eve => {
        $contentDiv.style.borderColor = 'blue';
    });

    $contentInput.addEventListener('blur', eve => {
        $contentDiv.style.borderColor = 'grey';
    })


</script>
</body>
</html>
