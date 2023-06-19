<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatMain</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" /> -->
<!-- 부트스트랩 아이콘 -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" /> -->
<!-- fontawesome -->
<!-- <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script> -->

<%-- <link rel="stylesheet" href="${path}/resources/css/common/common.css"> --%>
<link rel="stylesheet" href="${path}/resources/css/chat/chat-main-layout.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-friend.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-general.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-room.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chatting.css">
<link rel="stylesheet" href="${path}/resources/css/common/memberSelect.css">

<style>
 #chat_room_content{
    display: none;
  }
/*  #chat_content{
   display: none;
  } */
  
  
</style>
</head>
<body>

<!-- 코드시작 -->
<div id="dialog">
    <div id="chat_content">
        <!-- 설정바(최소화, 최대화, 닫기 버튼) -->
        <div class="chat_setting_bar">
<!--             <i class="fa-regular fa-window-restore" id="maximizeButton"></i> -->
            <i class="fa-solid fa-xmark" id="dialog_close"></i>
        </div>

        <!-- 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 -->
        <header id="chat_header">
            <h1 id="chat_header_title">Opeaceful</h1>
<!--             <span><i class="fa-solid fa-user-plus"></i></span> -->
<!--             <span><i class="fa-solid fa-magnifying-glass"></i></span> -->
        </header>
        
        <!-- 친구창, 대화창, 설정창 등 이동 가능한 네비게이터 -->
        <nav id="chat_nav">
            <div class="chat_main_menu">
                <a>
                    <i class="fa-solid fa-user" id="chat_dialog" onclick="toggleChat()"></i>
                </a>
                <a>
                    <i class="fa-regular fa-comment"  id="chatRoom_dialog" onclick="toggleChatRoom()"></i>
<!--                     <span class="alert-balloon" alt="알림수">3</span> -->
                </a>
<!--                 <a href="more_menu.html"> -->
<!--                     <i class="fa-solid fa-ellipsis"></i> -->
<!--                     <span class="alert-balloon" alt="알림수">N</span> -->
<!--                 </a> -->
            </div>
            <div class="chat_sub_menu">
                <i class="fa-regular fa-bell"></i>
                <i class="fa-solid fa-gear"></i>
            </div>
        </nav>
        
        <!-- 메인: 친구창 메인 내용 -->
        <main id="chat_main">
            <!-- 나의 프로필 -->
            <div>
                <ul class="chat_ul">
                    <li class="chat_main_li">
                    	<c:if test="${empty loginUser.profileImg}">
                        	<img src="${path}/resources/image/chat/default.png" alt="나의프로필사진">
                        </c:if>
                        <c:if test="${!empty loginUser.profileImg}">
                        	<img src="${path}/resources/file/mypage/${loginUser.profileImg}" alt="나의프로필사진">
                         </c:if>
                        <div class="chat_profile">
                            <p>${loginUser.userName}</p>                         
                            <p><select id="statusList">
							    <option value="0" title="${path}/resources/image/status/offline.svg"
							      <c:if test="${loginUser.statusType == 0}">selected</c:if>
							    >오프라인</option>
							    <option value="1"
							      <c:if test="${loginUser.statusType == 1}">selected</c:if>
							    >온라인</option>
							    <option value="2"
							      <c:if test="${loginUser.statusType == 2}">selected</c:if>
							    >자리비움</option>
							    <option value="3"
							      <c:if test="${loginUser.statusType == 3}">selected</c:if>
							    >회의중</option>
							    <option value="4"
							      <c:if test="${loginUser.statusType == 4}">selected</c:if>
							    >식사중</option>
							  </select></p>      					               						
                        </div>
                    </li>
                </ul>
            </div>
            
            <!-- 공지 영역-->
            <div class="profile-notice">
                <div class="chat_profile_title">
                    <h2>공지</h2>
                </div>
                <ul class="chat_ul">
                    <li class="chat_main_li">
                        <img src="${path}/resources/image/chat/megaphone.jpg" alt="공지사진">
                        <div class="chat_profile" id="boardNotice">
                            <%-- <c:forEach var="board" items="${response.notice}">
							  <c:if test="${board.boardNo eq 1}">
							    <p>${board.boardTitle}</p>
							  </c:if>
							</c:forEach>
                            <p>Opeaceful 성장률 200% 달성했다</p> --%>
                        </div>
                    </li>
                </ul>
            </div>
            
            <!-- 즐겨찾기 프로필 모음-->
            <div>
                <div class="chat_profile_title">
                    <h2>즐겨찾기</h2>
                </div>
                <ul class="chat_ul" id="favorite_list">
