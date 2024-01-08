<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/sign-up.css">
    <title>회원가입</title>
    <style>
        .upload-box {
            width: 130px;
            height: 130px;
            border: 3px solid black;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: red;
            font-weight: 700;
            cursor: pointer;

            overflow: hidden;
        }

        #uploadBox img {
            width: 130px;
            height: 130px;
        }

        #profile-input {
            display: none;
        }

        .profileImgContainer {
            display: flex;
            justify-content: center;
            align-items: center;
            width: inherit;
        }
    </style>
</head>
<body>
<div id="snowfall"></div>

<div class="registerDiv">
    <img id="santa" src="/assets/img/rabbit.png" alt="">

    <form class="registerForm" action="/register" method="POST" enctype="multipart/form-data">
        <div class="registerTitle">
            <h2>계정 만들기</h2>
        </div>
        <div class="profileImgContainer">
            <div class="upload-box" id="uploadBox"><img src="/assets/img/profile.jpeg" alt="profile" style="height: 130px; width: 130px;"> </div>
            <input type="file" name="profileImage" id="profile-input" accept="image/*" onchange="setThumbnail(event)">
            <span>프로필 업로드</span>
        </div>

        <div class="inputDiv">
            <span class="inputText">아이디<span class="redStar">&nbsp;*</span></span>
            <span id="idChk"></span>
            <input id="inputDiv1" type="text" name="userAccount">
            <span class="inputText">이름<span class="redStar">&nbsp;*</span></span>
            <span id="nameChk"></span>
            <input id="inputDiv2" type="text" name="userDisplayName">
            <span class="inputText">이메일<span class="redStar">&nbsp;*</span></span>
            <span id="emailChk"></span>
            <input id="inputDiv3" type="email" name="userEmail">
            <span class="inputText">비밀번호<span class="redStar">&nbsp;*</span></span>
            <span id="pwChk"></span>
            <input id="inputDiv4" type="password" name="userPassword">
        </div>
        <button id="registerBtn"> 회원가입</button>
        <div class="goLogin">
            <a href="/login">로그인 화면으로 돌아가기</a>
        </div>
    </form>

