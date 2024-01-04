const URL = '/api/v1/replies'; // 댓글과 관련된 기능을 수행하는 링크
const videoId = ''; //비디오의 번호를 가져와서 저장하는 곳
const currentAccount = '${login.userAccount}'; // 로그인한 사람
const auth = '${login.userAuth}'; //로그인한 사람 권한

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

// replies : reply_no, reply_text, reply_date, video_id, account
// count : 댓글 총 갯수
// pageInfo : 나중에 무한스크롤할 때 필요한 페이지 정보
function renderReplies({replies, count, pageInfo}) {

    let tag = '';

    if(replies !== null && replies.length > 0) {
        for(let reply of replies) {

            const {rno, text, regDate, videoId, account, accountUserName, profile} = reply

            tag += `

            `

            // 댓글 번호
            // 드롭메뉴가 각 댓글에 적용되도록 댓글 구분용 id가 필요합니다.
            var commentId = rno;

            // 새로운 댓글을 생성하고 <ul class="chat_list">에 추가
            var newComment = document.createElement('li');
            tag += `
        <div class="chat_list_profile"> `;
            tag += (profile ? `<a href="#"><img src="/local\${profile}" height="45" width="45" alt="profile image"></a>`
                : `<a href="#"><img src="/assets/img/profile.jpeg" height="45" width="45" alt="anonymous"></a>`);
            tag += ` </div>
        <div class="chat_list_profile_name">
            <a href="#"><p>\${accountUserName}</p></a>
        </div>
        <div class="chat_list_chat_text">
            <p>\${text}</p>
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
                    <div class="review_btns_two"> `;
            if(auth === 'ADMIN' || currentAccount === account) {
                tag += `
                        <button type="button" onclick="toggleDropdown(this)" class="dropbox_bb" data-comment-id="${commentId}">...</button>
                        <div id="myDropdown-${commentId}" class="dropdown-content">
                            <a href="#">수정</a>
                            <a href="#">삭제</a> `;
            }
            tag += `
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    `;

            document.querySelector('.chat_list').innerHTML = tag;

            // 입력창 비우기
            document.getElementById('message').value = '';
        }
    } else {
        // tag += "<div id='replyContent' class='card-body'>아직 댓글이 없습니다.</div>";
    }

}
function fetchGetReplies(page = 1) {
    fetch(`\${URL}/${v.videoId}`)
        .then(res => res.json())
        .then(replyList => {
            console.log(replyList);
            renderReplies(replyList);
        })
    ;
}

(() => {
    fetchGetReplies();
})();