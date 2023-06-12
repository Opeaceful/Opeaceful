<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <button class="btn btn-outline-secondary search-btn2" id="ad-btn" type="button">조회</button>
                </div>
             </div>
             <c:forEach items="${loginUserRole}" var="role">
							<c:if test="${role.roleCode eq 'D01'}">
								<div class="p-3">
					                <div class="row">
					                    <div class="col-1 text">
					                        사원명
					                    </div>
					                    <div class="col-11 search-wrap2 input-group mb-3">
					                        <input type="text" class="search-input2 form-control box-shadow-none" id="member-search-keyword" placeholder="사원명">
					                        <button class="btn btn-outline-secondary search-btn2" id="all-member-view-button" type="button"><i class="fa-solid fa-magnifying-glass" data-bs-toggle="modal" data-bs-target="#all-user-view"></i></button>
					                    </div>
					                </div>
					             </div>
							</c:if>
						</c:forEach>
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
                <tbody id="AttendanceTbody">
                	<c:forEach items="${userAd}" var="ad">
	                    <tr>
	                        <td>${ad.workDate}</td>
	                        <td>${ad.userName}</td>
	                        <td><fmt:formatDate value="${ad.workOn}" pattern="HH:mm"/></td>
	                        <td><fmt:formatDate value="${ad.workOff}" pattern="HH:mm"/></td>
	                        <td><fmt:formatDate value="${ad.totalWorkTime}" pattern="kk"/>시간</td>
	                        <c:if test="${ad.type eq 1}">
		                    	<td>연차</td>
                        	</c:if>
                        	<c:if test="${ad.type eq 2}">
		                    	<td>오전 반차</td>
                        	</c:if>
                        	<c:if test="${ad.type eq 3}">
		                    	<td>오후 반차</td>
                        	</c:if>
	                    </tr>                		
                	</c:forEach>
                </tbody>
            </table>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/member/member-select.jsp"/>
    <script type="module" src="${path}/resources/js/attendance.js"></script>
    <script>
    	let userNo = ${loginUser.userNo};
    	console.log(userNo);
    </script>
</body>
</html>