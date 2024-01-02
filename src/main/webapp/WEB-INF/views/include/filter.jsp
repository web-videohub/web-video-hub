<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
    <style>
        /* 기존의 라디오 버튼 숨기기 */
        .filterDiv input[type="radio"] {
            display: none;
        }

        /* 커스텀 스타일 적용 */
        .filterDiv label {
            display: inline-block;
            padding: 8px 16px;
            background-color: #ddd;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 8px;
            cursor: pointer;
        }

        /* 체크된 라디오 버튼의 스타일 변경 */
        .filterDiv input[type="radio"]:checked + label {
            background-color: #4CAF50;
            color: #fff;
        }
    </style>

    <div class="filterDiv">
        <input type="radio" id="game" name="filter" checked><label for="game">게임</label>
        <input type="radio" id="life" name="filter"><label for="life">일상</label>
        <input type="radio" id="animal" name="filter"><label for="animal">동물</label>
        <input type="radio" id="nature" name="filter"><label for="nature">자연</label>
        <input type="radio" id="dance" name="filter"><label for="dance">댄스</label>
    </div>
</header>
