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

    <style>

        .upload-box {
            width: 512px;
            height: 320px;
            border: 3px solid black;
            border-radius: 10px;
            /*display: flex;*/
            /*justify-content: center;*/
            /*align-items: center;*/
            display: inline-block;
            color: red;
            font-weight: 700;
            position: relative;
            overflow: hidden;
        }

        video {
            /*max-width: 100%;*/
            /*max-height: 100%;*/
            object-fit: none;
            width: 512px;
            height: 320px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .thumbnail-box {
            border: 3px solid black;
            border-radius: 10px;
            display: inline-block;
            justify-content: center;
            align-items: center;
            color: red;
            font-weight: 700;
            position: relative;
            overflow: hidden;
        }

        .thumbnail-box img {
            width: 512px;
            height: 320px;
        }

        .info,
        textarea {
            font-size: 18px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 2px solid #000000;
            border-radius: 8px;
        }

        textarea {
            resize: none;
            height: 200px;
        }

        #video-input,
        #thumbnail-input {
            display: none;
        }

        #input-form {
            display: none;
            /*margin-top: 20px;*/
            flex-direction: column;
            gap: 20px;
        }

        .thumbnailContainer {
            display: flex;
            gap: 20px;
            flex-direction: column;
        }


        #upload-btn {
            width: 100%;
            border-radius: 10px;
            height: 50px;
            display: none;
            background-color: #fff;
        }

        .btn-primary {
            margin: 20px 0;
        }

        #videoName,
        #thumbnailName {
            font-size: 20px;
            font-weight: 700;
        }

        .videoInfo {
            display: flex;
            justify-content: space-between;
            align-items: baseline;

        }

        .form-select {
            border: 2px solid black;
        }

        #upload-btn {
            background-color: #5eb2ff;
        }

        #search-thumbnail {
            margin: 0;
        }

        .studioDiv {
            width: 100%;
            height: 100%;

            display: flex;
            justify-content: left;
            align-content: center;
            flex-direction: row;
        }

        .mainContainer {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-content: center;
            /*padding-left: 180px;*/
            padding-top: 80px;
            /*background: #8e8f8c;*/
        }

    </style>

</head>
<body>
<jsp:include page="../include/studio-header.jsp"/>
<jsp:include page="../include/static-head.jsp"/>

<div class="studioDiv">
    <div class="mainContainer">
            <div class="mainContainer">
                <form action="/upload" method="post" enctype="multipart/form-data" id="uploadForm">
                    <div class="upload-box" id="uploadBox"><img src="/assets/img/videoIcon.png" alt="profile"
                                                                style="height: 130px; width: 130px;"></div>
                    <input type="file" name="videoUrl" id="video-input" accept="video/*" onchange="setThumbnail(event)">
                    <div class="videoInfo">
                        <button type="button" id="search-video" class="btn btn-primary">영상 선택</button>
                        <p id="videoName" style="display: none"></p>
                    </div>

                    <div id="input-form">
                        <div class="title">
                            <label for="title">제목</label>
                            <input type="text" id="title" name="videoTitle" class="info" required>
                        </div>

                        <div class="description">
                            <label for="description">간단한 설명</label>
                            <textarea id="description" name="videoContent" rows="4" class="info" required></textarea>
                        </div>

                        <div class="tag">
                            <span>주제를 선택해주세요</span>
                            <select class="form-select" aria-label="Default select example" name="videoCategory">
                                <option selected>-</option>
                                <option value="game">게임</option>
                                <option value="life">일상</option>
                                <option value="animal">동물</option>
                                <option value="nature">자연</option>
                                <option value="dance">댄스</option>
                                <option value="health">헬스</option>
                                <option value="music">음악</option>
                            </select>
                        </div>

                        <div class="thumbnailContainer">
                            <span>썸네일 이미지를 지정해주세요.</span>
                            <div class="thumbnail-box" id="thumbnailBox"><img src="/assets/img/imageIcon.png" alt="profile"
                                                                              style="height: 130px; width: 130px;"></div>
                            <input type="file" name="thumbnailUrl" id="thumbnail-input" accept="image/*"
                                   onchange="setThumbnail(event)">
                            <div class="videoInfo">
                                <button type="button" id="search-thumbnail" class="btn btn-primary">이미지 선택</button>
                                <p id="thumbnailName" style="display: none">선택된 이미지 : </p>
                            </div>
                        </div>
<%--                        <button onclick="submitForm()" id="upload-btn">동영상 업로드</button>--%>
                    </div>

                </form>
            </div>
    </div>
</div>


<div class="studiv">    <!-- flex-direction: coloum -->
    <div class="top">   <!-- flex-direction: row -->
        <h1>동영상 세부 정보</h1>
        <button id="upload-btn">저장</button>
    </div>
    <div class="bottom">        <!-- flex-direction: row -->
        <div class="left">      <!-- flex-direction: coloum -->

        </div>
        <div class="right">     <!-- flex-direction: coloum -->
            <div class="titleDiv">  <!-- 선 회색, bddr -->
                <p>제목</p>
                <label><input type="text"></label>
            </div>
            <div class="contentDiv">
                <p>설명</p>
                <label><textarea rows="4"></textarea></label>
            </div>
            <div class="thumbnailDiv">
                <p>미리보기 이미지</p>
                <p>동영상의 내용을 알려주는 사진을 선택해주세요.</p>
            </div>
        </div>
    </div>
</div>

<script>
    const $box = document.getElementById('uploadBox');
    const $videoInput = document.getElementById('video-input');
    const $thumbnailInput = document.getElementById('thumbnail-input');
    const $form = document.getElementById('input-form');
    const $uploadBtn = document.getElementById('upload-btn')

    const $videoName = document.getElementById('videoName');
    const $thumbnailName = document.getElementById('thumbnailName');

    const $searchVideo = document.getElementById('search-video');
    const $searchThumbnail = document.getElementById('search-thumbnail');

    $searchVideo.onclick = e => {
        $videoInput.click();
    }

    $searchThumbnail.onclick = e => {
        $thumbnailInput.click();
    }

    $videoInput.onchange = e => {
        $form.style.display = 'flex';
        $videoName.style.display = 'inline';
        $uploadBtn.style.display = 'block';
        $searchVideo.textContent = "다시선택하기";
        console.log($uploadBtn);
        setThumbnail(e, $uploadBox, 'video');
        displayFileName(e, $videoName);
    };

    $thumbnailInput.onchange = e => {
        $searchThumbnail.textContent = "다시선택하기";
        $thumbnailName.style.display = 'inline';
        setThumbnail(e, $thumbnailBox, 'img');
        displayFileName(e, $thumbnailName);
    }

    const $uploadBox = document.getElementById('uploadBox');
    const $thumbnailBox = document.getElementById('thumbnailBox');


    function submitForm() {
        document.getElementById('uploadForm').submit();
    }

    function setThumbnail(event, box, tag) {
        const reader = new FileReader();

        reader.onload = function (event) {
            box.innerHTML = ''; // Clear existing content


            const $tag = document.createElement(tag);


            $tag.setAttribute('src', event.target.result);
            if ($tag.tagName.toLowerCase() === "video") {
                $tag.setAttribute('controls', 'controls');
            }


            box.appendChild($tag);
            box.style.border = 'none';
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function displayFileName(event, tag) {
        const fileName = event.target.files[0].name;

        tag.textContent = cutString(fileName, 25);
    }

    function cutString(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }
</script>
</body>
</html>
