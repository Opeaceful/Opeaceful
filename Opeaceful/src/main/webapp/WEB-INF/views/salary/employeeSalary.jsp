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
	<link rel="stylesheet" href="${path}/resources/css/salary/employeeSalary.css">
	
</head>
<body>
<jsp:include page="/WEB-INF/views/sidebar.jsp" />
<c:set var="LSalry" value="${LSalry}"/>
<div class="content-wrap">
 	<div class="container">
	    <div class="title-box print-none">
	      <h2 class="title-common">급여명세서</h2>
	  	</div>
	  	<br><br>

  <!--년도/월 검색 구역-->

  <div class="d-inline-flex print-none">
    <select class="form-select form-select-sm print-none" id="salary-year" name="year">
    </select>
    <select class="form-select form-select-sm ms-1 print-none" id="salary-month" name="month">
      <option value="13">전체</option>
    </select>
  </div> 

    <!--테이블 구역-->
    <table class="table table-hover table-common print-none">
        <thead>
          <tr>
            <th scope="col">급여년월</th>
            <th scope="col">지급일자</th>
            <th scope="col">지급금액</th>
            <th scope="col">공제금액</th>
            <th scope="col">실지급액</th>
          </tr>
        </thead>
        
        <tbody class="table-group-divider" id="em-salary-table">
      
        <c:forEach items="${LSalry}" var="salry">
	        <tr data-id=${salry.getSalaryNo()}>
	            <th scope="row">${salry.getYearReported()}-${salry.getMonReported()}</th>
	            <td>${salry.getPaymentDate()}</td>
	            <td>${salry.getTotalGrosspay()}</td>
	            <td>${salry.getTotalDeductions()}</td>
	            <td>${salry.getNetPay()}</td>
	        </tr>
		</c:forEach>         
    </tbody>
        
    </table>
  

<!-- Modal -->
<div class="modal fade" id="salary-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container">
          <div>
          <div class="salary-btn print-none">        
            
          <button type="button" class="btn"> <i class="bi bi-box-arrow-in-down"></i></button>
          <button type="button" class="btn" id="print-button"> <i class="bi bi-printer"></i></button>
          </div>

          <h1 class="text-center">${LSalry[i].getPaymentDate()}</h1>
        </div>
          <br>
          <div class="row f-nowrap">
           
              <div class="hstack gap-3">
                <div><b>직원명 :  </b> ${loginUser.getUserName()} </div> 
                <div><b>부서 : </b> ${loginUser.getDName()} </div> 
                <div><b>직급 : </b> ${loginUser.getPName()} </div> 
              </div>
              <div id="payDay"></div>
          </div>

          <br><br>
          <div class="row text-center">
              <div class="col-md-6">
                <div class="salary-title">급여내역</div>
                <table class="table">
                  <thead>
                    <tr>
                      <th>항목</th>
                      <th>금액</th>
                    </tr>
                  </thead>
                  <tbody id="tbody-salary-payment">
                    
                  </tbody>
                </table>
              </div>
        
              <div class="col-md-6">
                <div class="salary-title">공제내역</div>
                <table class="table">
                  <thead>
                    <tr>
                      <th>항목</th>
                      <th>금액</th>
                    </tr>
                  </thead>
                  <tbody id="tbody-salary-deduction">
                   
                  </tbody>
                </table>
              </div>
            </div>          
        </div>


      </div>
      <div class="modal-footer" id="footer-salary-payment">
       
      </div>
    </div>
  </div>
</div>

    </div>
    
    
</div>
<script type="module" src="${path}/resources/js/salary/dateBox.js"></script>	
<script type="module" src="${path}/resources/js/salary/employeeSalary.js"></script>	
</body>
</html>