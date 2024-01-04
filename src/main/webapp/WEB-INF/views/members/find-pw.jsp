<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/find-pw.css">
    <title>비밀번호 찾기</title>
</head>
<body>
<div id="snowfall"></div>

<div class="findPasswordDiv">
    <img id="santa" src="/assets/img/rabbit.png" alt="">
    <div class="findPasswordForm">
        <div class="findPasswordTitle">
            <h2>비밀번호 찾기</h2>
        </div>
        <div class="inputDiv">
            <span class="inputText">당신의 아이디<span class="redStar">&nbsp;*</span></span>
            <input id="inputDiv1" type="text" name="account">
            <span class="inputText">당신의 이메일<span class="redStar">&nbsp;*</span></span>
            <input id="inputDiv2" type="email" name="email">
        </div>
        <div class="modifyPw" style="display: none">
            <span class="inputText">변경할 비밀번호</span>
            <input id="inputDiv3" type="password" placeholder="새로운 비밀번호를 입력해주세요.">
        </div>
        <input id="findPasswordBtn" type="button" value="아이디, 이메일 검증">
        <input id="modifyBtn" type="button" value="비밀번호 변경" style="display: none">
        <div class="goLogin">
            <a href="/login">로그인 화면으로 돌아가기</a>
        </div>
    </>

</div>
<script>

    const checkResultList = [false, false];
    const $modifyPw = document.querySelector(".modifyPw");
    const $findBtn = document.getElementById('findPasswordBtn');
    const $modifyBtn = document.getElementById('modifyBtn');

    let idValue = "";

    (function () {
        const $idInput = document.getElementById('inputDiv1');
        const $emailInput = document.getElementById('inputDiv2');


        $idInput.onkeyup = e => {
             idValue = $idInput.value;

            console.log(idValue);

            fetch('/check?type=account&keyword=' + idValue)
                .then(res => res.json())
                .then(flag => {
                    checkResultList[0] = flag;
                    console.log(checkResultList);
                });
        };

        $emailInput.onkeyup = e => {
            const emailValue = $emailInput.value;

            console.log(idValue);
            fetch('/modify?account=' + idValue + '&email=' + emailValue)
                .then(res => res.json())
                .then(flag => {
                    checkResultList[1] = flag;
                    console.log(checkResultList);
                });
        };

        $findBtn.onclick = e => {
            if(!checkResultList.includes(false)) {
                $findBtn.style.display = 'none';
                $modifyBtn.style.display = 'block';
                $idInput.setAttribute("readonly", "true");
                $idInput.style.borderColor = 'green';
                $emailInput.setAttribute("readonly", "true");
                $emailInput.style.borderColor = 'green';
                $modifyPw.style.display = "flex";
            }

        }
        $modifyBtn.onclick = e => {
            console.log("ㅋㅋ 여까지 왔누");
        }

    })();





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