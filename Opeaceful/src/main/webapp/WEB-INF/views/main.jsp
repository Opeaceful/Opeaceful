<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	
    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    
    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
    <link rel="stylesheet" href="${path}/resources/css/main.css">

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
								<div class="main-content-text row">
									<div style="display: none;">${n.boardNo }</div>
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
	        			<h5 class="main-title">날씨</h5>
						
						<div class="main-content-wrap">

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
	        					<div class="col text-start main-d-day">입사한지 <span id="main-d-day"></span>일</div>
	        					<div class="col text-center main-profile-box">
									<!-- 프로필 이미지 -->
									<div class="main-profile">
		                               <c:if test="${empty loginUser.profileImg}">
		                                   <img id="main-profile-img" src="${path}/resources/image/mypage/basic_profile.png">
		                               </c:if>
		
		                               <c:if test="${!empty loginUser.profileImg}">
		                                   <img id="main-profile-img" src="${path}/resources/image/mypage/${loginUser.profileImg}">
		                               </c:if>
				                    </div>
				                    
				                    <!-- 이름, 부서, 직급 -->
				                    <div id="main-name">${loginUser.userName}</div>
				                    <div>
				                    	<span id="main-deptName">${dpName.deptName }</span> 
				                    	<span id="main-pName">${dpName.PName }</span>
				                    </div>
	        					</div>
	        					<div class="col text-end">
		        					<!-- 오프라인 온라인 자리비움 회의중 식사중 -->
		        					<div id="state">
										<div class="select">
											<div class="text"><img src="${path}/resources/image/main/online.svg"></div>
											<ul class="option-list">
												<li class="option"><img src="${path}/resources/image/main/online.svg"></li>
												<li class="option"><img src="${path}/resources/image/main/offline.svg"></li>
												<li class="option"><img src="${path}/resources/image/main/eat.svg"></li>
												<li class="option"><img src="${path}/resources/image/main/meeting.svg"></li>
												<li class="option"><img src="${path}/resources/image/main/absence.svg"></li>
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
	        				<div class="text-center main-info-bottom">
								<button type="button" id="main-on" class="w90-btn btn btn-primary">출근</button>
								<button type="button" id="main=off" class="w90-btn btn btn-outline-primary">퇴근</button>
	        				</div>

	        			</div>
	        		</div>
	        		
	        		<!-- 캘린더 -->
	        		<div class="square-box" id="calender-box">
	        		
	        		</div>
	        		
	        		<!-- 메모박스 -->
	        		<div class="square-box" id="memo-box">
	        		
	        		</div>
	        	</div>
        	</div>
            
        </div>
    </div>
    

<script type="module" src="${path}/resources/js/main.js"></script>
<script>
	var mainHireDate = '${loginUser.hireDate}';
	console.log(mainHireDate);
</script>


</body>
</html>