</div>
<script>

    const checkResultList = [false, false, false, false, false];

    function setThumbnail(event) {
        let reader = new FileReader();

        reader.onload = function (event) {
            let img = document.createElement("img");
            img.setAttribute("src", event.target.result);

            const $uploadBox = document.querySelector("div#uploadBox");

            while ($uploadBox.firstChild) {
                $uploadBox.removeChild($uploadBox.firstChild);
            }
            $uploadBox.innerHTML = '';
            $uploadBox.appendChild(img);
            checkResultList[0] = true;
            console.log(checkResultList);
        };

        reader.readAsDataURL(event.target.files[0]);
    }

    const $box = document.getElementById('uploadBox');
    const $input = document.getElementById('profile-input');

    $box.onclick = e => {
        $input.click();
    };

    // 아이디 입력값 검증
    (function () {
        const accountPattern = /^[a-zA-Z0-9]{4,20}$/;

        const $idInput = document.getElementById('inputDiv1');

        const $idChk = document.getElementById('idChk');

        $idInput.onkeyup = e => {
            const idValue = $idInput.value;
            // console.log(idValue);

            if (idValue.trim() === '') {
                $idInput.style.borderColor = 'red';
                $idChk.innerHTML = '<b style="color: red;">[아이디는 필수값입니다!]</b>';
                checkResultList[1] = false;
            } else if (!accountPattern.test(idValue)) {
                $idInput.style.borderColor = 'red';
                $idChk.innerHTML = '<b style="color: red;">[아이디는 4~20글자의 영문, 숫자로 입력하세요.]</b>';
                checkResultList[1] = false;
            } else {
                fetch('/check?type=account&keyword=' + idValue)
                    .then(res => res.json())
                    .then(flag => {
                        if (flag) {
                            $idInput.style.borderColor = 'red';
                            $idChk.innerHTML = '<b style="color: red;">[아이디가 중복되었습니다.</b>';
                            checkResultList[1] = false;
                        } else {
                            $idInput.style.borderColor = 'skyblue';
                            $idChk.innerHTML = '';
                            checkResultList[1] = true;
                            console.log(checkResultList);

                        }
                    });
            }
        };
    })();

    (function () {
        // 이름 입력값 검증
        const namePattern = /^[가-힣]+$/;

        const $nameInput = document.getElementById('inputDiv2');

        const $nameChk = document.getElementById('nameChk');

        $nameInput.onkeyup = e => {
            const nameValue = $nameInput.value;

            if (nameValue.trim() === '') {
                $nameInput.style.borderColor = 'red';
                $nameChk.innerHTML = '<b style="color: red;">[이름을 입력해주세요]</b>';
                checkResultList[2] = false;
            } else if (!namePattern.test(nameValue)) {
                $nameInput.style.borderColor = 'red';
                $nameChk.innerHTML = '<b style="color: red;">[이름은 한글로 입력해주세요]</b>';
                checkResultList[2] = false;
            } else {
                $nameInput.style.borderColor = 'skyblue'
                $nameChk.innerHTML = '';
                checkResultList[2] = true;
                console.log(checkResultList);

            }
        };
    })();


    (function () {
        // 이메일 검증

        // 이메일 검사 정규표현식
        const emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

        const $emailInput = document.getElementById('inputDiv3');

        const $emailChk = document.getElementById('emailChk');

        $emailInput.onkeyup = e => {
            const emailValue = $emailInput.value;

            if (emailValue.trim() === '') {
                $emailInput.style.borderColor = 'red';
                $emailChk.innerHTML = '<b style="color: red;">[이메일은 필수값입니다.]</b>';
                checkResultList[3] = false;
            } else if (!emailPattern.test(emailValue)) {
                $emailInput.style.borderColor = 'red';
                $emailChk.innerHTML = '<b style="color: red;">[이메일 형식을 지켜주세요]</b>';
                checkResultList[3] = false;
            } else {
                fetch('/check?type=email&keyword=' + emailValue)
                    .then(res => res.json())
                    .then(flag => {
                        if (flag) {
                            $emailInput.style.borderColor = 'red';
                            $emailChk.innerHTML = '<b style="color: red;">[이메일이 중복되었습니다.]</b>';
                            checkResultList[3] = false;
                        } else {
                            $emailInput.style.borderColor = 'skyblue';
                            $emailChk.innerHTML = '';
                            checkResultList[3] = true;
                            console.log(checkResultList);
                        }
                    })
            }
        };
    })();

    (function () {
        // 비밀번호 입력값 검증

        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/

        const $pwInput = document.getElementById('inputDiv4');

        const $pwChk = document.getElementById('pwChk');

        $pwInput.onkeyup = e => {
            const pwValue = $pwInput.value;
            // console.log(pwValue);

            if (pwValue.trim() === '') {
                $pwInput.style.borderColor = 'red';
                $pwChk.innerHTML
                    = '<b style="color: red;">[비밀번호는 필수값입니다!]</b>';
                checkResultList[4] = false;
            } else if (!passwordPattern.test(pwValue)) {
                $pwInput.style.borderColor = 'red';
                $pwChk.innerHTML
                    = '<b style="color: red;">[특수문자 포함 8자 이상!]</b>';
                checkResultList[4] = false;
            } else {
                $pwInput.style.borderColor = 'skyblue';
                $pwChk.innerHTML = '';
                checkResultList[4] = true;
                console.log(checkResultList);
            }
        };
    })();

    document.getElementById('registerBtn').onclick = e => {
        const $form = document.querySelector('#registerForm');

        if (!checkResultList.includes(false)) {
            $form.submit();
        } else {
            alert('입력값을 확인해주세요');
            console.log(checkResultList);
        }
    };


    document.addEventListener("DOMContentLoaded", function () {
        const snowfallContainer = document.getElementById("snowfall");

        // 눈송이 뿌리기
        for (let i = 0; i < 50; i++) {
            const snowflake = document.createElement("div");
            snowflake.className = "snowflake";
            snowflake.style.left = (Math.random() * 100) + 'vw';
            snowflake.style.animationDuration = (Math.random() * 3 + 2) + 's';
            snowfallContainer.appendChild(snowflake);
        }
    });
</script>
</body>
</html>