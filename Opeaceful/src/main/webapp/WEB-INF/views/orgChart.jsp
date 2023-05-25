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
	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">조직도</h2>
			</div>
			<div class="tree">
				<ul>
					<li>
						Grand Child
						<ul>
							<li>
								<div class="row" style="border: 1px solid lightgray;">
									<div class="col-9" style="border-bottom: 1px solid lightgray;">인사팀</div>
									<div class="col-4" style="border-right: 1px solid lightgray;">정팀장</div>
									<div class="col-5">팀장</div>
								  </div>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
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