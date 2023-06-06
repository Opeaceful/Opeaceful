<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- (윤지영) 멤버 생성페이지 : 사용자 생성 view  -->
	<title>Opeaceful</title>
	
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/memberCreate.css">
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	
	<c:if test="${ not empty alertMsg }">
		<script>
		swal("오류 발생",'${alertMsg}' );
		</script>
		<c:remove var="alertMsg"/>
	</c:if>
	<c:if test="${ not empty userEno }">
		<script>
		swal('${userEno}');
		</script>
		<c:remove var="userEno"/>
	</c:if>
	
	<div class="content-wrap">
    <div class="user-wrap container">
        <!-- 제목 -->
        <h4 class="title-underline">사용자 생성</h4>
        <div class="container">
          
        
            
            <!-- 내용부분 -->
            <form action="insert" method="post" class="user-table">

                <!-- 이름 -->
                <div class="mb-4 row">
                    <label for="input-name" class="col-sm-3 col-form-label">이름 *</label>
                    <div class="col-sm-9">
                        <input type="text" class="mypage-input form-control box-shadow-put" id="user-name"  name="userName" required>
                    </div>
                </div>

                <!-- 팀코드 / 직급 -->
                <div class="mb-4 row">
                
                    <label for="team-code-posiotion" class="col-sm-3 col-form-label ">팀코드 / 직급 *</label>
                    <div class="team-code col-sm-9 row">
                        <label for="team-code" class="col-sm-2 col-form-label input-font">팀코드</label>
                        <div class="col-sm-4">
                        <select class="form-select member-form-select  form-select-sm" id="d-select" name="deptCode" required>
                            <option value="" disabled selected>부서명</option>
                            
                        </select>
                        </div>
                        <label for="team-position" class="col-sm-2 col-form-label input-font">직급 </label>
                        <div class="col-sm-4">
                        <select class="form-select member-form-select form-select-sm " id="p-select" name="pCode" required>
                            <option value="" disabled selected>직급</option>
                        </select>
                        </div>

                    </div>
                </div>

                <!-- 비밀번호 넣을까/말까..-->
                <div class="mb-4 row">
                    <label for="input-Password" class="col-sm-3 col-form-label">비밀번호 *</label>
                    <div class="col-sm-9">
                        <input type="password" name="userPwd"  class="form-control-plaintext" id="user-password" value="1234">
                    </div>
                </div>

                <!-- 연락처 -->
                <div class="row mb-4">
                    <label for="input-phone" class="col-sm-3 col-form-label">연락처 *</label>
                    <div class="col-sm-9">
                        <input type="tel" id="user-pnohe" name="phone" class="mypage-input form-control box-shadow-put" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" maxlength="13" >
                    </div>
                </div>

                <!-- 주소 -->
                <div class="row mb-4">
                    <label for="input-address" class="col-sm-3 col-form-label">주소 *</label>
                    <div class="col-sm-9">
                        <div class="input-group">
                        <input type="text" id="user-address"  name="address" class="mypage-input form-control box-shadow-put" required readonly placeholder="도로명주소" >
                        <button class="btn btn-outline-secondary seach-btn" type="button" id="seach-address">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                        
                        </div>
                        <input type="text" id="user-address-dtail" name="address" class="mypage-input form-control box-shadow-put" required placeholder="상세주소" >
                    </div>
                </div>

                <!-- 이메일 -->
                <div class="row mb-4">
                    <label for="input-email" class="col-sm-3 col-form-label">이메일 *</label>
                    <div class="col-sm-9">
                        <input type="email" id="user-email" class="mypage-input form-control box-shadow-put" name="email" required>
                    </div>
                </div>

                <!--내선번호와 입사일은 선택-->
                <!-- 내선번호 -->
                <div class="row mb-4">
                    <label for="input-call" class="col-sm-3 col-form-label">내선번호</label>
                    <div class="col-sm-9">
                        <input type="tel" id="user-call" class="mypage-input form-control box-shadow-put" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" name="extension">
                    </div>
                </div>

                <!-- 입사일 : 미선택시 오늘날짜 -->
                <div class="mb-4 row">
                    <label for="join-date" class="col-sm-3 col-form-label">입사일</label>
                    <div class="col-sm-9">
                        <input type="date"  class="form-control-plaintext" id="join-date" name="hireDate">
                    </div>
                </div>


                <div class="user-btn-wrap d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary ms-1 user-btn">생성</button>
                </div>
            </form>

            
          
     
        </div>

    </div>

</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path}/resources/js/addressAPI.js"></script>
<script src="${path}/resources/js/memberCreate.js"></script>
<script type="module" src="${path}/resources/js/dtcodeselect.js"></script>

</body>
</html>