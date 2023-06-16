<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="topDept" value="${map['topDeptList']}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/orgChart/orgChartEnroll.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	
	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">조직도 등록</h2>
			</div>
			<div class="row">
				<div class="col-4 left-box">
					<div class="d-grid d-grid-common d-md-flex justify-content-md-end">
						<button class="btn btn-primary me-md-2 topD-plus" type="button">부서추가</button>
						<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#position" type="button">직급관리</button>
					</div>
					<div class="accordion accordion-flush inputs" id="accordionFlushExample">
					</div>
				</div>
				<div class="col right-box org-right-box">
					<div class="name-btn-box">
					</div>
					<table class="table table-hover org-table table-common">
						<thead class="org-thead">
							<tr>
								<th class="pth2">사원번호</th>
								<th class="pth3">성명</th>
								<th class="pth4">소속부서</th>
								<th class="pth5">직급</th>
							</tr>
						</thead>
						<tbody id="org-tbody">
						</tbody>
					</table>
				</div>
			</div>
			<!-- 직급관리 Modal -->
			<div class="modal org-position-modal fade" id="position" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content position-modal">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">직급관리</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body org-modal-body scroll-bar">
						</div>
						<div class="modal-footer">
							<div class="position-plus-btn">
								직급추가 <i class="fa-solid fa-plus team-plus"></i>
							</div>
							<button type="button" class="btn btn-primary ok-common position-ok ms-auto">저장</button>
							<button type="button" class="btn btn-outline-primary cancel-common position-cancel can" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 인사발령 Modal -->
			<div class="modal fade" id="pesonnel-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
					<div class="modal-content change-modal">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">인사발령관리</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body scroll-bar">
							<table class="table table-hover table-common">
								<thead class="table-active">
									<tr>
										<th class="cth2">발령일자</th>
										<th class="cth3">성명</th>
										<th class="cth4">이전부서</th>
										<th class="cth5">발령부서</th>
										<th class="cth4">이전부서</th>
										<th class="cth5">발령부서</th>
										<th class="cth6">이전직급</th>
										<th class="cth7">발령직급</th>
									</tr>
								</thead>
									<tbody id="org-modal-tbody">
									</tbody>
							</table>
						</div>
						<div class="modal-footer org-footer">
							<button type="button" class="btn btn-primary w90-btn ms-auto" id="ok-personnel">저장</button>
							<button type="button" class="btn btn-outline-primary w90-btn" id="cancel-personnel" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="module" src="${path}/resources/js/orgChart/orgChartEnroll.js"></script>
<script type="module" src="${path}/resources/js/common/dtcodeselect.js"></script>
</html>