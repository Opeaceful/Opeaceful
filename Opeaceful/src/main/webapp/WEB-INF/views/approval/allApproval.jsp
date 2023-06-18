<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.time.LocalDate , java.util.ArrayList, com.company.opeaceful.approval.model.vo.Approval"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Approval> list = (ArrayList<Approval>) request.getAttribute("list");
	//총 페이지 수 얼마나 나와야 하는지 확인용 총개수/10(페이지당 표시수)
	int count = (int) request.getAttribute("count");
	int pageCount = (int) Math.ceil(count / 10.0);
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Opeaceful</title>
    
    <!--bootstrap css-->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />
    
    <link rel="stylesheet" href="${path}/resources/css/common/common.css" />
    
    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/myApproval.css"
    />
        <link
      rel="stylesheet"
      href="${path}/resources/css/approval/allApproval.css"
    />

  </head>
  <body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	<jsp:include page="/WEB-INF/views/approval/endApprovalModal.jsp" />
	<jsp:include page="/WEB-INF/views/approval/memoModal.jsp" />
  
    <!-- [승은] -->
    <div class="content-wrap" id="all-approval-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">전자결재 관리</h2>
        </div>

		<c:set var="now" value="${LocalDate.now().getYear()}" />
        <div class="inner-wrap">
        	<select id="select-year" >
        		<option value="-1" >전체</option>
        		<option value="${ now }" selected>${ now }</option>
        		<option value="${ now - 1 }" >${ now - 1 }</option>
        		<option value="${ now - 2 }">${ now - 2 }</option>
        		<option value="${ now - 3 }">${ now - 3 }</option>
        		<option value="${ now - 4 }">${ now - 4 }</option>
        	</select>
        
          <table class="all-approval-table table table-common">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">기안일</th>
                <th>제목</th>
                <th>기안자</th>
                <th>
                  <select name="checkStatus" id="check-show-status">
                  	<option value="all" selected>상태</option>
                  	<option value="0">진행중</option>
                    <option value="1">완료</option>
                    <option value="-1" >반려</option>              
                  </select>
                
                
                </th>
                <th scope="col">
                  <select name="checkType" id="check-show-type">
                    <option value="-1" selected>구분</option>
                    <option value="0">일반</option>
                    <option value="1">연차</option>
                    <option value="2">오전반차</option>
                    <option value="3">오후반차</option>
                  </select>
                </th>
              </tr>
            </thead>
            <tbody>
            	<% for(int i=0; i< list.size(); i++) { %>
            		<%  String statusStr = "";
            			String typeStr = "";
            			switch(list.get(i).getStatus()){
		                	case -1: statusStr = "반려";  break;
		                	case 0:  statusStr =  "진행중";  break;
		                	case 1:  statusStr =  "완료";  break;
		                	case 2:  statusStr =  "임시저장";  break;
	                	} 
            			switch(list.get(i).getType()){
		                	case 0:  typeStr =  "일반";  break;
		                	case 1:  typeStr =  "휴가";  break;
		                	case 2:  typeStr =  "오전반차";  break;
		                	case 3: typeStr = "오후반차";  break;
                		} 
	                %>
	              <tr data-approvalno = "<%= list.get(i).getApprovalNo() %>">
	                <td><%= count - i %></td>
	                <td><%= list.get(i).getFormatDraftDate() %></td>
	                <td><%= list.get(i).getTitle()  %></td>
	                <td><%= list.get(i).getUserName()%> <%= list.get(i).getPName()%><%= list.get(i).getEno() != 0 ? "("+list.get(i).getEno()+")" : "" %></td>
	                <td><%= statusStr  %></td>
	                <td><%= typeStr %></td>
	              </tr>
            	<% } %>
            	<c:if test="${list.size() <= 0 }">
            		<tr >
	                	<td colspan="6">등록된 문서가 없습니다.</td>
	                </tr>
            	</c:if>
            </tbody>
          </table>

          <div class="paging-bar">			
			<button type="button" class="disable-btn" id="prev-btn"><span aria-hidden="true">«</span></button>

			<% for(int i= 1; i <= 10; i++) { %>
				<% if( i <= pageCount) { %>
					<% if(i == 1) { %>
						<button type="button" class="selected-btn page-btn"><%= i %></button>
					<% } else { %>
						<button type="button" class="page-btn"><%= i %></button>
					<% } %>
				<% } else {%>
					<button type="button" class="disable-btn page-btn"><%= i %></button>
				<% } %>
			<% } %>
			
			<!-- 버튼의 최대 값보다 총 페이지 수가 크면 다음 버튼 활성화 -->
			<% if( 10 < pageCount ) { %>
				<button type="button" class="" id="next-btn"><span aria-hidden="true">»</span></button>
			<% } else { %>
				<button type="button" class="disable-btn" id="next-btn"><span aria-hidden="true">»</span></button>
			<% } %>
		 </div>






		<div class="modal fade" id="modal-select-search-user"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div
				class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content position-modal">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">결재양식
							선택</h1>

						<button type="button" class="btn-close" data-bs-dismiss="modal"
							data-bs-target="#modal-select-approval-type" aria-label="Close"></button>
					</div>
					<div class="modal-body scroll-bar-none">

						<div class="org-chart">
							<div>
								<!--검색창-->
								<div class="input-group mb-3">
									<input type="text"
										class="form-control box-shadow-none input-search-member"
										placeholder="이름 입력">
									<button class="btn btn-outline-secondary search-btn2"
										type="button">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
								<table class="org-table-head table table-common">
									<thead>
										<th width="40%">부서</th>
										<th width="60%">사원</th>
									</thead>
								</table>
							</div>
							<div class="org-table-content scroll-bar-none">
								<table class="table table-common" id="select-member-table">
									<tbody>
										<tr>
											<td rowspan="2">경영전략</td>
											<td>김뫄뫄 사원</td>
										</tr>
										<tr>
											<td>김뫄뫄 사원</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>


					</div>
					<div class="modal-footer">
						<button id="btn-reset-search-member" type="button"
							class="btn btn-outline-primary" data-bs-dismiss="modal"
							data-bs-target="#modal-select-search-user">선택해제</button>
						<button id="btn-select-search-member" type="button"
							class="btn btn-primary" >선택</button>
					</div>
				</div>
			</div>
		</div>















	<div class="div-approval-search-wrap"
		>
		
		<div id="div-select-member-search">
			<img src="${path }/resources/image/approval/person-search-icon.svg">
			
			<div class = "div-searched-member-name">
				사원 검색
			</div>
				
		</div>

		<div class="div-search-input-wrap input-group">
			
			<input type="text" id="input-search-title"
				class="form-control box-shadow-none"
				placeholder="제목 검색"
				>
			<button class="btn btn-outline-secondary search-btn2" type="button"
				style="border: none;">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</div>

	</div>
















			</div>
      </div>
      
      
      

      
      
      
    </div>


	<script type="module" src="${path}/resources/js/approval/allApprovalFront.js"></script>

  </body>
</html>
