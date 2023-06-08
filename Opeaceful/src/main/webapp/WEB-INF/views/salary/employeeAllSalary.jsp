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
	<link rel="stylesheet" href="${path}/resources/css/salary/salaryAll.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/sidebar.jsp" />
<c:set var="LSalry" value="${LSalry}"/>
<div class="content-wrap">
 <!--제목-->
  <div class="container">

    <div class="title-box">
      <h2 class="title-common">사원별 급여 관리</h2>
    </div>

    <br><br>

 
    <!--부서/년도/월/이름 검색 구역-->
    <div class="d-inline-flex">
		<select class="form-select form-select-sm mb-3" id="d-select" name="deptCode">
			<option value="" selected>부서명</option>
		</select>
		
		<select class="form-select form-select-sm mb-3 ms-1" id="salary-year" name="year">
		</select>
		<select class="form-select form-select-sm mb-3 ms-1" id="salary-month" name="month">
			<option value="13">전체</option>
		</select>
		<div class="search-wrap2 input-group mb-3 ms-1">
		    <input type="text" class="search-input2 form-control box-shadow-none" id="member-search-keyword" placeholder="사원이름 입력">
		    <button class="btn btn-outline-secondary search-btn2" type="button" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass"></i></button>
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
      <tbody class="table-group-divider">
        <c:forEach items="${LSalry}" var="salry">
	        <tr data-id=${salry.getSalaryNo()}>
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
          <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          <li class="page-item"><a class="page-link" href="#">1</a></li>
          <li class="page-item"><a class="page-link" href="#">2</a></li>
          <li class="page-item"><a class="page-link" href="#">3</a></li>
          <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>

    <div class="text-right">
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#salaryModal">추가</button>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="salaryModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="container">
              
              <div class="salary-btn">        
                <button type="button" class="btn"> <i class="bi bi-box-arrow-in-down"></i></button>
                <button type="button" class="btn"> <i class="bi bi-printer"></i></button>
              </div>

              <h1 class="text-center">2023-3월 급여명세서</h1>

              <br>
              <div class="row f-detween">
                
                  <div class="hstack gap-3">
                    <div><b>직원명 :  </b> 윤지영 </div> 
                    <div><b>부서 : </b> 영업부 </div> 
                    <div><b>직급 : </b> 사원 </div> 
                  </div>
                  <div><b>지급일 : </b> 2023-05-01</div>
              </div>

              <br><br>

              <div class="row text-center">
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
                    <tbody>
                      <tr>
                        <td>기본급</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>수당</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>추가수당</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>주휴수당</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                     
                    </tbody>
                  </table>
               
                  <button type="button" class="btn" onclick="addTable('salary-table')">
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
                    <tbody>
                      <tr>
                        <td>소득세</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>국민연금</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>의료보험</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                      <tr>
                        <td>의료보험</td>
                        <td><input type="number" class="form-control" id="" value="" required></td>
                        <td><button class="btn btn-danger" onclick="deleteTable(this)"><i class="fa-solid fa-minus"></i></button></td>
                      </tr>
                     
                    </tbody>
                  </table>
                
                  <button type="button" class="btn" onclick="addTable('deduction-table')">
                    <i class="fa-solid fa-plus"></i>
                  </button>
                </div>
              </div>
          
            </div>

          </div>

          <div class="modal-footer">
            
            <div class="row text-center">
                <div class="col-md-3">지급액 계</div>
                <div class="col-md-3">3,000,000</div>
                <div class="col-md-3">공제 계</div>
                <div class="col-md-3">300,000</div>
            </div>

  
            <div class="row t-margin ">
              <div class="col-md-12 t-flex"><b>실지급액 : </b>자동계산</div>
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