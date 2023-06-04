<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatMain</title>
</head>
<body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" />
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" />
<!-- fontawesome -->
<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-main-layout.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-friend.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-general.css">
</body>
<!-- 코드시작 -->
    <div id="content">
        <!-- 설정바(최소화, 최대화, 닫기 버튼) -->
        <div class="setting_bar">
            <i class="fa-regular fa-window-restore" id="maximizeButton"></i>
            <i class="fa-solid fa-xmark" class="close" onclick="window.parent.closeLayer()"></i>
        </div>

        <!-- 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 -->
        <header>
            <h1>Opeaceful</h1>
            <span><i class="fa-solid fa-user-plus"></i></span>
            <span><i class="fa-solid fa-magnifying-glass"></i></span>
        </header>
        <!-- 친구창, 대화창, 설정창 등 이동 가능한 네비게이터 -->
        <nav>
            <div class="main-menu">
                <a href="friend.html">
                    <i class="fa-solid fa-user"></i>
                </a>
                <a href="chatting.html">
                    <i class="fa-regular fa-comment"></i>
                    <span class="alert-balloon" alt="알림수">3</span>
                </a>
                <a href="more_menu.html">
                    <i class="fa-solid fa-ellipsis"></i>
                    <span class="alert-balloon" alt="알림수">N</span>
                </a>
            </div>
            <div class="sub-menu">
                <i class="fa-regular fa-bell"></i>
                <i class="fa-solid fa-gear"></i>
            </div>
        </nav>
        <!-- 메인: 친구창 메인 내용 -->
        <main>
            <!-- 나의 프로필 -->
            <div>
                <ul>
                    <li>
                    	<c:if test="${empty loginUser.profileImg}">
                        	<img src="${path}/resources/image/chat/default.png" alt="나의프로필사진">
                        </c:if>
                        <c:if test="${!empty loginUser.profileImg}">
                        	<img src="${loginUser.profileImg}" alt="나의프로필사진">
                         </c:if>
                        <div class="profile">
                            <p>${loginUser.userName}</p>
                            <p>${loginUser.userNo}</p>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 공지 영역-->
            <div class="profile-notice">
                <div class="profile-title">
                    <h2>공지</h2>
                </div>
                <ul>
                    <li>
                        <img src="${path}/resources/image/chat/megaphone.jpg" alt="공지사진">
                        <div class="profile">
                            <p>사내소식</p>
                            <p>Opeaceful 성장률 200% 달성했다</p>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 즐겨찾기 프로필 모음-->
            <div>
                <div class="profile-title">
                    <h2>즐겨찾기</h2>
                </div>
                <ul>
                    <li>
                        <img src="${path}/resources/image/chat/friend1.png" alt="친구1프로필사진">
                        <div class="profile">
                            <p>한승은</p>
                            <p></p>
                        </div>
                    </li>
                    <li>
                        <img src="${path}/resources/image/chat/friend2.png" alt="친구2프로필사진">
                        <div class="profile">
                            <p>윤지영</p>
                            <p>지금 몇시니</p>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 친구 프로필 모음 -->
            <div>
                <div class="profile-title">
                    <h2>프로젝트 팀원</h2>
                    <p>버스</p>
                </div>
                <ul id="adminList">
                   
                    <c:forEach var="member" items="${memberList}">
        				<li>
	        				<c:if test="${empty member.profileImg}">
	                        	<img src="${path}/resources/image/chat/default.png" alt="프로필사진">
	                        </c:if>
	                        <c:if test="${!empty member.profileImg}">
	                        	<img src="${member.profileImg}" alt="${member.userName} 프로필사진">
	                         </c:if>
				            <div class="profile">
				                <p>${member.userName}</p> <i>${member.statusType}</i>
				                <p>${member.userNo}</p>
				            </div>
				        </li>
				    </c:forEach>
                     </ul>

               
            </div>
        </main>
        <!-- aside: 광고 -->
        <aside>
            <img src="${path}/resources/image/chat/help.webp" alt="광고이미지">
        </aside>
    </div>
    
    <script src="${path}/resources/js/chat/chat.js"></script> 

</html>