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
            background-color: #F2B950;
            color: #fff;
        }
    </style>

    <div class="filterDiv">
        <input type="radio" id="game" name="game"><label for="game">게임</label>
        <input type="radio" id="life" name="life"><label for="life">일상</label>
        <input type="radio" id="animal" name="animal"><label for="animal">동물</label>
        <input type="radio" id="nature" name="nature"><label for="nature">자연</label>
        <input type="radio" id="dance" name="dance"><label for="dance">댄스</label>
        <input type="radio" id="health" name="health"><label for="health">헬스</label>
        <input type="radio" id="music" name="music"><label for="music">노래</label>
    </div>
</header>
<body>
<script>
    let $filter = document.querySelector('.filterDiv');

    $filter.addEventListener('click', e => {
        const clickedLabel = e.target.tagName === 'LABEL' ? e.target : null;
        if (clickedLabel) {
            const radioId = clickedLabel.getAttribute('for');
            const radio = document.getElementById(radioId);
            if (radio) {
                Array.from($filter.querySelectorAll('input[type="radio"]')).forEach(radio => {
                    radio.checked = false;
                });
                radio.checked = true;
                console.log(radio)
                console.log(radio.checked);
            }
        }
    });
</script>
</body>
