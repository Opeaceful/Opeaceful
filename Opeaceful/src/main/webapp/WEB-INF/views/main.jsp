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
<body onload="getTime();">
	<c:if test="${not empty alertMsg} ">
		<script>
			alertify.alert("서비스 요청 성공", "${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="main-wrap container">
        	<div class="row">
				<!-- 왼쪽영역 -->
	        	<div class="main-left col-7">
	        	
	        		<!-- 공지사항 -->
	        		<div class="square-box" id="board-box">
						<h5 class="main-title">공지사항</h5>
						
						<div class="main-content-wrap">
							<div class="main-content-text row">
								<div class="col-9">2023년 하절기 사옥 냉난방기 운용 관련 공지</div>
								<div class="col-3 text-end">2023-05-12</div>
							</div>
							<div class="main-content-text row">
								<div class="col-9">2023년 06월 전사 플레이샵 조 편성 및 차량배정 관련 공지 글(필독)</div>
								<div class="col-3 text-end">2023-04-24</div>
							</div>
							<div class="main-content-text row">
								<div class="col-9">5/1(월) 근로자의 날 휴무 관련 공지</div>
								<div class="col-3 text-end">2023-04-15</div>
							</div>
							<div class="main-content-text row">
								<div class="col-9">2023년 인사발령</div>
								<div class="col-3 text-end">2023-04-03</div>
							</div>
							<div class="main-content-text row">
								<div class="col-9">2023년 07월 ~ 08월 하계 휴가기간 제주도 리조트 예약 신청 공지 건</div>
								<div class="col-3 text-end">2023-03-12</div>
							</div>
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
	        					<div class="col text-start main-d-day">입사한지 <span id="main-d-day">490</span>일</div>
	        					<div class="col text-center main-profile-box">
									<div class="main-profile">
				                        <img id="main-profile-img" src="${path}/resources/image/mypage/basic_profile.png">
				                    </div>
				                    <div id="main-name">노지의</div>
				                    <div>
				                    	<span id="main-team">영업팀</span> 
				                    	<span id="main-">대리</span>
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

    <script>
    	/* 현재 시간 표시 */
 	    const today = document.getElementById('main-day');
	    const time = document.getElementById('main-time');
	    
		let d = new Date();
		
	    let year = d.getFullYear(); 	// 년도
	    let month = d.getMonth() + 1;	// 월
	    let date = d.getDate();  		// 날짜
	    
	    let weekday = new Array(7);
	    weekday[0] = "일";
	    weekday[1] = "월";
	    weekday[2] = "화";
	    weekday[3] = "수";
	    weekday[4] = "목";
	    weekday[5] = "금";
	    weekday[6] = "토";

	    let day = weekday[d.getDay()];

	    if(month < 10){month = "0"+month;}
	    if(date < 10){date = "0"+date;}
	    today.innerHTML = year + "-" + month + "-" + date  + " (" + day  + ")";
		
	    function getTime() {
			let d = new Date();
			
		    let hur = d.getHours();		// 시
			let min = d.getMinutes();	//분
			let sec = d.getSeconds();	//초
			if(d.getHours() < 10){hur = "0"+hur;}
			if(d.getMinutes() < 10){min = "0"+min;}
			if(d.getSeconds() < 10){sec = "0"+sec;}

			time.innerHTML = hur + " : " + min + " : " + sec;	// 형식 지정
			
			setTimeout(getTime, 1000);	//1000밀리초(1초) 마다 반복
		}
	    
	    
		/* 접속상태 표시 */
	    function onClickState(e) {
	      const isActive = e.currentTarget.className.indexOf("active") !== -1;
	      if (isActive) {
	        e.currentTarget.className = "select";
	      } else {
	        e.currentTarget.className = "select active";
	      }
	    }

	    document.querySelector("#state .select").addEventListener("click", onClickState);

	    function onClickStateOption(e) {
	      const selectedValue = e.currentTarget.innerHTML;
	      document.querySelector("#state .text").innerHTML = selectedValue;
	    }

	    var stateList = document.querySelectorAll("#state .option");
	    for (var i = 0; i < stateList.length; i++) {
	      var state = stateList[i];
	      state.addEventListener("click", onClickStateOption);
	    }
	    
	    
	    /* 칼라모드 표시 */
	    function onClickMode(e) {
	      const isActive = e.currentTarget.className.indexOf("active") !== -1;
	      if (isActive) {
	        e.currentTarget.className = "mode-select";
	      } else {
	        e.currentTarget.className = "mode-select active";
	      }
	    }

	    document.querySelector("#color-mode .mode-select").addEventListener("click", onClickMode);

	    function onClickModeOption(e) {
	      const selectedValue = e.currentTarget.innerHTML;
	      document.querySelector("#color-mode .mode-text").innerHTML = selectedValue;
	    }

	    var ModeList = document.querySelectorAll("#color-mode .mode");
	    for (var i = 0; i < ModeList.length; i++) {
	      var mode = ModeList[i];
	      mode.addEventListener("click", onClickModeOption);
	    }
	    
	</script>


</body>
</html>