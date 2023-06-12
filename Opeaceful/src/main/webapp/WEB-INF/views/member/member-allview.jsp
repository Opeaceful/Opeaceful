<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Opeaceful</title>

	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

  	<!--메인 공통 css-->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/memberAllview.css">


</head>
<body>
  <jsp:include page="/WEB-INF/views/sidebar.jsp" />
  
	<c:if test="${ not empty alertMsg }">
		<script>
		swal("오류 발생",'${alertMsg}' );
		</script>
		<c:remove var="alertMsg"/>
	</c:if>
	 <c:if test="${ not empty success }">
		<script>
		swal("성공",'${success}' );
		</script>
		<c:remove var="success"/>
	</c:if>
	
	 <c:forEach items="${loginUserRole}" var="role">
	 
	 	
	 
	 </c:forEach>
	

	<div class="content-wrap">
	 	<div class="container">
	      <div class="title-box">
	        <h2 class="title-common">사용자 조회</h2>
	      </div>
	
	    <br><br>
	    <!--검색창 구역-->
	    <div class="d-inline-flex">
        <select class="form-select form-select-sm " id="d-select" name="deptCode" >
          <option value="" selected>부서명</option>
      
        </select>
        <select class="form-select form-select-sm ms-1" id="p-select" name="pCode">
            <option value="" selected>직급</option>
        </select>
        <div class="search-wrap">
          <input type="search" name="keyword" class="search-box" id="member-search-keyword">
          <button type="button" class="search-btn" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass" data-bs-toggle="modal" data-bs-target="#all-user-view"></i></button>
        </div>
        <div class="ms-2">
          <input class="form-check-input" type="checkbox" value="N" id="S-select">
          <label class="form-check-label" for="">
             퇴사자
          </label>
        </div>
        </div>

	  	<!--테이블 구역-->
        <table class="table table-hover table-common">
            <thead>
                <tr>
                  <th scope="col">사번</th>
                  <th scope="col">이름</th>
                  <th scope="col">이메일</th>
                  <th scope="col">내선번호</th>
                  <th scope="col">연락처</th>
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

        <br><br><br>
        <div class="pagingArea">
          <nav>
            <ul class="pagination" id="member-pagination">
            </ul>
          </nav>
        </div>
      
    </div>
  </div>

<!-- Modal -->
<div class="modal fade" id="memberUpdateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="memberUpdatLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" >사용자 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="member-btn-close"></button>
      </div>
      <div class="modal-body" id="member-update-modal" >
       
        <form id="member-update-form" action="${path}/member/updateAllmember" method="post">
	          <div class="row mb-3">
	            <label for="inputUserName" class="col-sm-2 col-form-label">이름 *</label>
	            <div class="col-sm-9">
	            <input type="text" class="form-control" name="userName" required>
	            </div>
	         </div>
	        <div class="row mb-3">
	            <label for="inputemail" class="col-sm-2 col-form-label">이메일 *</label>
	            <div class="col-sm-9">
	            <input type="email" class="form-control"  name="email" required>
	            </div>
	        </div>
	        <div class="row mb-3">
	            <label for="inputextension" class="col-sm-2 col-form-label">내선번호</label>
	            <div class="col-sm-9">
	            <input type="tel" class="form-control"  name="extension" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" id="user-call">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <label for="inputphone" class="col-sm-2 col-form-label" >연락처 *</label>
	            <div class="col-sm-9">
	            <input type="tel" class="form-control" name="phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" maxlength="13" required id="user-pnohe">
	            </div>
	        </div>  
	        <div class="row mb-3">
	        <label for="inputdName" class="col-sm-2 col-form-label">부서 *</label>
	            <div class="col-sm-9">
	                <select class="form-select member-form-select form-select-sm" name="deptCode" id="deptCodeSelect" required >
	                </select>
	            </div>
	        </div>
	        <div class="row mb-3">
	        <label for="inputpName" class="col-sm-2 col-form-label">직급 *</label>
	            <div class="col-sm-9">
	                <select class="form-select member-form-select  form-select-sm" name="pCode" id="pCodeSelect" required>
	                </select>
	            </div>
	        </div>
	        <div class="row mb-3">
	            <label for="inputhireDate" class="col-sm-2 col-form-label">입사일 *</label>
	            <div class="col-sm-3">
	                <input type="date" id="join-date" class="form-control"  name="hireDate" required>
	            </div>
	            <label for="inputresignedDate" id="leave-date-lable" class="col-sm-2 col-form-label">퇴사일</label>
	            <div class="col-sm-3">
	                <input type="date" id="leave-date" class="form-control" name="resignedDate">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <label for="inputannualLeaveCount" class="col-sm-2 col-form-label">연차</label>
	            <div class="col-sm-9">
	                <input type="number" class="form-control" value="" name="annualLeaveCount">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <label for="inputAddress" class="col-sm-2 col-form-label">주소 *</label>
	            <div class="col-sm-9">
	            <div class="input-group">
	                <input type="text" id="user-address"  name="address" class="mypage-input form-control box-shadow-put" required readonly placeholder="도로명주소" required>
	                <button class="btn btn-outline-secondary seach-btn" type="button" id="seach-address">
	                    <i class="fa-solid fa-magnifying-glass"></i>
	                </button>
	                
	                </div>
	                <input type="text" id="user-address-dtail" name="address" class="mypage-input form-control box-shadow-put" placeholder="상세주소" >
	            </div>
	        </div>
	
	     
        </form>
		<div class="modal-footer row ">    
			<div class="col mgpd-0">
			<button type="button" class="btn btn-warning " id="password-reset-button">비밀번호 초기화</button>
			</div>
		   

		   <div class="col text-end">
		   <button type="submit" class="btn btn-primary ms-1 ok-common" id="form-sumit">확인</button>
		   </div>
	  	</div>

      </div>
	 
      
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/member/member-select.jsp" />
 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="module" src="${path}/resources/js/common/dtcodeselect.js"></script>
<script type="module" src="${path}/resources/js/memberAllview.js"></script>
<script src="${path}/resources/js/common/addressAPI.js"></script>


</body>
</html>