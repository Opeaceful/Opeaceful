<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<link rel="stylesheet" href="${path}/resources/css/salary/salaryAll.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/sidebar.jsp" />
<c:set var="LSalry" value="${LSalry}"/>
<c:set var="dpNames" value="${dpNames}"/>
<c:set var="pi" value="${map.pi}"/>
<c:if test="${empty map.no}">
	<c:set var="url" value="AllSalary?year=${map.year}&month=${map.month}&team=${map.team}&cpage="/>
</c:if>
<c:if test="${not empty map.no}">
	<c:set var="url" value="AllSalary?year=${map.year}&month=${map.month}&no=${fn:join(map.no,',')}&cpage="/>
</c:if>

<c:if test="${ not empty alertMsg }">
	<script>
	swal('${alertMsg}');
	</script>
	<c:remove var="alertMsg"/>
</c:if>
<div class="content-wrap">
 <!--제목-->
  <div class="container">

    <div class="title-box">
      <h2 class="title-common">사원별 급여 관리</h2>
    </div>

    <br><br>

 
    <!--부서/년도/월/이름 검색 구역-->
    <div class="d-inline-flex">
		<select class="form-select form-select-sm mb-3" id="dpSelect">
			<option value="">부서명</option>
			 <c:forEach items="${dpNames}" var="dpName">
			 	<c:choose> 
					<c:when test="${map.team} == null">
						<option value="">${dpName}</option>
					</c:when>
					<c:when test="${map.team == dpName}">
						<option value="" selected>${dpName}</option>
					</c:when>  
					<c:otherwise> 
						<option value="">${dpName}</option>
					</c:otherwise> 
				</c:choose> 
			</c:forEach>      
		</select>
		
		<select class="form-select form-select-sm mb-3 ms-1" id="salary-year" name="year">
		</select>
		<select class="form-select form-select-sm mb-3 ms-1" id="salary-month" name="month">
			<option value="13">전체</option>
		</select>
		<div class="search-wrap2 input-group mb-3 ms-1">
		    <input type="text" class="search-input2 form-control box-shadow-none" id="member-search-keyword" placeholder="사원이름 입력">
        <button type="button" class="btn btn-outline-secondary search-btn2" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass" data-bs-toggle="modal" data-bs-target="#all-user-view"></i></button>
		</div>
 	</div>
  

    <!--테이블 구역-->
    <table class="table table-hover table-common">
      <thead>
        <tr>
          <th scope="col">사원번호</th>
          <th scope="col">이름</th>
          <th scope="col">급여년월</th>
          <th scope="col">지급일자</th>
          <th scope="col">지급금액</th>
          <th scope="col">공제금액</th>
          <th scope="col">실지급액</th>
        </tr>
      </thead>
      <tbody class="table-group-divider" id="Am-salary-table">
        <c:forEach items="${LSalry}" var="salry">
	        <tr data-id="${salry.getSalaryNo()},${salry.getUserName()}">
		        <td>${salry.getEno()}</td>
		        <td>${salry.getUserName()}</td>
	            <th scope="row">${salry.getYearReported()}-${salry.getMonReported()}</th>
	            <td>${salry.getPaymentDate()}</td>
	            <td>${salry.getTotalGrosspay()}</td>
	            <td>${salry.getTotalDeductions()}</td>
	            <td>${salry.getNetPay()}</td>
	        </tr>
		</c:forEach>      
        
      </tbody>
    </table>
  
    <div class="pagingArea">
      <nav aria-label="Page navigation example">
        <ul class="pagination">
        <c:choose>
			         <c:when test="${ pi.currentPage eq 1 }">
			            <li class="page-item disabled"><a class="page-link" href="#"><span aria-hidden="true">&laquo;</span></a></li>
			         </c:when>
			         <c:otherwise>
			            <li class="page-item"><a class="page-link" href="${url}${pi.currentPage -1}"><span aria-hidden="true">&laquo;</span></a></li>
			         </c:otherwise>               
			      </c:choose>
			      
			      <c:forEach var="item" begin="${pi.startPage }" end="${pi.endPage}">
			         <li class="page-item"><a class="page-link" href="${url}${item}" id="CP${item}">${item }</a></li>
			      </c:forEach>
			      
			      <c:choose>
			         <c:when test="${ pi.currentPage eq pi.maxPage }">
			            <li class="page-item disabled"><a class="page-link" href="#"> <span aria-hidden="true">&raquo;</span></a></li>
			         </c:when>
			         <c:otherwise>
			            <li class="page-item"><a class="page-link" href="${url}${pi.currentPage + 1 }"><span aria-hidden="true">&raquo;</span></a></li>
			         </c:otherwise>               
			      </c:choose>
        </ul>
      </nav>
    </div>
   		      
			 

    <div class="text-right">
      <button type="button" class="btn btn-primary" id="saray-button-add">추가</button>
    </div>


    <!-- Modal : 수정+신규등록용 -->
    <div class="modal fade" id="salaryModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body scroll-bar">
            <div class="container">
              
              <div class="salary-btn">        
                 <button type="button" class="btn btn-primary ms-1 ok-common " id="salary-update">수정</button>
        	       <button type="button" class="btn btn-danger  ms-1 cancel-common" value=0 id="salary-delete">삭제</button>
              </div>

              <h1 class="text-center" id="salaryModalTitle"></h1>

              <br>
              <div class="row f-detween" id="salryUserData">
                
                 
                   
              </div>

              <br><br>

              <form class="row text-center" id="table-form-salary">
                <div class="col-md-6">
                  <div class="salary-title">급여내역</div>
                  <table class="table" id="salary-table">
                    <thead>
                      <tr>
                        <th>항목</th>
                        <th>금액</th>
                        <th></th>
                      </tr>
                    </thead>
                  
                    <tbody id="salary-table-pay">
                     
                    </tbody>
                  </table>
               
                  <button type="button" class="btn" id="salary-table-btn" >
                    <i class="fa-solid fa-plus"></i>
                  </button>
                </div>
          
                <div class="col-md-6">
                  <div class="salary-title">공제내역</div>
                  <table class="table" id="deduction-table">
                    <thead>
                      <tr>
                        <th>항목</th>
                        <th>금액</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody id="salary-table-deduction">
                      
                    </tbody>
                  </table>
                
                  <button type="button" class="btn" id="deduction-table-btn">
                    <i class="fa-solid fa-plus"></i>
                  </button>
                </div>
              </form>
          
            </div>

          </div>

          <div class="modal-footer">
            
            <div class="row text-center">
                <div class="col-md-3">지급액 계</div>
                <div class="col-md-3" id="total-salary"></div>
                <div class="col-md-3">공제 계</div>
                <div class="col-md-3" id="total-Deductions"></div>
            </div>

  
            <div class="row t-margin ">
              <div class="col-md-12 t-flex" id="net-salary"></div>
            </div> 
          </div>

        </div>
      </div>
    </div>

  </div>
    
</div>



<jsp:include page="/WEB-INF/views/member/member-select.jsp"/>
<script type="module" src="${path}/resources/js/common/dtcodeselect.js"></script>
<script type="module" src="${path}/resources/js/salary/dateBox.js"></script>	
<script type="module" src="${path}/resources/js/salary/salaryAll.js"></script>	
</body>
</html>