<!--                     <li class="chat_main_li"> -->
<%--                         <img src="${path}/resources/image/chat/friend1.png" alt="친구1프로필사진"> --%>
<!--                         <div class="chat_profile"> -->
<!--                             <p>한승은</p> -->
<!--                             <p></p> -->
<!--                         </div> -->
<!--                     </li> -->
<!--                     <li class="chat_main_li"> -->
<%--                         <img src="${path}/resources/image/chat/friend2.png" alt="친구2프로필사진"> --%>
<!--                         <div class="chat_profile"> -->
<!--                             <p>윤지영</p> -->
<!--                             <p>지금 몇시니</p> -->
<!--                         </div> -->
<!--                     </li> -->
                </ul>
            </div>
            
            <!-- 친구 프로필 모음 -->
            <div>
                <div class="chat_profile_title">
                    <h2>프로젝트 팀원</h2>
                    <p>버스</p>
                </div>
                <ul id="adminList">
                 
                </ul>
                  <%--   <c:forEach var="member" items="${memberList}">
        				<li class="chat_main_li">
	        				<c:if test="${empty member.profileImg}">
	                        	<img src="${path}/resources/image/chat/default.png" alt="프로필사진">
	                        </c:if>
	                        <c:if test="${!empty member.profileImg}">
	                        	<img src="${member.profileImg}" alt="${member.userName} 프로필사진">
	                         </c:if>
				            <div class="profile">
				                <p>${member.userName}</p>
				                <p>
				                  <c:forEach var="status" items="${onlineStatus}">
					                 <c:if test="${status.statusType eq member.statusType}">
					                     ${status.statusName}
					                 </c:if>
				                  </c:forEach>
				                </p>
				                <p>
				                  <c:forEach var="status" items="${onlineStatus}">
					                 <c:if test="${status.statusType eq member.statusType}">
					                     ${status.statusImg}
					                 </c:if>
				                  </c:forEach>
				                </p>
				            </div>
				        </li>
				    </c:forEach> --%>
            </div>
        </main>
        <!-- aside: 광고 -->
        <aside id="chat_aside">
            <img src="${path}/resources/image/chat/help.webp" alt="광고이미지">
        </aside>
    </div> 
    
    
    
    
    
	<!-- 코드시작 -->
<!-- 	<div id="dialog">  -->
        <div id="chat_room_content">
            <!-- 설정바(최소화, 닫기 버튼 등) -->
            <div class="chat_setting_bar">
<!--                 <i class="fa-regular fa-window-restore" id="maximizeButton"></i> -->
                <i class="fa-solid fa-xmark" id="dialog_close"></i>
            </div>
            
            <!-- 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 -->
            <header id="chat_header">
                <h1 id="chat_header_title">채팅</h1>
                <i class="icon-down-dir"></i>
                <span id="open-dialog-button"><i class="fa-solid fa-comment-medical"></i></span> 
<!--    			    <span><i class="fa-solid fa-magnifying-glass" ></i></span> -->
            </header>
            
            <!-- 친구창, 대화창, 설정창 등 이동 가능한 네비게이터 -->
             <nav id="chat_nav">
	            <div class="chat_main_menu">
	                <a>
	                    <i class="fa-solid fa-user" id="chat_dialog_return" onclick="toggleChat()"></i>
	                </a>
	                <a>
	                    <i class="fa-regular fa-comment"  id="chatRoom_dialog_return" onclick="toggleChatRoom()"></i>
<!-- 	                    <span class="alert-balloon" alt="알림수">3</span> -->
	                </a>
