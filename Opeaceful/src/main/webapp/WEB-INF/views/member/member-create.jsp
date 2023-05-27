<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- (윤지영) 멤버 생성페이지 : 사용자 생성 view  -->
	<title>Opeaceful</title>
	
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- 부트스트랩 아이콘 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
	<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
	 <!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/memberCreate.css">
	
</head>
<body calss="main">
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	
	<div class="content-wrap">
    <div class="user-wrap container">
        <!-- 제목 -->
        <h4 class="title-underline">사용자 생성</h4>
        <div class="container">
          
        
            <!-- 내용부분 -->
            <div class="user-table">

                <!-- 이름 -->
                <div class="mb-4 row">
                    <label for="input-name" class="col-sm-3 col-form-label">이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="mypage-input form-control box-shadow-put" id="user-name" value="" required>
                    </div>
                </div>

                <!-- 팀코드 / 직급 -->
                <div class="mb-4 row">
                
                    <label for="team-code-posiotion" class="col-sm-3 col-form-label ">팀코드 / 직급</label>
                    <div class="team-code col-sm-9 row">
                        <label for="team-code" class="col-sm-2 col-form-label input-font">팀코드</label>
                        <div class="col-sm-4">
                        <select class="form-select member-form-select  form-select-sm" required>
                            <option value="" disabled selected>팀명</option>
                            <option value="경영1팀">경영1팀</option>
                            <option value="2">경영2팀</option>
                            <option value="3">....</option>
                        </select>
                        </div>
                        <label for="team-position" class="col-sm-2 col-form-label input-font">직급</label>
                        <div class="col-sm-4">
                        <select class="form-select member-form-select form-select-sm ">
                            <option value="" disabled selected>직급</option>
                            <option value="1">경영1팀</option>
                            <option value="2">경영2팀</option>
                            <option value="3">....</option>
                        </select>
                        </div>

                    </div>
                </div>

                <!-- 비밀번호 넣을까/말까..-->
                <div class="mb-4 row">
                    <label for="input-Password" class="col-sm-3 col-form-label">비밀번호</label>
                    <div class="col-sm-9">
                        <input type="password"  class="form-control-plaintext" id="user-password" value="1234">
                    </div>
                </div>

                <!-- 연락처 -->
                <div class="row mb-4">
                    <label for="input-phone" class="col-sm-3 col-form-label">연락처</label>
                    <div class="col-sm-9">
                        <input type="tel" id="user-pnohe" class="mypage-input form-control box-shadow-put" required pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13">
                    </div>
                </div>

                <!-- 주소 -->
                <div class="row mb-4">
                    <label for="input-address" class="col-sm-3 col-form-label">주소</label>
                    <div class="col-sm-9">
                        <div class="input-group">
                        <input type="text" id="user-address" class="mypage-input form-control box-shadow-put" required readonly>
                        <button class="btn btn-outline-secondary seach-btn" type="button" id="seach-address">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                        
                        </div>
                        <input type="text" id="user-address-dtail" class="mypage-input form-control box-shadow-put" required>
                    </div>
                </div>

                <!-- 이메일 -->
                <div class="row mb-4">
                    <label for="input-email" class="col-sm-3 col-form-label">이메일</label>
                    <div class="col-sm-9">
                        <input type="email" id="user-email" class="mypage-input form-control box-shadow-put" required>
                    </div>
                </div>

                <!--내선번호와 입사일은 선택-->
                <!-- 내선번호 -->
                <div class="row mb-4">
                    <label for="input-call" class="col-sm-3 col-form-label">내선번호</label>
                    <div class="col-sm-9">
                        <input type="tel" id="user-call" class="mypage-input form-control box-shadow-put" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13">
                    </div>
                </div>

                <!-- 입사일 : 미선택시 오늘날짜 -->
                <div class="mb-4 row">
                    <label for="join-date" class="col-sm-3 col-form-label">입사일</label>
                    <div class="col-sm-9">
                        <input type="date"  class="form-control-plaintext" id="join-date">
                    </div>
                </div>

            </div>

            <div class="user-btn-wrap d-flex justify-content-center">
                <button type="button" class="btn btn-primary ms-1 user-btn">생성</button>
            </div>
          
     
        </div>

    </div>

</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path}/resources/js/addressAPI.js"></script>
<script src="${path}/resources/js/memberCreate.js"></script>

</body>
</html>