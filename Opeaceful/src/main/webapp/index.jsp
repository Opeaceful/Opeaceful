<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import='com.company.opeaceful.member.model.vo.Member'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
	/* 테스트용 멤버 객체 -> 필요한 값 있으면 setter로 추가/변경하여 사용 */
	Member loginUser = new Member();
	loginUser.setEno(230502);
	loginUser.setStatusType(0);
	loginUser.setUserName("test");
	loginUser.setUserNo(2);
	
	session.setAttribute("loginUser", loginUser);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Opeaceful</title>
</head>
<body>
<!-- 
	* webapp 폴더 바로 하위에 존재하는 index.jsp 파일은 자동으로 welcome-file로 인식된다
		(WebContent아래 index.jsp와 동일함)
		
		현재 jsp페이지에서 다른jsp주소로 요청을 위임(forward)할 예정
 -->
	
	
	<jsp:forward page="login"/>

</body>
</html>