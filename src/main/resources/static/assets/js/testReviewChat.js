function addComment() {
    // 사용자가 입력한 댓글 텍스트 가져오기
    var commentText = document.getElementById('message').value;

    // Test_name을 대신할 데이터 값도 필요합니다.

    // 댓글 번호 (임시로 시간을 사용)
    // 드롭메뉴가 각 댓글에 적용되도록 댓글 구분용 id가 필요합니다.
    var commentId = new Date().getTime();

    // 새로운 댓글을 생성하고 <ul class="chat_list">에 추가
    var newComment = document.createElement('li');
    newComment.innerHTML = `
        <div class="chat_list_profile">
            <a href="#"><img src="/assets/img/profile.jpeg"></a>
        </div>
        <div class="chat_list_profile_name">
            <a href="#"><p>Test_name</p></a>
        </div>
        <div class="chat_list_chat_text">
            <p>${commentText}</p>
        </div>
        <table>
            <tr>
                <td>
                    <div class="review_btns_one">
                        <button type="button" class="like_bb"><span class="lnr lnr-thumbs-up"></span></button>
                        <button type="button" class="hate_bb"><span class="lnr lnr-thumbs-down"></span></button>
                    </div>
                </td>
                <td>
                    <div class="review_btns_two">
                        <button type="button" onclick="toggleDropdown(this)" class="dropbox_bb" data-comment-id="${commentId}">...</button>
                        <div id="myDropdown-${commentId}" class="dropdown-content">
                            <a href="#">수정</a>
                            <a href="#">삭제</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    `;

    document.querySelector('.chat_list').appendChild(newComment);

    // 입력창 비우기
    document.getElementById('message').value = '';
}
