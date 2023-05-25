<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/attendance.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	
	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">근태 조회</h2>
			</div>
            <div class="col-12 p-3">
                <div class="row">
                    <div class="col-1 text">
                        기간
                    </div>
                    <div class="col-5 select-box1">
                        <select name="year" id="year1" title="년도" class="custom-select"></select>
                        <select name="month" id="month1" title="월" class="custom-select"></select>
                        <select name="day" id="day1" title="일" class="custom-select"></select>
                    </div>
                    <div class="col-1 wave">
                        ~
                    </div>
                    <div class="col-5">
                        <select name="year" id="year2" title="년도" class="custom-select"></select>
                        <select name="month" id="month2" title="월" class="custom-select"></select>
                        <select name="day" id="day2" title="일" class="custom-select"></select>
                    </div>
                </div>
             </div>
             <div class="p-3">
                <div class="row">
                    <div class="col-1 text">
                        사원명
                    </div>
                    <div class="col-11 search-wrap2 input-group mb-3">
                        <input type="text" class="search-input2 form-control box-shadow-none" placeholder="사원명">
                        <button class="btn btn-outline-secondary search-btn2" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
             </div>
             <table class="table table-hover table-common">
                <thead>
                    <tr>
                        <th>일자</th>
                        <th>사원명</th>
                        <th>출근시간</th>
                        <th>퇴근시간</th>
                        <th>근무시간</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2023/05/23</td>
                        <td>박가영</td>
                        <td>09:00</td>
                        <td>18:00</td>
                        <td>9시간</td>
                        <td>연차</td>
                        <td class="icon">
                            <i class="fa-solid fa-minus ad-minus"></i> 
                            <i class="fa-solid fa-pen ad-pen"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script src="${path}/resources/js/attendance.js"></script>
</body>
</html>