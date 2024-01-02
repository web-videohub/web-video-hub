<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>영상 업로드</title>

    <style>
        .upload-box {
            width: 150px;
            height: 150px;
            border: 3px dashed orange;
            display: flex;
            justify-content: center;
            align-items: center;
            color: red;
            font-weight: 700;
            cursor: pointer;
        }

        #video-input {
            display: none;
        }

        #input-form {
            display: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<h2>Video Upload Form</h2>

<div class="upload-box" id="uploadBox">파일 첨부</div>

<form action="/upload" method="post" enctype="multipart/form-data" id="uploadForm">
    <input type="file" name="thumbnail" id="video-input" accept="video/*" required>
</form>

<div id="input-form">
    <form>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>
        <br>
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea>
    </form>
</div>

<button onclick="submitForm()">Submit</button>

<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>

<c:if test="${not empty successMessage}">
    <p style="color: green;">${successMessage}</p>
</c:if>

<script>
    const $box = document.getElementById('uploadBox');
    const $input = document.getElementById('video-input');
    const $form = document.getElementById('input-form');
    const $submitButton = document.querySelector('button');

    $box.onclick = e => {
        $input.click();
    };

    $input.onchange = e => {
        $form.style.display = 'block';
    };

    function submitForm() {
        // You can add additional validation or processing here before submitting the form
        document.getElementById('uploadForm').submit();
    }
</script>
</body>
</html>
