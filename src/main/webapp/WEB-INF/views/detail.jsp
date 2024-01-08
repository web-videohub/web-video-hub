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

    <style>
        .loader {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>

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
            <div class="vvvv">
                <video src="/local${v.videoUrl}"
                       controls width="auto" height="auto">
                </video>
            </div>
            <div class="video_info">
                <h1>${v.videoTitle}</h1>
                <div class="video_user_bbox">
                    <div class="leftReview">
                        <a href="#"><img src="/local${v.userProfileImage}" alt="profile image"/></a>
                        <div class="video_info_user_bbox">
                            <a href="/userPage?channelName=${v.videoUploadUser}">${v.videoUploadUser}</a>
                            <p>구독자 0명</p>
                        </div>
                        <div class="video_review_btn_o">
                            <button type="button" class="subscribe_B">구독</button>
                        </div>
                    </div>
                    <div class="rightReview">
                        <div class="video_review_btn_t">
                            <button type="button" class="like_B"><span class="lnr lnr-thumbs-up">${v.videoLike}</span>
                            </button>
                            <button type="button" class="hate_B"><span class="lnr lnr-thumbs-down"></span></button>
                            <button type="button" class="share_B"><span class="lnr lnr-exit-up"></span></button>
                        </div>
                    </div>
                </div>
                <div class="box3">
                    <div class="video_info_bbox">
                        <p>업로드 일자: ${v.videoUploadDate}</p>
                        <p>조회수: ${v.videoViewCount}</p>
                        <p>영상 설명: ${v.videoContent}</p>
                    </div>
                </div>
                <div class="box3">
                    <form id="messageForm" name="messageForm">
                        <div class="form-group">
                            <div class="input-group clearfix">
                                <div class="bbox1">
                                    <c:if test="${sessionScope.login != null}">
                                        <img src="/local${sessionScope.login.userProfile}" alt="profile image"/>
                                        <p>${sessionScope.login.userDisplayName}</p>
                                    </c:if>
                                    <c:if test="${sessionScope.login == null}">
                                        <img src="/assets/img/profile.jpeg" alt="비로그인">
                                    </c:if>
                                </div>
                                <div class="bbox1_1">
                                <textarea id="message" placeholder="댓글 추가..." autocomplete="off"
                                          class="form-control"></textarea>
                                </div>
                                <div class="bbox2">
                                    <button type="button" class="review_B" id="addReply">댓글</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div id="replyData">
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
</div>

<div id="loader" class="loader" style="text-align: center; visibility: hidden"></div>


<!-- 드롭다운 메뉴, 댓글 테스트, 무한 스크롤 자바스크립트 코드 -->
<script>
    const replyURL = '/api/v1/replies'; // 댓글과 관련된 기능을 수행하는 링크
    const emotionURL = '/api/v1/emotion'; // 이모션 링크
    const subscribeURL = '/api/v1/subscribe'; // 구독 여부 링크
    const urlParams = new URLSearchParams(window.location.search);
    const videoId = urlParams.get('videoId'); //URL의 동영상 번호를 가져와서 저장
    const currentAccount = '${login.userAccount}'; // 로그인한 사람
    const auth = '${login.userAuth}'; //로그인한 사람 권한
    const loader = document.getElementById('loader');
    const replyListDiv = document.querySelector('.chat_list');
    let loading = false;
    let pageNumber = 1;
    let nowPageNumber = pageNumber;
    let selectedValue = null;

    const options = {
        root: null,
        rootMargin: '0px',
        threshold: 0.5,
    };

    const handleIntersection = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                console.log("Intersection observed!");
                loadData(selectedValue);
            }
        });
    };

    const observer = new IntersectionObserver(handleIntersection, options);

    document.addEventListener("DOMContentLoaded", function () {
        observer.observe(loader);
    });

    const loadData = async () => {
        console.log('loadData function called');
        if (loading) return;

        loading = true;
        loader.style.visibility = "visible";

        setTimeout(async () => {
            try {
                const response = await fetch(`/api/v1/replies/\${videoId}?pageNumber=\${pageNumber}&pageSize=12`);
                const newReply = await response.json();

                if (newReply.length > 0) {
                    newReply.forEach(reply => {
                        const {rno, text, regDate, videoId, account, accountUserName, profile} = reply
                        console.log("reply : " + rno);

                        const newItem = document.createElement('div');
                        newItem.className = 'replyDiv';
                        newItem.setAttribute('reply-id', `\${rno}`);
                        newItem.innerHTML = `<div class="chat_list_profile">
                                    <a href="#"><img src="${profile ? '/local' + profile : '/assets/img/profile.jpeg'}" height="45" width="45" alt="profile image"></a>
                                </div>
                                <div class="chat_list_profile_name">
                                    <a href="#"><p>\${accountUserName}</p></a>
                                </div>
                                <div class="chat_list_chat_text" id="chat-text-\${rno}">
                                    <p>\${text}</p>
                                </div>
                                <div class="chat_list_edit_area" id="edit-area-\${rno}" style="display: none;">
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
                                            <div class="review_btns_two">`;

                        if (auth === 'ADMIN' || currentAccount === account) {
                            newItem.innerHTML += `<button type="button" onclick="toggleDropdown(this)" class="dropbox_bb" data-comment-id="\${rno}">...</button>
                                      <div id="myDropdown-\${rno}" class="dropdown-content">
                                          <a href="#" id="replyModBtn" onclick="toggleEditComment(this)">수정</a>
                                          <a href="#" id="replyDelBtn" onclick="replyRemoveClickEvent(this)">삭제</a>`;
                        }

                        newItem.innerHTML += `    </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>`;

                        replyListDiv.appendChild(newItem);
                    });

                    pageNumber++;


                } else {
                    observer.unobserve(loader);
                    console.log('Observer unobserved');
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            } finally {
                loading = false;
                loader.style.visibility = "hidden";
            }
        }, 1000);
    };

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

            // 댓글 번호 (임시로 시간을 사용)
            // 드롭메뉴가 각 댓글에 적용되도록 댓글 구분용 id가 필요합니다.
            // var commentId = new Date().getTime();

            // 사용자 입력값 검증
            if (commentText.trim() === '') {
                alert('댓글 내용은 필수값입니다!!');
                return;
            }

            // 서버로 보낼 데이터
            const payload = {
                text: commentText,
                account: currentAccount,
                videoId: videoId
            }

            const requestInfo = {
                method: 'POST',
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify(payload)
            };

            fetch(replyURL, requestInfo)
                .then(res => {
                    if (res.status === 200) {
                        return res.json();
                    } else {
                        return res.text();
                    }
                })
                .then(responseData => {
                    console.log("responseData :" + responseData);

                    document.getElementById('message').value = '';
                    loading = false;
                    loader.style.visibility = "hidden";
                    nowPageNumber = pageNumber;
                    pageNumber = 1;
                    fetchGetReplies(responseData);
                    for (i = 2; i < nowPageNumber; i++) {
                        pageNumber = i;
                        loadData();
                    }
                });
        }
    }

    function renderReplies(replyList) {

        let tag = '';

        if (replyList !== null && replyList.length > 0) {
            for (let reply of replyList) {

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
                if (auth === 'ADMIN' || currentAccount === account) {
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


        if (!confirm('댓글을 삭제하시겠습니까?')) return;

        const requestInfo = {
            method: 'DELETE'
        };
        // 서버에 삭제 비동기 요청
        fetch(`\${replyURL}/\${rno}`, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    return res.json();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                    return;
                }
            })
            .then(responseResult => {
                loading = false;
                loader.style.visibility = "hidden";
                nowPageNumber = pageNumber;
                pageNumber = 1;
                fetchGetReplies(responseResult);
                for (i = 2; i <= nowPageNumber; i++) {
                    pageNumber = i;
                    loadData();
                }
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
            account: currentAccount,
            videoId: videoId,
            rno: +rno
        };
        console.log(payload);

        const requestInfo = {
            method: 'PUT',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };

        fetch(replyURL, requestInfo)
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
                loading = false;
                loader.style.visibility = "hidden";
                nowPageNumber = pageNumber;
                pageNumber = 1;
                fetchGetReplies(result);
                for (i = 2; i < nowPageNumber; i++) {
                    pageNumber = i;
                    loadData();
                }
            });
    }

    // 서버에 실시간으로 비동기통신을 해서 댓글의 JSON을 받아오는 함수
    function fetchGetReplies() {
        fetch(`\${replyURL}/\${videoId}?pageNumber=\${pageNumber}&pageSize=12`)
            .then(res => res.json())
            .then(replyList => {
                console.log(replyList);
                renderReplies(replyList);
            })
        ;
    }

    // 서버에서 실시간으로 비동기통신을 해서 구독여부 JSON을 받아오는 함수
    function fetchGetSubscribe() {
        fetch(`\${SubscribeURL}/\${login.userAccount}/\${v.videoUploadUser}`)
            .then(res => res.json())
            .then(replyData => {
                console.log("가져온 구독정보 : " + replyData);
                renderSubscribes(replyData);
            })
    }

    function renderSubscribes(bool) {
        if (bool === true) {
            console.log("구독중");
        } else if (bool === true) {
            console.log("구독안되있슴");
        } else {
            console.log("뭐가온거임? 리턴된 값 : ", bool);
        }
    }

    (() => {
        // 서버에서 댓글 불러오기
        // fetchGetReplies(videoId);

        // 댓글 등록 이벤트 핸들러
        addComment();
    })();
</script>

<%-- 로그인 여부의 따른 댓글 textarea이벤트부여 --%>
<script>
    const $replyTextarea = document.getElementById('message');

    if(`${sessionScope.login == null}`) {
        $replyTextarea.disabled = true;
        $replyTextarea.placeholder = "로그인 후 댓글작성이 가능합니다.";
    }

</script>
<script src="./assets/js/testDropmenu.js"></script>
</body>
</html>