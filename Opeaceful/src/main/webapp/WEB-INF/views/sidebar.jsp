<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<link rel="stylesheet" href="${path}/resources/css/common/sidebar.css">
</head>
<body>

	<!-- 
		a 태그에 각자 페이지 넣어주기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 -->
	
    <div class="sidebar">
        <div class="sidebar-icon sidebar-logo">
            <i class="fa-solid fa-feather"></i>
        </div>
        <div class="sidebar-wrap">
            <ul>
                <!-- 메인 -->
                <li id="sidebar-home">

					<a href="${path}/main">
                        <i class="sidebar-icon fa-solid fa-house"></i>
                        <span class="sidebar-text">홈</span>
                    </a>
                </li>

                <!-- 조직도 -->
                <li id="sidebar-chart">
                    <div class="one-line sidebar-cursor" id="chart-menu">
                        <i class="sidebar-icon bi bi-diagram-3"></i>
                        <span class="sidebar-text">조직도</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="chart-menu-item">
                        <a class="sidebar-more-text" href="">조직도 등록</a>
                        <a class="sidebar-more-text" href="">조직도 현황</a>
                    </div>
                </li>

                <!-- 메일 -->
                <li id="sidebar-mail">
                    <a href="">
                        <i class="sidebar-icon fa-solid fa-envelope"></i>
                        <span class="sidebar-text">메일</span>
                    </a>
                </li>

                <!-- 게시판 -->
                <li id="sidebar-board">
                    <div class="one-line sidebar-cursor" id="board-menu">
                        <i class="sidebar-icon bi bi-file-text"></i>
                        <span class="sidebar-text">게시판</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="board-menu-item">
                        <a class="sidebar-more-text" href="">공지사항</a>
                        <a class="sidebar-more-text" href="">팀게시판</a>
                        <a class="sidebar-more-text" href="">자유게시판</a>
                    </div>
                </li>

                <!-- 캘린더 -->
                <li id="sidebar-calender">
                    <a href="">
                        <i class="sidebar-icon bi bi-calendar-date"></i>
                        <span class="sidebar-text">캘린더</span>
                    </a>
                </li>

                <!-- 전자결재 -->
                <li id="sidebar-sign">
                    <a href="">
                        <i class="sidebar-icon bi bi-briefcase-fill"></i>
                        <span class="sidebar-text">전자결재</span>
                    </a>
                </li>

                <!-- 근태 -->
                <li id="sidebar-work">
                    <a href="">
                        <i class="sidebar-icon fa-solid fa-clock"></i>
                        <span class="sidebar-text">근태</span>
                    </a>
                </li>

                <!-- 연차관리 -->
                <li id="sidebar-annual">
                    <div class="one-line sidebar-cursor" id="annual-menu">
                        <i class="sidebar-icon fa-solid fa-umbrella-beach"></i>
                        <span class="sidebar-text">연차관리</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i> 
                    </div>

                    <div class="sidebar-more" id="annual-menu-item">
                        <a class="sidebar-more-text" href="${path}/annual/setting">총연차관리</a>
                        <a class="sidebar-more-text" href="${path}/annual/list">연차조회</a>
                    </div>
                </li>

                <!-- 계정관리 -->
                <li id="sidebar-account">
                    <div class="one-line sidebar-cursor" id="account-menu">
                        <i class="sidebar-icon fa-solid fa-user-plus"></i>
                        <span class="sidebar-text">계정관리</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i>
                    </div>

                    <div class="sidebar-more" id="account-menu-item">
                        <a class="sidebar-more-text" href="">사용자 조회</a>
                        <a class="sidebar-more-text" href="${path}/member/create">사용자 등록</a>
                    </div>
                </li>

                <!-- 권한관리 -->
                <li id="sidebar-role">
                    <div class="one-line sidebar-cursor" id="role-menu">
                        <i class="sidebar-icon fa-solid fa-user-gear"></i>
                        <span class="sidebar-text">권한관리</span>
                        <i class="sidebar-icon-arrow fa-solid fa-angle-down"></i>
                    </div>

                    <div class="sidebar-more" id="role-menu-item">
                        <a class="sidebar-more-text" href="">권한 등록</a>
                        <a class="sidebar-more-text" href="">사원별 권한 등록</a>
                    </div>
                </li>
            </ul>
        </div>

        <div class="sidebar-wrap sidebar-bottom">
            <ul>
                <!-- 마이페이지 -->
                <li id="sidebar-info">
                    <a href="${path}/member/mypage">
                        <i class="sidebar-icon bi bi-person-circle"></i>
                        <span class="sidebar-text">마이페이지</span>
                    </a>
                </li>
                <!-- 로그아웃 -->
                <li id="sidebar-logout">
                    <a href="${path}/member/logout">
                        <i class="sidebar-icon fa-solid fa-power-off"></i>
                        <span class="sidebar-text">로그아웃</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 채팅아이콘 -->
    <div id="chat-icon" >
		<i class="bi bi-chat"></i>
    </div>


        
    <script>
        $(".sidebar-more").css("display", "none");

        // $(document).ready(function () {
        $("#chart-menu").click(function () {
            $("#chart-menu-item").slideToggle();
        });
        // });
        $("#board-menu").click(function () {
            $("#board-menu-item").slideToggle();
        });
        $("#annual-menu").click(function () {
            $("#annual-menu-item").slideToggle();
        });
        $("#account-menu").click(function () {
            $("#account-menu-item").slideToggle();
        });
        $("#role-menu").click(function () {
            $("#role-menu-item").slideToggle();
        });
    </script>
</body>
</html>