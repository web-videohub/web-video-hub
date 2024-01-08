// 댓글 텍스트 값을 수정 textarea에 가져오는 함수
function toggleEditComment(commentId) {
    var chatText = document.getElementById('chat-text-' + commentId);
    var editArea = document.getElementById('edit-area-' + commentId);

    chatText.style.display = 'none';
    editArea.style.display = 'block';
}