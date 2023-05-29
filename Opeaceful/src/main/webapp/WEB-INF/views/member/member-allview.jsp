<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- (윤지영) 멤버 전체 조회 : 사용자 조회 view  -->
<title>Opeaceful</title>
	
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- 부트스트랩 아이콘 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
	<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
	 <!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  <!--메인 공통 css-->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/memberAllview.css">


</head>
<body>
  <jsp:include page="/WEB-INF/views/sidebar.jsp" />

	<div class="content-wrap">
	 	<div class="container">
	      <div class="title-box">
	        <h2 class="title-common">사용자 조회</h2>
	      </div>
	
	    <br><br>
	    <!--검색창 구역-->
	    <div class="d-inline-flex">
        <select class="form-select form-select-sm " id="d-select" name="deptCode" >
          <option value="" disabled selected>부서명</option>
      
        </select>
        <select class="form-select form-select-sm ms-1" id="p-select" name="pCode">
            <option value="" disabled selected>직급</option>
        </select>
        <div class="search-wrap">
          <input type="search" name="keyword" class="search-box">
          <button type="button" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
        </div>
        </div>

	  	<!--테이블 구역-->
        <table class="table table-hover table-common">
            <!--하드코딩. 실제로는 db로 불러올 예정!!-->
            <thead>
                <tr>
                  <th scope="col">사번</th>
                  <th scope="col">이름</th>
                  <th scope="col">이메일</th>
                  <th scope="col">내선번호</th>
                  <th scope="col">연락처</th>
                  <th scope="col">비밀번호</th>
                  <th scope="col">부서</th>
                  <th scope="col">직급</th>
                  <th scope="col">입사일</th>
                  <th scope="col">퇴사일</th>
                  <th scope="col">연차</th>
                  <th scope="col">주소</th>
                </tr>
             </thead>
           
             <tbody class="table-group-divider" id="member-table-body">
          	 </tbody>
           
        </table>
      
      
    </div>
  </div>
  
<script type="module" src="${path}/resources/js/dtcodeselect.js"></script>
<script type="module" src="${path}/resources/js/memberAllview.js"></script>
</body>
</html>