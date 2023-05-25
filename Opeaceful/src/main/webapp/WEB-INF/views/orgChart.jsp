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
<link rel="stylesheet" href="../../resources/css/common/common.css">
<link rel="stylesheet" href="../../resources/css/orgChart.css">
</head>
<body>
	<div id="sidebar"></div>
	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">조직도</h2>
			</div>
			<div class="system">
				<ul>
				  <li><p><b>대표이사 타쿠대디</b></p></li>
					<ul>
					  <li><p><b>금융소비자보호총괄책임자<em>(CCO : Chief Consumer Officer)</em></b></p></li>
					  <li><span><b>금융소비자보호협의회<em>(CCO를 포함한 금융소비자보호 최고의결기가)</em></b></span></li>
					  <li><p><b>소비자 보호파트</b></p></li>
						  <ul class="depth3">
							 <li>
							   <strong>소비자제도 기획</strong>
								<div>
								   소비자 보호 관련 업무기획<br>
								   상품개발 및 판매 시 사전협의 및 모니터링 <br>
								   민원분석을 통한 제도 개선
								</div>
							 </li>
							 <li>
							   <strong>VOC 및 민원 업무</strong>
								<div>
								   고객의 소리 접수 및 처리<br>
								   대내외 민원 접수 및 처리 <br>
								   보이스피싱 피해 등 소비자 피해 보상의<br>
								   접수 및 처리
								</div>
							 </li>
							 <li>
							   <strong>피해 예방 모니터링</strong>
								<div>
								   보이스피싱 및 해킹에 의한<br>
								   이상금융거래 등 소비자피해 <br>
								   예방을 위한 모니터링 및 조치
								</div>
							 </li>
						  </ul>
					</ul>
				   </li>
			   </ul>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script src="${contextPath}/resources/js/orgChart.js"></script>
</body>
</html>