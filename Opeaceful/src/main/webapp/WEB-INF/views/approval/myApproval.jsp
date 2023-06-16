<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" 
import="java.time.LocalDate , java.util.ArrayList, com.company.opeaceful.approval.model.vo.Approval, com.company.opeaceful.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Approval> list = (ArrayList<Approval>) request.getAttribute("list");
	//총 페이지 수 얼마나 나와야 하는지 확인용 총개수/10(페이지당 표시수)
	int count = (int) request.getAttribute("count");
	int pageCount = (int) Math.ceil(count / 10.0);
	Member loginUser = (Member) request.getAttribute("loginUser");
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Opeaceful</title>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
    
    <!-- tiny editor -->
    <script
      src="https://cdn.tiny.cloud/1/4u88c1x1vlsys5jtx9tpp86cmfiahnx5rgsxendvyyqg2464/tinymce/5/tinymce.min.js"
      referrerpolicy="origin"
    ></script>
    
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

  </head>
  <body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	
	<jsp:include page="/WEB-INF/views/approval/approvalModal.jsp" />
	<jsp:include page="/WEB-INF/views/approval/endApprovalModal.jsp" />
	<jsp:include page="/WEB-INF/views/approval/memoModal.jsp" />
  
    <!-- [승은] -->
    <div class="my-approval-wrap content-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">MY 전자결재</h2>
        </div>

        <div class="top-menubar">
			<div class="${ menu eq 'all' ? 'selected ' : '' } top-menubar-item" data-menu="draft">기안</div>
			<div class="top-menubar-item" id="approval-state-temp" data-menu="temp">임시저장</div>
			<div class="top-menubar-item" id="approval-state-return" data-menu="return">
				<div class="alarm-wrap">
					반려
					<span id="return-alarm" class="${ returnCount > 0 ? "" : "alarm-hide" } alarm-balloon" alt="알림수">${returnCount}</span>
				</div>
			</div>
			<div class="top-menubar-item" id="approval-state-refer" data-menu="refer">
				<div class="alarm-wrap">
					참조
					<span id="refer-alarm" class="${ referCount > 0 ? "" : "alarm-hide" } alarm-balloon" alt="알림수">${referCount}</span>
				</div>
			</div>
			
			<div class="${ menu eq 'wait' ? 'selected ' : '' } top-menubar-item" id="approval-state-wait" data-menu='wait'>
				<div class="alarm-wrap">
					승인대기
					<span id="wait-alarm" class="${ waitCount > 0 ? "" : "alarm-hide" } alarm-balloon" alt="알림수">${waitCount }</span>
				</div>
			</div>
			
			<div  class="top-menubar-item" id="approval-state-approval" data-menu='authorized'>결재</div>
	
			<div class="line"></div>
		</div>


		<c:set var="now" value="${LocalDate.now().getYear()}" />

        <div class="inner-wrap">
        	<select id="select-year" >
        		<c:if test="${ menu eq 'wait' }">
        			<option value="-1" selected>전체</option>
        		</c:if>
        		<option value="${ now }"  ${ menu eq 'all' ? 'selected ' : '' }>${ now }</option>
        		<option value="${ now - 1 }" >${ now - 1 }</option>
        		<option value="${ now - 2 }">${ now - 2 }</option>
        		<option value="${ now - 3 }">${ now - 3 }</option>
        		<option value="${ now - 4 }">${ now - 4 }</option>
        	</select>
        
          <table class="my-approval-table table table-common">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">기안일</th>
                <th>제목</th>
                <th>기안자</th>
                <th>
                  <select name="checkStatus" id="check-show-status">
					<c:choose>
						<c:when test="${menu eq 'wait'}">
		                  	<option value="0" selected>진행중</option>
						</c:when>
						<c:otherwise>
		                  	<option value="all" selected>상태</option>
		                  	<option value="0">진행중</option>
		                    <option value="1">완료</option>
		                    <option value="-1" >반려</option>
						</c:otherwise>
					</c:choose>                  
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
            		<%	boolean isNotRead = false;
            			if ( loginUser.getUserNo() == list.get(i).getUserNo() ) {
	            	        isNotRead = list.get(i).getStatus() == -1;
	            	      }
            			if(list.get(i).getConfirmStatus() != null) {
            	        	isNotRead = list.get(i).getConfirmStatus().equals("N");
	            	    } else {
	            	       isNotRead = list.get(i).getStatus() == -1;
	            	    }
            		
            			String statusStr = "";
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
	              <tr data-approvalno = "<%= list.get(i).getApprovalNo() %>"
	              	class ="<%= isNotRead ? "not-read" : ""%>">
	                <td><%= count - i %></td>
	                <td><%= list.get(i).getFormatDraftDate() %></td>
	                <td><%= list.get(i).getTitle()  %></td>
	                <td><%= list.get(i).getUserName()%><%= list.get(i).getEno() != 0 ? "("+list.get(i).getEno()+")" : "" %></td>
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

          <div class="btn-wrap">
            <button
              id="btn-add-approval"
              class="btn btn-primary position-btn"
              type="button"
            >
              <i class="fa-solid fa-plus"></i> 신규
            </button>
            <button
              id="btn-open-sign-modal"
              type="button"
            class="btn btn-outline-primary">My서명</button>
          </div>

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

          <div
            class="modal fade"
            id="sign-modal"
            data-bs-backdrop="static"
            data-bs-keyboard="false"
            tabindex="-1"
            aria-labelledby="staticBackdropLabel"
            aria-hidden="true"
          >
            <div
              class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable"
            >
              <div class="modal-content position-modal">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="staticBackdropLabel">
                    서명 등록
                  </h1>
                  <button
                    type="button"
                    class="btn-close btn-sign-img-cancle"
                  ></button>
                </div>
                <div class="modal-body scroll-bar-none">
                  <div class="sign-img-wrap">

                    <div class="sign-img-item">
                    	<div>기존 이미지</div>
                      <img id="img-my-sign" onerror="this.src='${path}/resources/image/approval/defaultiSignature.png';">
                    </div>
                    <div class="sign-img-item">
                    	<div>신규 이미지</div>
                      <img id="img-new-sign" onerror="this.src='${path}/resources/image/approval/invisible.png';">
                    </div>

                  </div>
                  <input id="input-new-sign" type="file" accept="image/*" hidden>

                  <div class="sign-btn-wrap">
                    <button id="btn-sign-img-save" class="btn btn-primary">저장</button>
                    <button class="btn btn-outline-primary btn-sign-img-cancle">취소</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


	
	
	<script type="module" src="${path}/resources/js/approval/myApprovalFront.js"></script>

  </body>
</html>
