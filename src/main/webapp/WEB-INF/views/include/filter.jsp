<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
    <style>
        /* 기존의 라디오 버튼 숨기기 */
        .filterDiv input[type="radio"] {
            display: none;
        }

        .filterDiv label {
            display: inline-block;
            padding: 8px 16px;
            background-color: #ddd;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 8px;
            cursor: pointer;
        }

        .filterDiv input[type="radio"]:checked + label {
            transition: 0.2s ease-out;
            background-color: #F2B950;
            color: #fff;
        }
        .filterDiv input[type="radio"]:not(:checked) + label {
            transition: 0.2s ease-out;
        }
    </style>

    <form id="radioForm" class="filterDiv">
        <label>
            <input type="radio" name="filter" value="all" id = "all" onclick="handleRadioClick(this)"> 전체
        </label>
        <label>
            <input type="radio" name="filter" value="game" onclick="handleRadioClick(this)"> 게임
        </label>
        <label>
            <input type="radio" name="filter" value="life" onclick="handleRadioClick(this)"> 일상
        </label>
        <label>
            <input type="radio" name="filter" value="animal" onclick="handleRadioClick(this)"> 동물
        </label>
        <label>
            <input type="radio" name="filter" value="nature" onclick="handleRadioClick(this)"> 자연
        </label>
        <label>
            <input type="radio" name="filter" value="dance" onclick="handleRadioClick(this)"> 댄스
        </label>
        <label>
            <input type="radio" name="filter" value="health" onclick="handleRadioClick(this)"> 헬스
        </label>
        <label>
            <input type="radio" name="filter" value="music" onclick="handleRadioClick(this)"> 음악
        </label>
    </form>
</header>
<body>
<script>
    let disableRadioButtons = false;

    function toggleRadioButtons() {
        const radioButtons = document.querySelectorAll('input[type=radio][name=filter]');
        radioButtons.forEach(radio => {
            radio.disabled = disableRadioButtons;
        });
    }

    function handleRadioClick(radio) {
        disableRadioButtons = true;
        toggleRadioButtons();

        setTimeout(() => {
            disableRadioButtons = false;
            toggleRadioButtons();
        }, 1000);
    }
</script>
</body>