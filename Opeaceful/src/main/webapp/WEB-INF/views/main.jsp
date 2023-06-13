<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/"></script>
	<link href='${path}/resources/fullcalendar-4.4.0/packages/core/main.css' rel='stylesheet' />
	<link href='${path}/resources/fullcalendar-4.4.0/packages/daygrid/main.css' rel='stylesheet' />
	<script src='${path}/resources/fullcalendar-4.4.0/packages/core/main.js'></script>
	<script src='${path}/resources/fullcalendar-4.4.0/packages/interaction/main.js'></script>
	<script src='${path}/resources/fullcalendar-4.4.0/packages/daygrid/main.js'></script>
	<!-- 캘린더 내 부트스트랩적용 스크립트 -->
	<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/bootstrap5@6.1.7/index.global.min.js"></script>
	
	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">

    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">


    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
    <link rel="stylesheet" href="${path}/resources/css/main.css">

	<link rel="stylesheet" href="${path}/resources/css/calendar/calendar.css">

</head>
<body>
	
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="main-wrap container">
        	<div class="row">
				<!-- 왼쪽영역 -->
	        	<div class="main-left col-7">
	        	
	        		<!-- 공지사항 -->
	        		<div class="square-box" id="board-box">
						<h5 class="main-title" id="main-notice-title">공지사항</h5>
						
						<div class="main-content-wrap">
							<c:if test="${empty mainNoticeList}">
								<div class="main-content-text row">
									<div class="col">등록된 공지사항이 없습니다.</div>
								</div>
							</c:if>
							<c:forEach items="${mainNoticeList}" var="n">
								<div class="main-content-text row" onClick='location.href="${path}/board/detail/N/${n.boardNo}"'>
									<div id="board-no" style="display: none;">${n.boardNo }</div>
									<div class="col-9">${n.boardTitle }</div>
									<div class="col-3 text-end">${n.createDate }</div>
								</div>
							</c:forEach>
						</div>
	        		</div>
	        		
	        		<!-- 전자결재 -->
	        		<div class="square-box" id="sign-box">
						<h5 class="main-title">전자결재</h5>
						
						<div class="main-content-wrap">
							<div class="main-content-text row">
								<div class="col">결재 문서가 <span class="main-sign-count" id="main-sign-ck">3</span> 건 있습니다.</div>
								<div class="col">승인 대기중인 결재 문서가 <span class="main-sign-count" id="main-sign-wait">3</span> 건 있습니다.</div>
							</div>
							<div class="main-content-text text-end" id="main-sign-go">
								결제확인 &gt;&gt;
							</div>
						</div>
	        		</div>
	        		
	        		<!-- 날씨 -->
	        		<div class="square-box" id="weather-box">
							<h5 class="main-title">날씨<div class="city"></div></h5>
							

						<div class="main-content-wrap weather">
							<div class="row">
								<!-- 현재날씨 -->
								<div class="curr-weather col-5">
									<!-- 아이콘 -->
									<div class="currIcon text-center"></div>
									<!-- 현재 온도 -->
									<div class="currTemp text-center"><span>º</span></div>
									<div class="row">
										<!-- 풍속 -->
										<div class="weather_text_s currWind col"><i class="ri-windy-line"></i></div>
										<!-- 습도 -->
										<div class="weather_text_s currHumidity col text-center">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M7.05025 8.04673L12 3.09698L16.9497 8.04673C19.6834 10.7804 19.6834 15.2126 16.9497 17.9462C14.2161 20.6799 9.78392 20.6799 7.05025 17.9462C4.31658 15.2126 4.31658 10.7804 7.05025 8.04673ZM18.364 6.63252L12 0.268555L5.63604 6.63252C2.12132 10.1472 2.12132 15.8457 5.63604 19.3604C9.15076 22.8752 14.8492 22.8752 18.364 19.3604C21.8787 15.8457 21.8787 10.1472 18.364 6.63252ZM16.2427 10.1714L14.8285 8.75718L7.7574 15.8282L9.17161 17.2425L16.2427 10.1714ZM8.11095 11.232C8.69674 11.8178 9.64648 11.8178 10.2323 11.232C10.8181 10.6463 10.8181 9.69652 10.2323 9.11073C9.64648 8.52494 8.69674 8.52494 8.11095 9.11073C7.52516 9.69652 7.52516 10.6463 8.11095 11.232ZM15.8891 16.8889C15.3033 17.4747 14.3536 17.4747 13.7678 16.8889C13.182 16.3031 13.182 15.3534 13.7678 14.7676C14.3536 14.1818 15.3033 14.1818 15.8891 14.7676C16.4749 15.3534 16.4749 16.3031 15.8891 16.8889Z"></path></svg></div>
										<div class="weather_text_s currLT col text-end">
											<!-- 최저온도 -->
											<span class="currLowTemp"></span>
											<!-- 최고온도 -->
											<span class="currHighTemp"></span>
										</div>
									</div>
								</div>
								<!-- 주간날씨 -->
								<div class="week-weather col-7">
									<div class="row text-center">
									</div>
									<div class="text-end">
										<a id="main-naver-go" href="https://weather.naver.com/" target="_blank">날씨보기 &gt;&gt;</a>
									</div>
								</div>
							</div>
						</div>
	        		</div>
	        	</div>
	        	
	        	
	        	
	        	<!-- 오른쪽 영역 -->
	        	<div class="main-right col-5">
	        	
	        		<!-- 내정보 -->
	        		<div class="square-box" id="my-box">
	        			<!-- 시간표시 부분 -->
	        			<div class="main-time-box text-center">
	        				<div id="main-day"></div>
	        				<div id="main-time"></div>
	        			</div>
	        			
	        			<!-- 내정보 및 출퇴근 버튼 부분 -->
	        			<div class="main-info">
	        				<!-- 내정보 -->
	        				<div class="main-info-top row">
	        					<div class="col-3 text-start main-d-day">입사한지 <span id="main-d-day"></span>일</div>
	        					<div class="col text-center main-profile-box">
									<!-- 프로필 이미지 -->
									<div class="main-profile">
		                               <c:if test="${empty loginUser.profileImg}">
		                                   <img id="main-profile-img" src="${path}/resources/file/mypage/basic_profile.png">
		                               </c:if>
		
		                               <c:if test="${!empty loginUser.profileImg}">
		                                   <img id="main-profile-img" src="${path}/resources/file/mypage/${loginUser.profileImg}">
		                               </c:if>
				                    </div>
				                    
				                    <!-- 이름, 부서, 직급 -->
				                    <div id="main-name">${loginUser.userName}</div>
				                    <div class="main-dp">
				                    	<span id="main-deptName">${loginUser.DName}</span> 
				                    	<span id="main-pName">${loginUser.PName}</span>
				                    </div>
	        					</div>
	        					<div class="col-3 text-end">
		        					<!-- 오프라인 온라인 자리비움 회의중 식사중 -->
		        					<div id="state">
										<div class="select">
											<div class="text">
												<c:forEach items="${os}" var="onStatus">
													<c:if test="${onStatus.statusType eq loginUser.statusType}">
														<img title="${onStatus.statusType}" src="${path}/resources/image/status/${onStatus.statusImg}">
													</c:if>
												</c:forEach>
											</div>
											<ul class="option-list">
												<c:forEach items="${os}" var="onStatus">
													<li class="option" id="${onStatus.statusType}"><img title="${onStatus.statusType}" src="${path}/resources/image/status/${onStatus.statusImg}"></li>
												</c:forEach>
											</ul>
										</div>
		        					</div>
		        					
		        					<!-- 색상모드 -->
		        					<div id="color-mode">
										<div class="mode-select">
											<div class="mode-text"><span class="color-frame" id="white"></span></div>
											<ul class="mode-list">
												<li class="mode"><span class="color-frame" id="white"></span></li>
												<li class="mode"><span class="color-frame" id="black"></span></li>
											</ul>
										</div>
		        					</div>
	        					</div>
	        				</div>
	        				
	        				<!-- 출퇴근 -->
	        				<div class="d-flex main-info-bottom">

								<!-- 출근날짜가 비워져있으면 출근버튼 활성화(navy-btn) + 퇴근버튼 비활성화(white-btn) -->
								<c:if test="${empty attendance.workDate}">
									<input type="button" class="on_off_btn w90-btn navy-btn" name="onOff" id="main-on" value="출근">								 
									<input type="button" class="on_off_btn w90-btn white-btn" name="onOff" id="main-off" value="퇴근">
								</c:if>
								<!-- 출근시간이 있으면 출근버튼 비활성화(white-btn) + 퇴근버튼 활성화(navy-btn) -->
								<c:if test="${!empty attendance.workOn && empty attendance.workOff}">
									<input type="button" class="on_off_btn w90-btn white-btn" name="onOff" id="main-on" value="출근">								 
									<input type="button" class="on_off_btn w90-btn navy-btn" name="onOff" id="main-off" value="퇴근">
								</c:if>
								<!-- 퇴근시간 있으면 출/퇴근버튼 모두 비활성화(white-btn) -->
								<c:if test="${not empty attendance.workOff}">
									<input type="button" class="on_off_btn w90-btn white-btn" name="onOff" id="main-on" value="출근">								 
									<input type="button" class="on_off_btn w90-btn white-btn" name="onOff" id="main-off" value="퇴근">
								</c:if>
<!-- 
								<input type="button" class="on_off_btn w90-btn navy-btn" name="onOff" id="main-on" value="출근">								 
								<input type="button" class="on_off_btn w90-btn white-btn" name="onOff" id="main-off" value="퇴근">
								 -->
							</div>

	        			</div>
	        		</div>
	        		
	        		<!-- 캘린더 -->
	        		<div class="square-box" id="calender-box">
						<div id='calendarM'></div>
	        		</div>
	        		
	        	</div>
        	</div>
            
        </div>
    </div>
    

<script type="module" src="${path}/resources/js/main.js"></script>
<script type="module" src="${path}/resources/js/weather.js"></script>
<script>
	var mainHireDate = '${loginUser.hireDate}';
</script>



</body>
</html>