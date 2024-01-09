<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <%--    <title>영상 화면</title>--%>
    <title>${video.videoTitle}</title>

    <link rel="stylesheet" href="/assets/css/detail.css?after">

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
            <!-- video_info, video_info_bbox는 box1 안에 위치 해 있어야 한다.-->
            <div class="video_info">
                <h1>${v.videoTitle}</h1>
                <div class="video_user_bbox">

                    <div class="rightContainer">
                        <a href="/userPage?channelName=${v.uploadUser}"><img src="/local${v.uploadUserProfileImage}"
                                                                             alt="profile image" class="profileIMG profileIMGg"
                                                                             height="45" width="45"/></a>
                        <div class="video_info_user_bbox">
                            <a class="detailName" href="/userPage?channelName=${v.uploadUser}">${v.uploadUserDisplayName}</a>
                            <p>구독자 ${v.uploadUserSubscribe}명</p>
                        </div>
                        <c:if test="${sessionScope.login != null}">
                            <c:if test="${sessionScope.login.userAccount ne v.uploadUser}">
                                <button type="button" class="subscribe_B">구독</button>
                            </c:if>
                        </c:if>
                    </div>
                    <div class="video_review_btn_t">
                        <button type="button" class="like_B"><span class="lnr lnr-thumbs-up videoThumb"></span>
                        </button>
                        <button type="button" class="hate_B"><span class="lnr lnr-thumbs-down"></span></button>
                        <button type="button" class="share_B"><span class="lnr lnr-exit-up"></span></button>
                    </div>
                </div>
                <div class="video_info_bbox">
                    <p id="video_upload_day">업로드 일자: ${v.uploadDate}</p>
                    <p>조회수  ${v.videoViewCount}회</p>
                    <p>영상 설명: ${v.videoContent}</p>
                </div>
            </div>
            <div class="box3">
                <form id="messageForm" name="messageForm">
                    <div class="form-group">
                        <div class="input-group clearfix">
                            <div class="bbox1">
                                <c:if test="${sessionScope.login != null}">
                                    <img src="/local${sessionScope.login.userProfile}" alt="profile image"
                                         class="profileIMG profileIMGg" height="45" width="45"/>
                                </c:if>
                                <c:if test="${sessionScope.login == null}">
                                    <img src="/assets/img/profile.jpeg" alt="profile image"
                                         class="profileIMG profileIMGg" height="45" width="45"/>
                                </c:if>
                            </div>
                            <div class="bbox1_1">
                                <textarea id="message" placeholder="로그인 후 댓글작성이 가능합니다." autocomplete="off"
                                          class="form-control" disabled></textarea>
                            </div>
                        </div>
                        <div class="bbox2">
                            <button type="button" class="review_B" id="addReply">댓글</button>
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
                <!-- 추천 영상 리스트가 생성되는 부분이오니 어떠한 첨가도 금함.-->
            </ul>
        </div>
    </div>
</div>

<div id="loader" class="loader" style="text-align: center; visibility: hidden"></div>


