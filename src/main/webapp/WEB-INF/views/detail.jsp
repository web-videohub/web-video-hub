<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영상 화면</title>
    <link rel="stylesheet" href="/assets/css/detail.css?after">

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
            <video src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                   controls width="auto" height="auto">
            </video>
            <div class="video_info">
                <h1>제목 타이틀 : ${v.videoTitle}</h1>
                <div class="video_user_bbox">
                    <a href="#"><img src="/assets/img/profile.jpeg"></a>
                    <div class="video_info_user_bbox">
                        <a href="#">${v.uploadUserDisplayName}Test</a>
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
                    <p>업로드 일자: ${v.uploadDate}</p>
                    <p>조회수: ${v.videoViewCount}</p>
                    <p>영상 설명: ${v.videoContent}</p>
                </div>
            </div>
            <div class="box3">
                <form id="messageForm" name="messageForm">
                    <div class="form-group">
                        <div class="input-group clearfix">
                            <div class="bbox1">
                                <img src="/assets/img/profile.jpeg">
                                <p>Test_user</p>
                            </div>
                            <div class="bbox1_1">
                                <textarea id="message" placeholder="댓글 추가..." autocomplete="off" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="review_B" onclick="addComment()">댓글</button>
                        </div>
                    </div>
                </form>
                <ul class="chat_list">
                    <%-- 이 부분은 li가 생성되는 부분이므로 어떠한 첨가도 금함.--%>
                </ul>
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
</script>
<script src="./assets/js/testDropmenu.js"></script>
</body>
</html>