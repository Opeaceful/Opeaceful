<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<title>Opeaceful</title>
<style>
	.error-wrap{
		margin-top: 400px;
	}
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
		<div class="error-wrap" align="center">
			<img src="https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678069-sign-error-64.png">		
			<br><br>
			<h1 style="font-weight:bold;">${errorMsg}</h1>
		</div>
	</div>
</body>
</html>