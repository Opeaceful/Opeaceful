<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	
	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
	<script src="https://kit.fontawesome.com/3d2d296c5f.js" crossorigin="anonymous"></script>
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"/>
   
    <!-- JavaScript Bundle with Popper -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
   
   <!-- jquery  -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   
   <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!--    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"> -->
   <link rel="stylesheet" href="${path}/resources/css/common/sidebar.css">

</head>
<body>
	<!-- 
		a 태그에 각자 페이지 넣어주기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 -->
    <div class="sidebar">
        <div class="sidebar-icon sidebar-logo">
            <span class="side-icon-size"><i class="fa-solid fa-feather"></i></span>
        </div>
        <div class="sidebar-wrap sidebar-top overflow-auto">
            <ul>
                <!-- 메인 -->
                <li id="sidebar-main">
					<a href="${path}/main">
                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-house"></i></span>
                        <span class="sidebar-text">홈</span>
                    </a>
                </li>
			
                <!-- 조직도 -->
                <li id="sidebar-chart">
                    <div class="one-line sidebar-cursor" id="chart-menu">
                        <span class="side-icon-size"><i class="sidebar-icon bi bi-diagram-3"></i></span>
                        <span class="sidebar-text">조직도</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="chart-menu-item">
						<c:forEach items="${loginUserRole}" var="role">
							<c:if test="${role.roleCode eq 'D01'}">
		                        <a class="sidebar-more-text" href="${path}/orgChart/">조직도 등록</a>
							</c:if>
						</c:forEach>
                        <a class="sidebar-more-text" href="${path}/orgChart/selectOrgChart">조직도 현황</a>
                    </div>
                </li>

                <!-- 메일 -->
                <li id="sidebar-mail">
                    <a href="">
                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-envelope"></i></span>
                        <span class="sidebar-text">메일</span>
                    </a>
                </li>

                <!-- 게시판 -->
                <li id="sidebar-board">
                    <div class="one-line sidebar-cursor" id="board-menu">
                        <span class="side-icon-size"><i class="sidebar-icon bi bi-file-text"></i></span>
                        <span class="sidebar-text">게시판</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="board-menu-item">
                    <c:forEach var="boardType" items="${boardTypeList}">
                        <a class="sidebar-more-text" href="${path}/board/list/${boardType.boardCd}">${boardType.boardName}</a>
                        </c:forEach>
                    </div>
                </li>

                <!-- 캘린더 -->
                <li id="sidebar-calender">
                    <a href="${path}/calendar/calendarForm/M">
                        <span class="side-icon-size"><i class="sidebar-icon bi bi-calendar-date"></i></span>
                        <span class="sidebar-text">캘린더</span>
                    </a>
                </li>

                <!-- 전자결재 -->
                <li id="sidebar-sign">
                    <div class="one-line sidebar-cursor" id="sign-menu">
                        <span class="side-icon-size"><i class="sidebar-icon bi bi-briefcase-fill"></i></span>
                        <span class="sidebar-text">전자결재</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="sign-menu-item">
                        <a class="sidebar-more-text" href="${path}/approval/approvalForm">결재 양식</a>
                        <a class="sidebar-more-text" href="${path}/approval/allApproval">전자결재 관리</a>
                        <a class="sidebar-more-text" href="${path}/approval/myApproval">MY 전자결재</a>
                    </div>
                    
                    
                </li>

                <!-- 근태 -->
				<li id="sidebar-work">
				    <a href="${path}/attendance/">
				        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-clock"></i></span>
				        <span class="sidebar-text">근태</span>
				    </a>
				</li>
				
				<!-- 급여관리 -->
                <li id="sidebar-salary">
                    <div class="one-line sidebar-cursor" id="salary-menu">
                        <span class="side-icon-size"><i class="sidebar-icon fa-solid bi-cash-coin"></i></span>
                        <span class="sidebar-text">급여관리</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i>
                    </div>

                    <div class="sidebar-more" id="salary-menu-item">
                        <a class="sidebar-more-text" href="${path}/salary/employee">급여 조회</a>
						<c:forEach items="${loginUserRole}" var="role">
							<c:if test="${role.roleCode eq 'S01'}">
		                        <a class="sidebar-more-text" href="${path}/salary/AllSalary">사원별 급여 관리</a>
							</c:if>
						</c:forEach>
                    </div>
                </li>

                <!-- 연차관리 -->
                <c:forEach items="${loginUserRole}" var="role">
	                <c:if test="${role.roleCode eq 'Y01'}">
		                <li id="sidebar-annual">
		                    <div class="one-line sidebar-cursor" id="annual-menu">
		                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-umbrella-beach"></i></span>
		                        <span class="sidebar-text">연차관리</span>
		                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
		                    </div>
		
		                    <div class="sidebar-more" id="annual-menu-item">
		                        <a class="sidebar-more-text" href="${path}/annual/setting">총 연차 관리</a>
		                        <a class="sidebar-more-text" href="${path}/annual/list">연차 조회</a>
		                    </div>
		                </li>
	                </c:if>
				</c:forEach>
				
                <!-- 계정관리 -->
                <c:forEach items="${loginUserRole}" var="role">
	                <c:if test="${role.roleCode eq 'M01'}">
		                <li id="sidebar-account">
		                    <div class="one-line sidebar-cursor" id="account-menu">
		                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-user-plus"></i></span>
		                        <span class="sidebar-text">계정관리</span>
		                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i>
		                    </div>
		
		                    <div class="sidebar-more" id="account-menu-item">
		                        <a class="sidebar-more-text" href="${path}/member/allview">사용자 조회</a>
		                        <a class="sidebar-more-text" href="${path}/member/create">사용자 등록</a>
		                    </div>
		                </li>
	                </c:if>
                </c:forEach>

                <!-- 권한관리 -->
                <c:forEach items="${loginUserRole}" var="role">
	                <c:if test="${role.roleCode eq 'R01'}">
		                <li id="sidebar-role">
		                    <div class="one-line sidebar-cursor" id="role-menu">
		                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-user-gear"></i></span>
		                        <span class="sidebar-text">권한관리</span>
		                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i>
		                    </div>
		
		                    <div class="sidebar-more" id="role-menu-item">
		                        <a class="sidebar-more-text" href="${path}/role/granting">권한 등록</a>
		                        <a class="sidebar-more-text" href="${path}/role/userRole">사원별 권한 등록</a>
		                    </div>
		                </li>                
	                </c:if>
                </c:forEach>
            </ul>
        </div>

        <div class="sidebar-wrap sidebar-bottom">
            <ul>
                <!-- 마이페이지 -->                
				<li id="sidebar-info">
					<a href="${path}/member/mypage">
                        <span class="side-icon-size"><i class="sidebar-icon bi bi-person-circle"></i></span>
                        <span class="sidebar-text sidebar-bt">마이페이지</span>
                    </a>
                </li>

                <!-- 로그아웃 -->
                <li id="sidebar-logout">
                    <a href="${path}/member/logout">
                        <span class="side-icon-size"><i class="sidebar-icon fa-solid fa-power-off"></i></span>
                        <span class="sidebar-text sidebar-bt">로그아웃</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 채팅아이콘 -->
    <div id="chat-icon" >
		<!-- <i class="bi bi-chat" id="openDialogButton"></i> -->
        <i class="fa-solid fa-comments" id="openDialogButton"></i>
    </div>
    
     <jsp:include page="/WEB-INF/views/chat.jsp"></jsp:include>
	 
    <script>
    	/* 하위카테고리 숨겨두기 */
        $(".sidebar-more").css("display", "none");

		/* 조직도 */
        $("#chart-menu").click(function () {
            $("#chart-menu-item").slideToggle();
        });
		/* 게시판 */
        $("#board-menu").click(function () {
            $("#board-menu-item").slideToggle();
        });
		/* 연차 */
        $("#annual-menu").click(function () {
            $("#annual-menu-item").slideToggle();
        });
		/* 계정 */
        $("#account-menu").click(function () {
            $("#account-menu-item").slideToggle();
        });
		/* 권한 */
        $("#role-menu").click(function () {
            $("#role-menu-item").slideToggle();
        });
		/* 전자결재 */
        $("#sign-menu").click(function () {
            $("#sign-menu-item").slideToggle();
        });
    	/* 급여 */
        $("#salary-menu").click(function () {
            $("#salary-menu-item").slideToggle();
        });
		
        
        
		/* 호버이벤트 */
        $(".sidebar").hover(
   		  function() {
   			  $(".sidebar").css("width", "300px");
              $(".sidebar-bt").css("display", "inline-block");
            //   $("#sidebar-info>a").css('white-space','nowrap');
            //   $("#sidebar-logout>a").css('white-space','nowrap');
		  }, 
   		  function() {
   			$(".sidebar").css("width", "60px");
   			$(".sidebar-more").css("display", "none");
            $(".sidebar-bt").css("display", "none");
		  }
   		);

    </script>
</body>
</html>