function toggleDropdown(button) {
    var commentId = button.getAttribute("data-comment-id");
    var dropdown = document.getElementById("myDropdown-" + commentId);
    dropdown.classList.toggle("show");
}

// 윈도우 클릭 이벤트 리스너
window.onclick = function (event) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var i = 0; i < dropdowns.length; i++) {
        var dropdown = dropdowns[i];
        if (event.target.matches('.dropdown-btn')) {
            // 드롭다운 버튼을 클릭한 경우, 아무것도 하지 않음
        } else if (!event.target.matches('.dropdown-content a')) {
            // 드롭다운 닫기
            dropdown.classList.remove('.show');
        }
    }
}