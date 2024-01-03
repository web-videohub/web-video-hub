<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/setting.css">
    <title>메인화면</title>
</head>
<body>
    <%-- css 모음 --%>
    <jsp:include page="include/static-head.jsp"/>
    <%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
    <jsp:include page="include/header.jsp"/>


    <div class="settingDiv">
        <%-- 설정 상태바 --%>
        <div class="LeftDiv">
            왼쪽 상태바 입니다.
        </div>
        <div class="mainContainer">

        </div>
    </div>
</body>
</html>