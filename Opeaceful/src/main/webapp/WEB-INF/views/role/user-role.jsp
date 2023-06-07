<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Opeaceful</title>
	<!-- bootstrap CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

  	<!--메인 공통 css-->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<!-- 페이지 css  -->
	<link rel="stylesheet" href="${path}/resources/css/role/user-role.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/sidebar.jsp" />
<c:if test="${ not empty alertMsg }">
	<script>
	swal("오류 발생",'${alertMsg}');
	</script>
	<c:remove var="alertMsg"/>
</c:if>
<c:set var="rl" value="${rl}"/>
<c:set var="m" value="${m}"/>
<c:set var="ur" value="${ur}"/>
<c:set var="dr" value="${dr}"/>


<div class="content-wrap">
	<div class="container">
	
		<!--제목-->
		<div class="title-box">
		    <h2 class="title-common">사원별 권한 부여</h2>
		</div>
		
		<br><br>
		
		<!--검색창 구역-->
		<div class="search-wrap2 input-group mb-3 ms-1">
		    <input type="text" class="search-input2 form-control box-shadow-none" placeholder="사원이름 입력">
		    <!--data-bs-target="#all-user-view" 조회할 구역에 data-target넣어주기-->
		    <button class="btn btn-outline-secondary search-btn2" type="button" data-bs-toggle="modal" data-bs-target="#all-user-view" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass"></i></button>
		</div>
		
		<div class="row">
		    <!--테이블 구역-->
		    <div class="col-md-8">
		        <table class="table table-hover table-common">
		            <thead>
		                <tr>
		                    <th scope="col">사원번호</th>
		                    <th scope="col">팀명</th>
		                    <th scope="col">직급</th>
		                    <th scope="col">사원명</th>
		                </tr>
		            </thead>
		            
		            <tbody class="table-group-divider">
		                <tr data-id=${m.getUserNo()}>
		                    <th scope="row">${m.getEno()}</th>
		                    <td>${m.getDName()}</td>
		                    <td>${m.getPName()}</td>
		                    <td>${m.getUserName()}</td>
		                </tr>        
		            </tbody>
		        </table>
		    </div>
		    
		    <div class="container col-md-4 user-wrap">
				<!--db세팅-->
				<div class="user-table" id="uesr-granting-table">
					<c:forEach items="${rl}" var="role">
				  		<div class="form-check form-switch">   
	                        <label class="form-check-label">${role.getRoleName()}</label>
	                        <input class="form-check-input" type="checkbox" role="switch" id="${role.getRoleCode()}">
	                    </div>	
					</c:forEach>
				</div>
			</div>
		
		</div>
    
    
	</div>
	


</div>
<jsp:include page="/WEB-INF/views/member/member-select.jsp"/>
<script type="module" src="${path}/resources/js/role/user-role.js"></script>
<c:if test="${!empty rl}">
	
	<c:if test="${!empty ur}">
		<c:forEach items="${ur}" var="ur">
			<script>
			document.getElementById("${ur.getRoleCode()}").checked = true;
			</script>
		</c:forEach>
	</c:if>
	
	<c:if test="${!empty dr}">
		<c:forEach items="${dr}" var="dr">
			<script>
				document.getElementById("${dr.getRoleCode()}").checked = true;
				document.getElementById("${dr.getRoleCode()}").disabled = true;
			</script>
		</c:forEach>
	</c:if>
	
</c:if>

<script>
	const uesrNo = ${m.getUserNo()}
</script>

</body>
</html>