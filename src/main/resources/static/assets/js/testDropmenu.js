// 드롭다운 토글 함수
function toggleDropdown() {
    var dropdown = document.getElementById("myDropdown");
    dropdown.classList.toggle("show");
}

// 윈도우 클릭 이벤트 리스너
window.onclick = function(event) {
    var dropdown = document.getElementById("myDropdown");
    if (event.target.matches('.dropdown-btn')) {
        // 드롭다운 버튼을 클릭한 경우, 아무것도 하지 않음
    } else if (!event.target.matches('.dropdown-content a')) {
        // 드롭다운 내용 외의 영역을 클릭한 경우, 드롭다운 닫기
        dropdown.classList.remove('.show');
    }
}