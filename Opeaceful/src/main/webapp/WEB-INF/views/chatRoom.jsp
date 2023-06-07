<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatRoom</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" />
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" />
<!-- fontawesome -->
<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-main-layout.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-room.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-general.css">
</head>
<body>

	<!-- 코드시작 -->
	<div id="dialog">
        <div id="chat_content">
            <!-- 설정바(최소화, 닫기 버튼 등) -->
            <div class="chat_setting_bar">
                <i class="fa-regular fa-window-restore" id="maximizeButton"></i>
                <i class="fa-solid fa-xmark" class="close" onclick="window.parent.closeLayer()"></i>
            </div>
            <!-- 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 -->
            <header id="chat_header">
                <h1 id="chat_header_title">채팅</h1>
                <i class="icon-down-dir"></i>
                <span><i class="fa-solid fa-user-plus"></i></span>
                <span><i class="fa-solid fa-magnifying-glass"></i></span>
            </header>
            <!-- 친구창, 대화창, 설정창 등 이동 가능한 네비게이터 -->
             <nav id="chat_nav">
	            <div class="chat_main_menu">
	                <a>
	                    <i class="fa-solid fa-user" id="chatdialog"></i>
	                </a>
	                <a>
	                    <i class="fa-regular fa-comment" id="chatRoom_dialog"></i>
	                    <span class="alert-balloon" alt="알림수">3</span>
	                </a>
	                <a href="more_menu.html">
	                    <i class="fa-solid fa-ellipsis"></i>
	                    <span class="alert-balloon" alt="알림수">N</span>
	                </a>
	            </div>
	            <div class="chat_sub_menu">
	                <i class="fa-regular fa-bell"></i>
	                <i class="fa-solid fa-gear"></i>
	            </div>
	        </nav>
            <!-- 메인: 채팅 리스트 화면 -->
            <main id="chat_main">
                <ul class="chat_ul">
                    <li class="chat_li">
                        <c:choose>
					        <c:when test="${empty chatRoomList}">
					            <tr>
					                <td colspan="4">존재하는 채팅방이 없습니다.</td>
					            </tr>
					        </c:when>
					        <c:otherwise>
                            <c:forEach var="chatRoom" items="${chatRoomList }">
                        <a href="#">
                             <c:if test="${chatRoom.userName eq loginUser.userName}">
	                            <c:if test="${empty chatRoom.profileImg}">
	                        		<img src="${path}/resources/image/chat/default.png" class="profile-img" alt="나의프로필사진">
		                        </c:if>
		                        <c:if test="${!empty chatRoom.profileImg}">
		                            <img src="${chatRoom.profileImg}" class="profile-img">		                        	
		                         </c:if>                            
<!--                             <img src="./pic/k-pay.png" class="profile-img" alt="프로필사진"> -->
	                            <div class="chat_talk">
	                            	<p class="chat_admin_name">${chatRoom.roomName }</p>
	                           		<p class="chat_msg">${chatRoom.userName }</p>		                            
<!--                                <p class="chat_admin_name">프로젝트</p> -->
<!--                                <p class="chat_msg">메시지가 도착했습니다.</p> -->
                        	    </div>
                            <div class="chat_room_status">
                                <time class="chat_time" datetime="15:40:00+09:00">오후 3:40</time>
                                <span class="chat_balloon">1</sapn>
                            </div>
                        </a>
									</c:if>
                                 </c:forEach>
                                   </c:otherwise>
							    </c:choose>
                    </li>
                    <li class="chat_li">
                        <a href="#">
                            <img src="./pic/default.png" class="profile-img" alt="프로필사진">
                            <div class="chat_talk">
                                <p class="chat_admin_name">새벽2시</p>
                                <p class="chat_msg">4시간후 일어나야해</p>
                            </div>
                            <div class="chat_room_status">
                                <time class="chat_time" datetime="15:39:00+09:00">오후 3:39</time>
                                    <span class="chat_balloon">1</span>
                            </div>
                        </a>
                    </li>
                    <li class="chat_li">
                        <a href="bbu-chat-room.html" target="_blank">
                            <img src="./pic/default.png" class="profile-img" alt="프로필사진">
                            <div class="chat_talk">
                                <p class="chat_admin_name">병원</p>
                                <p class="chat_msg">약먹자</p>
                            </div>
                            <div class="chat_room_status">
                                <time class="chat_time" datetime="10:15:00+09:00">오전 10:15</time>
                            </div>
                        </a>
                    </li>
                    <li class="chat_li">
                        <a href="#">
                            <img src="./pic/me.png" class="profile-img" alt="프로필사진">
                            <div class="chat_talk">
                                <p class="chat_admin_name"><span class="chat_me">나</span>김진기</p>
                                <p class="chat_msg">사진을 보냈습니다.</p>
                            </div>
                            <div class="chat_room_status">
                                <time class="chat_time"datetime="04:10:00+09:00">오전 4:10</time>
                            </div>
                        </a>
                    </li>
                    <li class="chat_li">
                        <a href="#">
                            <img src="./pic/group.png" class="profile-img" alt="프로필사진">
                            <div class="chat_talk">
                                <p class="chat_admin_name">한승은, 윤지영<span class="chat_member_cnt">3</span></p>
                                <p class="chat_msg">버스 태워주세요</p>
                            </div>
                            <div class="chat_room_status">
                                <time class="chat_time" datetime="2021-03-28">어제</time>
                            </div>
                        </a>
                    </li>
                    <li class="chat_li">
                        <a href="#">
                            <img src="./pic/friend1.png" class="profile-img" alt="프로필사진">
                            <div class="chat_talk">
                                <p class="chat_admin_name">test</p>
                                <p class="chat_msg">test</p>
                            </div>
                            <div class="chat_room_status">
                                <time class="chat_time" datetime="2021-03-20">2021-03-20</time>
                                <span class="chat_balloon">1</span>
                            </div>
                        </a>
                    </li>
                </ul>
            </main>
            <!-- aside: 광고 -->
            <aside id="chat_aside">
            <img src="${path}/resources/image/chat/help.webp" alt="광고이미지">
        </aside>
        
     </div>   
            
            <script type="module" src="${path}/resources/js/chat/chat.js"></script>

</body>
</html>