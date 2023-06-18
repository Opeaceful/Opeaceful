<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	
	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    
    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
    <link rel="stylesheet" href="${path}/resources/css/annual-user.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="annual-wrap container">
            <!-- 제목 -->
   			<div class="title-box">
				<h2 class="title-common">연차</h2>
			</div>
            <!-- member-search-keyword -->
            <!-- 내용부분 -->
            <div class="annual-content">
                <!--검색창 구역-->
                <div class="search-wrap2 input-group mb-3 ms-1">
                    <input type="text" class="search-input2 form-control box-shadow-none" id="member-search-keyword" placeholder="사원 검색" readonly style="cursor: pointer;">
                    <!--data-bs-target="#all-user-view" 조회할 구역에 data-target넣어주기-->
                    <button class="btn btn-outline-secondary search-btn2" type="button" data-bs-toggle="modal" data-bs-target="#all-user-view" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>

                <div class="annual-user-info row align-items-center">
                        <div class="col-9">
                            <article id="no" data-userno="${m.userNo}"></article>
                            <span class="ms-5 fs-4" id="annual-user-name">${m.userName}</span>
                            <span class="ms-5" id="annual-dept">${m.topDeptName}</span>
                            <span class="ms-5" id="annual-team">${m.DName}</span>
                            <c:if test="${not empty m.hireDate}">
                            	<span class="ms-5 annual-only-text">입사일</span>
                            	<span class="ms-2" id="annual-hire-date"> ${m.hireDate}</span>
                            </c:if>
                        </div>
                        <div class="col-3">
                            <span class="annual-only-text">누적연차</span>
                            <span class="ms-2 fs-4" id="annual-use">
                            
                            	<c:set var = "total" value = "0" />
                            	<c:forEach items="${apr}" var="a">
                            		<c:set var="total" value="${total+a.approvalCount}" />
                            	</c:forEach>
                            	<c:if test="${empty apr }">-</c:if>
                            	<c:if test="${!empty apr }">
	                            	<c:out value="${total}"/>
                            	</c:if>
                            </span>
                            <c:if test="${empty m.userNo }">
	                            <span class="ms-2 fs-4">/</span>
	                            <span class="ms-2 fs-4" style="margin-right: 35.2px;">- </span>
                            </c:if>
                            <c:if test="${!empty m.userNo }">
	                            <span class="ms-2 fs-4">/</span>
	                            <input type="number" id="annual-count" class="annual-count ms-2 fs-4 form-control box-shadow-put" value="${m.annualLeaveCount}">
                            </c:if>
                            <button type="button" class="btn btn-success ms-2" id="annual-user-btn" disabled>수정</button>
                        </div>
                </div>

                <div class="annual-table-div overflow-auto">
                    <table class="annual-table table table-common">
                        <thead>
                            <tr>
                                <th scope="col">휴가구분</th>
                                <th scope="col">시작일</th>
                                <th scope="col">종료일</th>
                                <th scope="col">휴가일수</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:if test="${empty apr }">
                        	     <tr>
                        	     	<td colspan="4">조회할 자료가 없습니다.</td>
                        	     </tr>
                        	</c:if>
                        	<c:forEach items="${apr}" var="a">
                        		<tr>
                        			<c:if test="${a.type eq 1}">
		                                <td>연차</td>
                        			</c:if>
                        			<c:if test="${a.type eq 2}">
		                                <td>오전 반차</td>
                        			</c:if>
                        			<c:if test="${a.type eq 3}">
		                                <td>오후 반차</td>
                        			</c:if>
	                                <td>${a.startDate }</td>
	                                <td>${a.endDate }</td>
	                                
	                                <td class="approvalCount">
		                                <c:if test="${a.approvalCount >= 1 }">
		                                	<fmt:formatNumber value="${a.approvalCount}" type="number" var="approvalCount" />
		                                	${approvalCount }
		                                </c:if>
		                                <c:if test="${a.approvalCount < 1 }">
		                                	${a.approvalCount }
		                                </c:if>

	                                </td>	                                
	                            </tr>
                        	</c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>총 사용 연차</td>
		                        <c:if test="${empty apr }">
                                	<td>-</td>
		                        </c:if>
		                        <c:if test="${!empty apr }">
		                        	<td><c:out value="${total}"/></td>
		                        </c:if>
                            </tr>
                        </tfoot>
                    </table>
                </div>

            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/member/member-select.jsp"/>
<script type="module" src="${path}/resources/js/annual-user.js"></script>

</body>
</html>