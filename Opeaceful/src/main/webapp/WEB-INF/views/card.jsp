<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="../../resources/css/common/common.css">
<link rel="stylesheet" href="../../resources/css/card.css">
</head>
<body>

	<div id="content-wrap">
		<div class="container">
			<div class="card-container shadow p-3 mb-5 bg-body rounded">
				<div class="user-profileImg">
					<img src="../../resources/image/mypage/basic_profile.png" class="rounded float-start text-xl-start" alt="...">
				</div>
				<table class="table card-table">
					  <tr>
						<td scope="row">이름</td>
						<td>박가영 사원</td>
					  </tr>
					  <tr>
						<td scope="row">조직</td>
						<td>경영지원본부 인사팀</td>
					  </tr>
					  <tr>
						<td scope="row">이메일</td>
						<td>opeaceful@gamil.com</td>
					  </tr>
					  <tr>
						<td scope="row">연락처</td>
						<td>010-1234-5678</td>
					  </tr>
					  <tr>
						<td scope="row">내선번호</td>
						<td>02-123-456</td>
					  </tr>
				  </table>
			</div>
		</div>
	</div>
	<script src="${path}/resources/js/card.js"></script>
</body>
</html>