<!-- 드롭다운 메뉴, 댓글 테스트, 무한 스크롤 자바스크립트 코드 -->
<script>
    const replyURL = '/api/v1/replies'; // 댓글과 관련된 기능을 수행하는 링크
    const emotionURL = '/api/v1/emotion'; // 이모션 링크
    const subscribeURL = '/api/v1/subscribe'; // 구독 여부 링크
    const $subBtn = document.querySelector('.subscribe_B'); // 구독 버튼
    const $likeBtn = document.querySelector('.like_B'); // 좋아요 버튼
    const $hateBtn = document.querySelector('.hate_B'); // 싫어요 버튼
    const urlParams = new URLSearchParams(window.location.search);
    const videoId = urlParams.get('videoId'); //URL의 동영상 번호를 가져와서 저장
    const currentAccount = '${sessionScope.login.userAccount}'; // 로그인한 사람
    const receiverAccount = '${v.uploadUser}'; // 동영상 업로더 어카운트명
    const auth = '${sessionScope.login.userAuth}'; //로그인한 사람 권한
    const loader = document.getElementById('loader');
    const replyListDiv = document.querySelector('.chat_list');
    const videoListDiv = document.querySelector('.video_list_Algorithm');
    const type = '${v.videoCategory}';
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

    function formatTimeAgo(timestamp) {
        const currentTime = new Date();
        const targetTime = new Date(timestamp);
        const timeDifference = currentTime - targetTime;

        const minutes = Math.floor(timeDifference / (1000 * 60));
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        const months = Math.floor(days / 30);
        const years = Math.floor(days / 365);

        if (years > 0) {
            return `\${years}년 전`;
        } else if (months > 0) {
            return `\${months}개월 전`;
        } else if (days > 0) {
            return `\${days}일 전`;
        } else if (hours > 0) {
            return `\${hours}시간 전`;
        } else if (minutes > 0) {
            return `\${minutes}분 전`;
        } else {
            return '방금 전';
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        observer.observe(loader);
        $likeBtn.addEventListener('click', EmotionClickEvent);
        $hateBtn.addEventListener('click', EmotionClickEvent);
    });

    (function (){
        const $likeSpan = document.querySelector('.videoThumb');
        $likeSpan.innerHTML = ${v.videoLike};
    })();

    const loadData = async () => {
        console.log('loadData function called');
        if (loading) return;

        loading = true;
        loader.style.visibility = "visible";

        setTimeout(async () => {
            try {
                const responseReply = await fetch(`/api/v1/replies/\${videoId}?pageNumber=\${pageNumber}&pageSize=12`);
                const responseVideo = await fetch(`/loadMoreVideosDetail?pageNumber=\${pageNumber}&pageSize=12&type=` + type);
                const newReply = await responseReply.json();
                const newVideo = await responseVideo.json();

                if (newReply.length > 0 || newVideo.length > 0) {
                    newReply.forEach(reply => {
                        const {rno, text, regDate, videoId, account, accountUserName, profile} = reply
                        console.log("reply : " + rno);

                        const newItem = document.createElement('div');
                        newItem.className = 'replyDiv';
                        newItem.setAttribute('reply-id', `\${rno}`);
                        if (auth === 'ADMIN' || currentAccount === account) {
                            newItem.innerHTML = `<div class="chat_list_profile">
                                    <a href="/userPage?channelName=\${account}"><img src="\${profile ? '/local' + profile : '/assets/img/profile.jpeg'}" height="45" width="45" alt="profile image"></a>
                                </div>
                                <div class="chat_list_profile_name">
                                    <a href="/userPage?channelName=\${account}"><p>\${accountUserName}</p></a>
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
                                            <div class="review_btns_two">
                                            <button type="button" onclick="toggleDropdown(this)" class="dropbox_bb" data-comment-id="\${rno}">...</button>
                                            <div id="myDropdown-\${rno}" class="dropdown-content">
                                                <a href="#" id="replyModBtn" onclick="toggleEditComment(this)">수정</a>
                                                <a href="#" id="replyDelBtn" onclick="replyRemoveClickEvent(this)">삭제</a>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>`;
                        } else {
                            newItem.innerHTML = `<div class="chat_list_profile">
                                    <a href="/userPage?channelName=\${account}"><img src="\${profile ? '/local' + profile : '/assets/img/profile.jpeg'}" height="45" width="45" alt="profile image"></a>
                                </div>
                                <div class="chat_list_profile_name">
                                    <a href="/userPage?channelName=\${account}"><p>\${accountUserName}</p></a>
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
                                    </tr>
                                </table>
                            </div>`;
                        }

                        replyListDiv.appendChild(newItem);

                    });
                    newVideo
                        .filter(video => video.videoId.toString() !== videoId) // 현재 보고있는 동영상은 추천동영상에서 예외처리
                        .forEach(video => {
                            if (video.videoId === videoId)
                                return;
                            const newItem = document.createElement('li');

                            newItem.innerHTML = `<a href="showmv?videoId=\${video.videoId}">
                        <div class="video_sumnail">
                            <img src="/local\${video.thumbnailUrl}" alt="thumbnail" style="float: left; width: 168px; height: 94px; border-radius: 10px"/>
                        </div>
                        <div class="video_subinfo">
                            <p class="bbox_text">\${video.videoTitle}</p>
                            <p class="bbox_text_sub">\${video.userDisplayName}</p>
                            <p class="bbox_text_sub">조회수 \${video.videoViewCount}회 · \${formatTimeAgo(video.uploadDate)}</p>
                        </div>
                    </a>`;

                            videoListDiv.appendChild(newItem);
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
                    nowPageNumber = pageNumber;
                    pageNumber = 1;
                    fetchGetReplies(responseData);
                    for (i = 2; i < nowPageNumber; i++) {
                        pageNumber = i;
                        observer.observe(loader);
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
                if (responseResult.length === 0)
                    document.querySelector('.chat_list').innerHTML = '';
                else {
                    loading = false;
                    nowPageNumber = pageNumber;
                    pageNumber = 1;
                    fetchGetReplies(responseResult);
                    for (i = 2; i <= nowPageNumber; i++) {
                        pageNumber = i;
                        observer.observe(loader);
                    }
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
                nowPageNumber = pageNumber;
                pageNumber = 1;
                fetchGetReplies(result);
                for (i = 2; i < nowPageNumber; i++) {
                    pageNumber = i;
                    observer.observe(loader);
                }
            });
    }

    // 서버에 실시간으로 비동기통신을 해서 댓글의 JSON을 받아오는 함수
    function fetchGetReplies() {
        fetch(`\${replyURL}/\${videoId}?pageNumber=\${pageNumber}&pageSize=12`)
            .then(res => res.json())
            .then(replyList => {
                console.log(replyList);
                if (replyList.length === 0) {

                }
                renderReplies(replyList);
            })
        ;
    }

    // 서버에서 실시간으로 비동기통신을 해서 구독여부 JSON을 받아오는 함수
    function fetchGetSub() {
        fetch(subscribeURL + `/${sessionScope.login.userAccount}/${v.uploadUser}`)
            .then(res => res.json())
            .then(flag => {
                if (flag) {
                    $subBtn.classList.add('chBtn2');
                    $subBtn.style.display = 'block';
                    $subBtn.style.width = '110px';
                    $subBtn.textContent = '구독취소';
                    $subBtn.style.background = '#EBEBEB';
                    $subBtn.style.color = 'black';
                    $subBtn.removeEventListener('click', makeSub);
                    $subBtn.addEventListener('click', e => {
                        fetchDeleteSub();
                    });
                } else {
                    if (${sessionScope.login.userAccount ne v.uploadUser}) {
                        $subBtn.classList.add('chBtn');
                        $subBtn.style.display = 'block';
                        $subBtn.style.width = '80px';
                        $subBtn.textContent = '구독';
                        $subBtn.style.background = 'black';
                        $subBtn.style.color = 'white';
                        $subBtn.removeEventListener('click', fetchDeleteSub);
                        $subBtn.addEventListener('click', e => {
                            makeSub();
                        })
                    }
                }

            })
        ;
    }

    function fetchDeleteSub() {
        const requestInfo = {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        };
        fetch(subscribeURL + `/${sessionScope.login.userAccount}/${v.uploadUser}`, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    $subBtn.classList.add('chBtn');
                    $subBtn.classList.remove('chBtn2');
                    $subBtn.style.width = '80px';
                    $subBtn.textContent = '구독';
                    $subBtn.style.background = 'black';
                    $subBtn.style.color = 'white';
                    $subBtn.removeEventListener('click', fetchDeleteSub);
                    $subBtn.addEventListener('click', e => {
                        makeSub();
                    })
                    return res.json();
                } else {
                    alert('구독취소 실패!');
                    return res.text();
                }
            })
    }


    function makeSub() {
        // 서버로 보낼 데이터
        const payload = {
            subSender: currentAccount,
            subReceiver: receiverAccount
        };

        // GET방식을 제외한 요청의 정보 만들기
        const requestInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };
        fetch(subscribeURL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    $subBtn.classList.add('chBtn2');
                    $subBtn.classList.remove('chBtn');
                    $subBtn.style.width = '110px';
                    $subBtn.textContent = '구독취소';
                    $subBtn.style.background = '#EBEBEB';
                    $subBtn.style.color = 'black';
                    $subBtn.removeEventListener('click', makeSub);
                    $subBtn.addEventListener('click', e => {
                        fetchDeleteSub();
                    });
                    return res.json();
                } else {
                    return res.text();
                }
            })

    }

    // 좋아요 / 싫어요 클릭 이벤트
    function EmotionClickEvent(e) {
        if(currentAccount === "") {
            alert("먼저 로그인해주세요!");
            return;
        }

        if(e.target.classList.contains('like_B') || e.target.classList.contains('lnr-thumbs-up')) {
            if(e.target.classList.contains('emotionOn') || e.target.parentNode.classList.contains('emotionOn')) {
                // DB에 좋아요가 눌러져 있는 상태인데 눌렀으므로 삭제한다.
                fetchDeleteEmotion();
            } else if($hateBtn.classList.contains('emotionOn')) {
                // DB에 싫어요가 눌러져 있는 상태인데 좋아요를 눌렀으므로 수정한다.
                fetchModifyEmotionLike(1, 0);
            } else {
                // DB에 정보가 없는 상태이니 DB에 정보 생성(좋아요 누름)
                makeEmotion(1, 0);
            }
        } else { // 싫어요를 누른 상태
            if(e.target.classList.contains('emotionOn') || e.target.parentNode.classList.contains('emotionOn')) {
                // DB에 싫어요가 눌러져 있는 상태인데 눌렀으므로 삭제한다.
                fetchDeleteEmotion();
            } else if($likeBtn.classList.contains('emotionOn')) {
                // DB에 좋아요가 눌러져 있는 상태인데 싫어요를 눌렀으므로 수정한다.
                fetchModifyEmotionLike(0, 1);
            } else {
                // DB에 정보가 없는 상태이니 DB에 정보 생성(싫어요 누름)
                makeEmotion(0, 1);
            }
        }
    }

    // 좋아요 / 싫어요 상태를 서버에서 가져오는 부분
    function fetchGetEmotion() {
        fetch(emotionURL + `/${v.videoId}?account=${sessionScope.login.userAccount}`)
            .then(res => res.json())
            .then(emotion => {

                    if (emotion === false) {
                        console.log("좋아요 / 싫어요 정보가 없습니다.");
                    } else {
                        if (emotion.videoLike === 1) {
                            // 좋아요 버튼 눌러져 있는 상태로 변경
                            $likeBtn.classList.add('emotionOn');
                            document.querySelector('.lnr-thumbs-up').style.color = 'rgb(235,235,235)';
                            $likeBtn.style.color = 'rgb(235,235,235)';
                            $likeBtn.style.background = 'black';

                        } else if (emotion.videoHate === 1) {
                            // 싫어요 버튼 눌러져 있는 상태로 변경
                            $hateBtn.classList.add('emotionOn');
                            document.querySelector('.lnr-thumbs-down').style.color = 'rgb(235,235,235)';
                            $hateBtn.style.color = 'rgb(235,235,235)';
                            $hateBtn.style.background = 'black';
                        }
                    }
                }
            );
    }

    // 좋아요 / 싫어요 만들기 요청 보내기
    function makeEmotion(videoLike, videoHate) {
        // 서버로 보낼 데이터
        const payload = {
            account: currentAccount,
            videoId : videoId,
            videoLike: videoLike,
            videoHate: videoHate
        };

        // GET방식을 제외한 요청의 정보 만들기
        const requestInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };
        fetch(emotionURL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    // 좋아요 / 싫어요 상태 변경(누른걸로)
                    if(videoLike === 1) {
                        $likeBtn.classList.add('emotionOn')
                        document.querySelector('.lnr-thumbs-up').style.color = 'rgb(235,235,235)';
                        $likeBtn.style.color = 'rgb(235,235,235)';
                        $likeBtn.style.background = 'black';
                        $hateBtn.classList.remove('emotionOn')
                        document.querySelector('.lnr-thumbs-down').style.color = 'black';
                        $hateBtn.style.color = 'black';
                        $hateBtn.style.background = 'rgb(235,235,235)';



                    } else {
                        $likeBtn.classList.remove('emotionOn')
                        document.querySelector('.lnr-thumbs-up').style.color = 'black';
                        $likeBtn.style.color = 'black';
                        $likeBtn.style.background = 'rgb(235,235,235)';
                        $hateBtn.classList.add('emotionOn')
                        document.querySelector('.lnr-thumbs-down').style.color = 'rgb(235,235,235)';
                        $hateBtn.style.color = 'rgb(235,235,235)';
                        $hateBtn.style.background = 'black';
                    }
                    return res.json();
                } else {
                    return res.text();
                }
            })

    }

    // 좋아요/ 싫어요 삭제
    async function fetchDeleteEmotion() {
        const requestInfo = {
            method: 'DELETE'
        };
        const response = await fetch(emotionURL + `/${v.videoId}/${sessionScope.login.userAccount}/${v.videoLike}`, requestInfo)
        const emotion = await response.json();
        console.log(emotion);

        if(emotion.userAccount != null) {
            $likeBtn.classList.remove('emotionOn');
            $likeBtn.style.color = 'black';
            $likeBtn.style.background = 'rgb(235,235,235)';
            $hateBtn.classList.remove('emotionOn');
            $hateBtn.style.color = 'black';
            $hateBtn.style.background = 'rgb(235,235,235)';
            document.querySelector('.lnr-thumbs-up').style.color = 'black';
            document.querySelector('.lnr-thumbs-down').style.color = 'black';

            $likeBtn.firstChild.textContent = emotion.likeCount - 1;

        } else {
            alert('좋아요/ 싫어요 상태 변경(삭제) 실패!');
            console.log("실패함 븅신ㅋ");
        }
        <%--fetch(emotionURL + `/${v.videoId}/${sessionScope.login.userAccount}/${v.videoLike}`, requestInfo)--%>
        <%--    .then(res => {--%>
        <%--        if (res.status === 200) {--%>
        <%--            console.log(${likeCount});--%>
        <%--            // 좋아요 / 싫어요 상태 초기화--%>
        //             $likeBtn.classList.remove('emotionOn');
        //             $likeBtn.style.color = 'black';
        //             $likeBtn.style.background = 'rgb(235,235,235)';
        //             $hateBtn.classList.remove('emotionOn');
        //             $hateBtn.style.color = 'black';
        //             $hateBtn.style.background = 'rgb(235,235,235)';
        //             document.querySelector('.lnr-thumbs-up').style.color = 'black';
        //             document.querySelector('.lnr-thumbs-down').style.color = 'black';
        <%--            return res.json();--%>
        <%--        } else {--%>
        //             alert('좋아요/ 싫어요 상태 변경(삭제) 실패!');
        <%--            return res.text();--%>
        <%--        }--%>
        <%--    })--%>
    }

    // 좋아요 / 싫어요 수정
    function fetchModifyEmotionLike(videoLike, videoHate) {
        const payload = {
            account: currentAccount,
            videoId : videoId,
            videoLike: videoLike,
            videoHate: videoHate
        };
        console.log(payload);

        const requestInfo = {
            method: 'PUT',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        };



        fetch(emotionURL, requestInfo)
            .then(res => {
                if (res.status === 200) {
                    // console.log(likeCoun);
                    // 상태 변경 처리
                    if(videoLike === 1) {
                        $likeBtn.classList.add('emotionOn')
                        $likeBtn.style.color = 'rgb(235,235,235)';
                        $likeBtn.style.background = 'black';
                        document.querySelector('.lnr-thumbs-up').style.color = 'rgb(235,235,235)';
                        $hateBtn.classList.remove('emotionOn')
                        document.querySelector('.lnr-thumbs-down').style.color = 'black';
                        $hateBtn.style.color = 'black';
                        $hateBtn.style.background = 'rgb(235,235,235)';


                    } else {
                        $likeBtn.classList.remove('emotionOn')
                        $likeBtn.style.color = 'black';
                        $likeBtn.style.background = 'rgb(235,235,235)';
                        document.querySelector('.lnr-thumbs-up').style.color = 'black';
                        $hateBtn.classList.add('emotionOn')
                        document.querySelector('.lnr-thumbs-down').style.color = 'rgb(235,235,235)';
                        $hateBtn.style.color = 'rgb(235,235,235)';
                        $hateBtn.style.background = 'black';
                    }
                    return res.json();
                } else {
                    alert('상태 수정 실패');
                    return;
                }
            })
            .then(result => {
                renderReplies(result);
            });
    }

    <%-- 로그인 여부의 따른 댓글 textarea이벤트부여 --%>

    function checkLogin() {
        const $replyTextarea = document.getElementById('message');

        if (currentAccount !== "") {
            $replyTextarea.disabled = false;
            $replyTextarea.placeholder = "댓글 추가...";
        }

    }


    (() => {
        // 로그인 여부에 따라 댓글창 활성화하기
        checkLogin();

        // 서버에서 댓글 불러오기
        // fetchGetReplies(videoId);

        // 구독여부 확인하기
        if (currentAccount)
            fetchGetSub();

        // 좋아요 / 싫어요 상태 불러오기
        if (currentAccount)
            fetchGetEmotion();

        // 댓글 등록 이벤트 핸들러
        addComment();
    })();


</script>

<!-- 드롭다운 메뉴, 댓글 테스트 자바스크립트 코드 -->
<script src="./assets/js/testDropmenu.js"></script>
</body>
</html>