<!-- 	                <a href="more_menu.html"> -->
<!-- 	                    <i class="fa-solid fa-ellipsis"></i> -->
<!-- 	                    <span class="alert-balloon" alt="알림수">N</span> -->
<!-- 	                </a> -->
	            </div>
	            <div class="chat_sub_menu">
	                <i class="fa-regular fa-bell"></i>
	                <i class="fa-solid fa-gear"></i>
	            </div>
	        </nav>
            <!-- 메인: 채팅 리스트 화면 -->
            <main id="chat_main">
                <ul class="chat__room_ul">
						<%-- <c:choose>
							<c:when test="${empty chatRoomList}">
								<tr>
									<td colspan="4">존재하는 채팅방이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="chatRoom" items="${chatRoomList }">
									<c:if test="${chatRoom.eno eq loginUser.eno}">
										<li class="chat_room_li"><a href="#"> <c:if
													test="${empty chatRoom.profileImg}">
													<img src="${path}/resources/image/chat/default.png"
														class="profile-img" alt="나의프로필사진">
												</c:if> <c:if test="${!empty chatRoom.profileImg}">
													<img src="${chatRoom.profileImg}" class="profile-img">
												</c:if>
												<div class="chat_talk">
													<p class="chat_admin_name">${chatRoom.roomTitle }</p>
													<p class="chat_msg">${chatRoom.userName }</p>
												</div>
												<div class="chat_room_status">
													<time class="chat_time" datetime="15:40:00+09:00">${chatRoom.createdChat}</time>
													<span class="chat_balloon">${chatRoom.eno}</sapn>
												</div>
										</a></li>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose> --%>
						<!-- <li class="chat_li">
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
                    </li> -->
                </ul>
            </main>
            <!-- aside: 광고 -->
            <aside id="chat_aside">
            <img src="${path}/resources/image/chat/help.webp" alt="광고이미지">
        	</aside>       
      </div>     
    </div>
    
	    <!--data-bs-target="#all-user-view" 조회할 구역에 data-target넣어주기-->
	  <!--버튼에 id =  "id="all-member-view-button" 값 넣어주기-->
	  <!--예시) <button type="button" class="search-btn" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass" data-bs-toggle="modal" data-bs-target="#all-user-view"></i></button> -->
	
	  <!--input 창으로도 검색하고 싶다면 input창에 id="member-search-keyword" 넣어주기!!!!!!!!!!!!-->
	
	  
	 <!-- 멤버 조회 모달 Modal -->
     <div class="modal fade" id="chat-all-user-view" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" id="modal-user-view">
      <div class="modal-content"  id="all-user-view-content" >
        <!--헤더-->
        <div class="modal-header">
          <h1 class="modal-title fs-5">사용자 검색</h1>
          <button type="button" class="btn-close" id="chat-all-uesr-btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body scroll-bar">
            <!--검색창-->
            <div class="search-wrap2 input-group mb-3 ms-1">
                <input type="text" class="search-input2 form-control box-shadow-none" placeholder="사원번호 또는 이름 입력" id="chat-all-user-view-int">
                <button class="btn btn-outline-secondary search-btn2" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
            <div>
                <form>
                    <table class="table table-hover table-common" id="chat-all-member-table">
                        <thead>
                            <tr>
                              <th scope="col" class="W-10">
                                <input class="form-check-input" type="checkbox" id="chat-all-tcode" data-key="A1">
                              </th>
                              <th scope="col">팀명</th>
                              <th scope="col" class="W-10">
                                <input class="form-check-input" type="checkbox" id="chat-all-userName" data-key="" disabled>
                              </th>
                              <th scope="col">성명</th>
                            </tr>
                          </thead>
                          <tbody class="table-group-divider" id="chat-all-member-table-body">
                      </tbody>
                    </table>     
                </form>
            </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-primary ms-1 ok-common" id="chat-all-member-modal-button" data-dismiss="modal">확인</button>
        </div>

      </div>
    </div>
  </div>
   
   <script type="module" src="${path}/resources/js/chat/chat.js"></script> 
   <script type="text/javascript" src="${path}/resources/js/chat/chatJs.js"></script> 
   <script type="module" src="${path}/resources/js/chat/chatModal.js"></script>
 
   
   <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
      
</body>   
    
</html>