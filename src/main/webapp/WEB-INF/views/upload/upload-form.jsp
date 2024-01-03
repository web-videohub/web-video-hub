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
    <style>
        .upload-box,
        .thumbnail-box {
            width: 512px;
            height: 320px;
            border: 3px solid black;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: red;
            font-weight: 700;
            position: relative;
            overflow: hidden;
        }

        .thumbnail-box img {

        }

        input[type="text"],
        textarea {
            font-size: 18px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 2px solid #000000;
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.8);
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

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #fff;
        }

        .uploadContainer {
            padding: 50px;
            width: 50%;
            border: 2px solid white;
            border-radius: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #dadada;
        }

        video {
            max-width: 100%;
            max-height: 100%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
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

        #videoName {
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
    </style>

</head>
<body>
<h2>Video Upload Form</h2>

<div class="uploadContainer">


    <form action="/upload" method="post" enctype="multipart/form-data" id="uploadForm">
        <div class="upload-box" id="uploadBox"><img src="/assets/img/videoIcon.png" alt="profile"
                                                    style="height: 130px; width: 130px;"></div>
        <input type="file" name="videoUrl" id="video-input" accept="video/*" onchange="setThumbnail(event)">
        <div class="videoInfo">
            <button type="button" id="search-video" class="btn btn-primary">영상 선택</button>
            <p id="videoName" style="display: none">선택된 영상 : </p>
        </div>

        <div id="input-form">
            <div class="title">
                <label for="title">제목</label>
                <input type="text" id="title" name="videoTitle" required>
            </div>

            <div class="description">
                <label for="description">간단한 설명</label>
                <textarea id="description" name="videoContent" rows="4" required></textarea>
            </div>

            <div class="tag">
                <select class="form-select" aria-label="Default select example" name="videoCategory">
                    <option selected>주제를 선택해주세요.</option>
                    <option value="game">게임</option>
                    <option value="cook">요리</option>
                    <option value="health">건강</option>
                </select>
            </div>

            <div class="thumbnail-box" id="thumbnailBox"><img src="/assets/img/imageIcon.png" alt="profile"
                                                              style="height: 130px; width: 130px;"></div>
            <input type="file" name="videoUrl" id="thumbnail-input" accept="image/*" onchange="setThumbnail(event)">
            <div class="videoInfo">
                <button type="button" id="search-thumbnail" class="btn btn-primary">이미지 선택</button>
                <p id="thumbnailName" style="display: none">선택된 이미지 : </p>
            </div>

            <button onclick="submitForm()" id="upload-btn">동영상 업로드</button>
        </div>

    </form>


</div>

<script>
    const $box = document.getElementById('uploadBox');
    const $videoInput = document.getElementById('video-input');
    const $thumbnailInput = document.getElementById('thumbnail-input');
    const $form = document.getElementById('input-form');
    const $uploadBtn = document.getElementById('upload-btn')

    const $videoName = document.getElementById('videoName');

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
        displayFileName(e);
    };

    $thumbnailInput.onchange = e => {
        setThumbnail(e, $thumbnailBox, 'img');
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

    function displayFileName(event) {
        const fileName = event.target.files[0].name;
        $videoName.textContent = fileName;
    }
</script>
</body>
</html>
