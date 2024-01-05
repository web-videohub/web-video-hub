<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

<%--    <title>영상 화면</title>--%>
    <title>${video.videoTitle}</title>
  
    <link rel="stylesheet" href="/assets/css/detail.css">

<%--    icon    --%>
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">


</head>
<body class="back_bg">
<%-- css 모음 --%>
<jsp:include page="include/static-head.jsp"/>
<%-- 햄버거메뉴와 로고(홈버튼) 검색창, 영상업로드, 마이페이지 --%>
<jsp:include page="include/header.jsp"/>

    <%--    영상 컨테이너       --%>
    <div class="container">
        <div class="container_group clearfix"> <!-- clearfix 클래스 추가 -->
            <div class="box1">
                <video src="/local${v.videoUrl}"
                       controls width="auto" height="auto">
                </video>
                <div class="video_info">
                    <h1>${v.videoTitle}</h1>
                    <div class="video_user_bbox">
                        <a href="#"><img src="/local${sessionScope.login.userProfile}" alt="profile image" class="profileIMG"/></a>
                        <div class="video_info_user_bbox">
                            <a href="#">${v.videoUploadUser}</a>
                            <p>구독자 0명</p>
                        </div>
                        <div class="video_review_btn_o">
                            <button type="button" class="subscribe_B">구독</button>
                        </div>
                        <div class="video_review_btn_t">
                            <button type="button" class="like_B">${v.videoLike}<span class="lnr lnr-thumbs-up"></span>1.5만</button>
                            <button type="button" class="hate_B"><span class="lnr lnr-thumbs-down"></span></button>
                            <button type="button" class="share_B"><span class="lnr lnr-exit-up"></span></button>
                        </div>
                    </div>

                    <div class="video_info_bbox">
                        <p>업로드 일자: ${v.videoUploadDate}</p>
                        <p>조회수: $${v.videoViewCount}</p>
                        <p>영상 설명: ${v.videoContent}</p>
                    </div>
                </div>
                <div class="box3">
                    <form id="messageForm" name="messageForm">
                        <div class="form-group">
                            <div class="input-group clearfix">
                                <div class="bbox1">
                                    <img src="/local${sessionScope.login.userProfile}" alt="profile image" class="profileIMG"/>
                                    <p>${sessionScope.login.userDisplayName}</p>
                                </div>
                            </div>
                            <div class="bbox1_1">
                                <textarea id="message" placeholder="댓글 추가..." autocomplete="off" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="review_B" id="addReply">댓글</button>
                        </div>
                    </form>
                <div id="replyData">
                    <ul class="chat_list">
                        <%-- 이 부분은 li가 생성되는 부분이므로 어떠한 첨가도 금함.--%>
                    </ul>
                </div>
            </div>
        </div>
        <div class="box2">
            <ul class="video_list_Algorithm">
                <li>
                    <a href="#">
                        <div class="video_sumnail">
                            <img src="https://i.ytimg.com/vi/1xaPoq9ovyI/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLAW3tl-dautPg_SczhQwLbRix2YFw">
                        </div>
                        <div class="video_subinfo">
                            <p class="bbox_text">[테스트용 제목] 알고보니 지구멸망이 24시간 남았다?</p>
                            <p class="bbox_text_sub">Test_user</p>
                            <p class="bbox_text_sub">조회수 ? · 업로드 : ?</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- 드롭다운 메뉴, 댓글 테스트 자바스크립트 코드 -->
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const URL = '/api/v1/replies'; // 댓글과 관련된 기능을 수행하는 링크
    const videoId = urlParams.get('videoId'); //URL의 동영상 번호를 가져와서 저장
    const currentAccount = '${login.userAccount}'; // 로그인한 사람
    const auth = '${login.userAuth}'; //로그인한 사람 권한

    /*
        로그인한 유저 정보들 (나중에 이 주석 꼭 지울것!)
                login.userAccount : 유저 아이디
                login.userDisplayName : 유저닉네임
                login.userEmail : 유저이메일
                login.userAuth : 유저 권한
                login.userProfile : 유저 프사
     */

    function addComment() {
        const $addBtn = document.getElementById('addReply');

        $addBtn.onclick = e => {

        // 사용자가 입력한 댓글 텍스트 가져오기
        var commentText = document.getElementById('message').value;
        const writer = `${login.userDisplayName}`

        // 댓글 번호 (임시로 시간을 사용)
        // 드롭메뉴가 각 댓글에 적용되도록 댓글 구분용 id가 필요합니다.
        var commentId = new Date().getTime();

        // 사용자 입력값 검증
        if (commentText.trim() === '') {
            alert('댓글 내용은 필수값입니다!!');
            return;
        }

        // 서버로 보낼 데이터
        const payload = {
            text: commentText,
            account: `${login.userAccount}`,
            videoId: videoId
        }

        const requestInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };

        fetch(URL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    return res.json();
                } else {
                    return res.text();
                }
            })
            .then(responseData => {
                console.log(responseData);

                document.getElementById('message').value = '';
                fetchGetReplies(1);
            });
        }
    }

    // replies : reply_no, reply_text, reply_date, video_id, account
    // count : 댓글 총 갯수
    // pageInfo : 나중에 무한스크롤할 때 필요한 페이지 정보
    function renderReplies({replies, count, pageInfo}) {

        let tag = '';

        if(replies !== null && replies.length > 0) {
            for(let reply of replies) {

                const {rno, text, regDate, videoId, account, accountUserName, profile} = reply

                // 댓글 번호
                // 드롭메뉴가 각 댓글에 적용되도록 댓글 구분용 id가 필요합니다. (rno)
                var commentId = rno;

                // 새로운 댓글을 생성하고 <ul class="chat_list">에 추가
                tag += `
        <div class="chat_list_profile"> `;
                tag += (profile ? `<a href="#"><img src="/local\${profile}" height="45" width="45" alt="profile image"></a>`
                    : `<a href="#"><img src="/assets/img/profile.jpeg" height="45" width="45" alt="anonymous"></a>`);
                tag += ` </div>
        <div class="chat_list_profile_name">
            <a href="#"><p>\${accountUserName}</p></a>
        </div>
        <div class="chat_list_chat_text" id="chat-text-\${rno}">
            <p>\${text}</p>
        </div>
        <div class="chat_list_edit_area" id="edit-area-\${rno}" " style="display: none;">
            <textarea id="chat_message" autocomplete="off" class="form-control" data-id="\${rno}">\${text}</textarea>
            <button type="button" class="save_bb" onclick="replyEditComment(this)">저장</button>
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
                        <button type="button" onclick="toggleDropdown(this)" class="dropbox_bb" data-comment-id="\${rno}">...</button>
                        <div id="myDropdown-\${rno}" class="dropdown-content">
                            <a href="#" id="replyModBtn" onclick="toggleEditComment(this)">수정</a>
                            <a href="#" id="replyDelBtn" onclick="replyRemoveClickEvent(this)">삭제</a> `;
                }
                tag += `
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    `;

                document.querySelector('.chat_list').innerHTML = tag;
            }
        } else {
            // tag += "<div id='replyContent' class='card-body'>아직 댓글이 없습니다.</div>";
        }
    }

    // 댓글 삭제 처리 메서드
    function replyRemoveClickEvent(e) {
        event.preventDefault();

        var test = e.parentNode.parentNode;
        // console.log("test = " + test.innerHTML);
        var rno = test.querySelector('.dropbox_bb').getAttribute("data-comment-id");
        // console.log("rno = " + rno);


        if(!confirm('댓글을 삭제하시겠습니까?')) return;

        const requestInfo = {
            method: 'DELETE'
        };
        // 서버에 삭제 비동기 요청
        fetch(`\${URL}/\${rno}`, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    return res.json();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                    return;
                }
            })
            .then(responseResult => {
                renderReplies(responseResult);
            });
    }

    // 댓글 수정 메서드
    function toggleEditComment(e) {
        event.preventDefault();

        var parentNodeLine = e.parentNode.parentNode;
        // console.log("test = " + parentNodeLine.innerHTML);
        var rno = parentNodeLine.querySelector('.dropbox_bb').getAttribute("data-comment-id");
        // console.log("rno = " + rno);

        var chatText = document.getElementById('chat-text-' + rno);
        var editArea = document.getElementById('edit-area-' + rno);

        chatText.style.display = 'none';
        editArea.style.display = 'block';
    }

    function replyEditComment(e) {
        event.preventDefault();

        var parentNodeLine = e.parentNode;
        console.log("parentNodeList: " + parentNodeLine.innerHTML);
        var rno = parentNodeLine.querySelector('.form-control').getAttribute("data-id");
        var text = parentNodeLine.querySelector('.form-control').value;
        console.log("text: " + text);
        const payload = {
            text: text,
            account: `${login.userAccount}`,
            videoId: videoId,
            rno: +rno
        };
        console.log(payload);

        const requestInfo = {
            method: 'PUT',
            headers: {
                'content-type' : 'application/json'
            },
            body: JSON.stringify(payload)
        };

        fetch(URL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    // alert('댓글이 수정되었습니다.');
                    return res.json();
                } else {
                    alert('댓글이 수정에 실패했습니다.');
                    return;
                }
            })
            .then(result => {
                renderReplies(result);
            });
    }

    // 서버에 실시간으로 비동기통신을 해서 JSON을 받아오는 함수
    function fetchGetReplies(videoId, page = 1) {
        fetch(`\${URL}/\${videoId}`)
            .then(res => res.json())
            .then(replyList => {
                console.log(replyList);
                renderReplies(replyList);
            })
        ;
    }

    (() => {
        // 서버에서 댓글 불러오기
        fetchGetReplies(videoId);

        // 댓글 등록 이벤트 핸들러
        addComment();
    })();
</script>
<script src="./assets/js/testDropmenu.js"></script>
</body>
</html>
