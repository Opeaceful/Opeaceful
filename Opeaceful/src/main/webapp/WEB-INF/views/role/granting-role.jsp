<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

  	<!--메인 공통 css-->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<!-- 페이지 css  -->
	<link rel="stylesheet" href="${path}/resources/css/role/granting.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/sidebar.jsp" />

<div class="content-wrap">
	<div class="container">
	  
	    <div class="title-box">
	      <h2 class="title-common">권한 부여</h2>
	    </div>
	    <br><br><br>
	    <!--부서명-->
	    <div class="row">
			<div class="accordion col-md-8" id="role-accordion">
				
			</div>	
			<!-- 권리체크부분 -->
			<div class="container col-md-4 user-wrap">
				<!--db세팅-->
				<div class="user-table" id="granting-table">
			
				</div>
			</div>
	    </div>
	</div>
</div>
<script  type="module" src="${path}/resources/js/role/granting.js"></script>
</body>
</html>