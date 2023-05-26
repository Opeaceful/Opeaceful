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
	        			<div id="main-time-box">
	        				<div id="main-day"></div>
	        				<div id="main-time"></div>
	        			</div>
	        			<div class="main-info"></div>
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
    
	    const today = document.getElementById('main-day');
	    const time = document.getElementById('main-time');
	    
	    let d = new Date();   

	    let year = d.getFullYear(); // 년도
	    let month = d.getMonth() + 1;  // 월
	    let date = d.getDate();  // 날짜
	    
	    let weekday = new Array(7);
	    weekday[0] = "일요일 (Sunday)";
	    weekday[1] = "월요일 (Monday)";
	    weekday[2] = "화요일 (Tuesday)";
	    weekday[3] = "수요일 (Wednesday)";
	    weekday[4] = "목요일 (Thursday)";
	    weekday[5] = "금요일 (Friday)";
	    weekday[6] = "토요일 (Saturday)";

	    var day = weekday[d.getDay()];


	    today.innerHTML = year + "-" + month + "-" + date  + "(" + day  + ")";
	    
        // 1초마다 현재 시각 업데이트
       setInterval(() => {
            const date = new Date(); // 새로운 Date 객체 생성
            time.innerHTML = date.toLocaleTimeString();
        }, 1000);

	</script>


</body>
</html>