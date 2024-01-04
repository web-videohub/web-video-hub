<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
    <%
        String userName = "";

        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if(c.getName().equals("login")) {
                userName = c.getValue();
            }
        }
    %>
    <div class="headerDiv">
        <div class="headerContainer">
            <div class="menu">
                <button id="headerBtn" class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                    <span class="lnr lnr-menu"></span>
                </button>
                <button id="headerBtn2" type="button"  class="navbar-toggler">
                    <span class="lnr lnr-menu"></span>
                </button>
                <div class="offcanvas offcanvas-start" tabindex="1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                    <div class="offcanvas-header">
                        <button class="navbar-toggler2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                            <span class="lnr lnr-menu"></span>
                        </button>
                        <a href="/" class="logoA">
                            <img class="mainLogo" src="/assets/img/hubTitle.png" alt="">
                        </a>
                    </div>
                    <div class="offcanvas-body">
                        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/">
                                <span class="lnr lnr-home"></span>
                                    홈
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/subs">
                                <span class="lnr lnr-book"></span>
                                    구독
                                </a>
                            </li>
                            <hr>
                            <li class="nav-item">
                                <a class="nav-link" href="/studio">나 ></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/studio">
                                <span class="lnr lnr-user"></span>
                                    내 채널
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/setting">
                                <span class="lnr lnr-cog"></span>
                                    설정
                                </a>
                            </li>

                        </ul>
                    </div>
                </div>



                <a href="/" class="logoA">
                    <img class="mainLogo" src="/assets/img/hubTitle.png" alt="">
                </a>
            </div>
            <form class="searchForm" action="" method="">
                <input class="searchInput" type="search" placeholder="검색">
                <button class="searchBtn" type="submit"><span class="lnr lnr-magnifier"></span></button>
            </form>

            <c:if test="${login == null}">
                <div class="btns">
                    <a class="login" href="/login">
                        <span class="lnr lnr-user"></span>
                        로그인
                    </a>
                </div>
            </c:if>
            <c:if test="${login != null}">
                <div class="dropdown">
                    <button class="btn btn-secondary" type="button" id="dropdownMenuButton1"
                            data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="/local${sessionScope.login.userProfile}" alt="profile image" class="profileIMG"/>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><p class="dropdown-item drop-p">${sessionScope.login.userDisplayName}</p></li>
                        <li><p class="dropdown-item drop-p">${sessionScope.login.userAccount}</p></li>
                        <hr>
                        <li><a class="dropdown-item" href="/studio">내 채널 보기</a></li>
                        <li><a class="dropdown-item" href="/setting">설정</a></li>
                        <li><a class="dropdown-item" href="#">로그아웃</a></li>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>


</header>
<body>
    <script>

    </script>
</body>