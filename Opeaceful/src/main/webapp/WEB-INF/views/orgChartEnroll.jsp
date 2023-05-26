<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/orgChartEnroll.css">
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
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div class="accordion-item accordion-item-common">
							<h2 class="accordion-header" id="flush-headingOne">
								<button class="accordion-button oc-accordion-btn accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne" aria-label="펼치기">
									<table style="height: 100px;">
										<tbody>
										  <tr>
											<td class="align-baseline">
												<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
											</td>
										  </tr>
										  <tr>
											<td class="align-baseline">
												<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
											</td>
										  </tr>
										  <tr>
											<td class="align-baseline">
												<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
											</td>
										  </tr>
										</tbody>
									  </table>
									<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
									<i class="fa-solid fa-plus team-plus"></i> 
									<i class="fa-solid fa-minus team-minus"></i> 
									<i class="fa-solid fa-pen team-change"></i>
								</button>
							</h2>
							<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
								<ul class="accordion-body accordion-body-common oc-all">
									<li class="team low-common"><input type="text" name="team">
										<i class="fa-solid fa-minus li-team-minus"></i> 
										<i class="fa-solid fa-pen li-team-change"></i>
									</li>
									<li class="team low-common">
										<input class="team-name" type="text" name="team">
									</li>
								</ul>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingTwo">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">Accordion Item #2</button>
							</h2>
							<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">
									Placeholder content for this accordion, which is intended to
									demonstrate the<code>.accordion-flush</code>
									class. This is the second item's accordion body. Let's imagine
									this being filled with some actual content.
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingThree">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">Accordion Item #3</button>
							</h2>
							<div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">
									Placeholder content for this accordion, which is intended to
									demonstrate the<code>.accordion-flush</code>
									class. This is the third item's accordion body. Nothing more
									exciting happening here in terms of content, but just filling
									up the space to make it look, at least at first glance, a bit
									more representative of how this would look in a real-world application.
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col right-box">
					<div class="name-btn-box">
						<div class="department-name-box">경영지원본부</div>
						<button class="btn btn-primary dp-btn" data-bs-toggle="modal" data-bs-target="#change" type="button">인사발령</button>
					</div>
					<table class="table table-hover table-common">
						<thead>
							<tr>
								<th class="pth2">사원번호</th>
								<th class="pth3">성명</th>
								<th class="pth4">소속부서</th>
								<th class="pth5">직급</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>951003</td>
								<td>박가영</td>
								<td>인사팀</td>
								<td>사원</td>
							</tr>
							<tr>
								<td>210208</td>
								<td>윤지영</td>
								<td>인사팀</td>
								<td>사원</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 직급관리 Modal -->
			<div class="modal fade" id="position" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content position-modal">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">직급관리</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<ul class="list-group list-group-flush">
								<li class="list-group-item position-list">
									<input type="text" name="position-name"> 
									<i class="fa-solid fa-minus team-minus"></i> 
									<i class="fa-solid fa-pen position-change"></i>
								</li>
							</ul>
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
			<div class="modal fade" id="change" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
					<div class="modal-content change-modal">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">인사발령관리</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
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
								<tbody>
									<tr class="change-tr">
										<td>2023/05/22</td>
										<td>박가영</td>
										<td>경영지원본부</td>
										<td>
											<select class="form-select box-shadow-none" aria-label="Default select example">
												<option selected>경영지원본부</option>
												<option value="1">부장</option>
												<option value="2">팀장</option>
												<option value="3">대리</option>
												<option value="4">사원</option>
												<option value="5">인턴</option>
											</select>
										</td>
										<td>인사팀</td>
										<td>
											<select class="form-select box-shadow-none" aria-label="Default select example">
												<option selected>인사팀</option>
												<option value="1">회계팀</option>
												<option value="2">서비스팀</option>
											</select>
										</td>
										<td>사원</td>
										<td>
											<select class="form-select box-shadow-none" aria-label="Default select example">
												<option selected>사원</option>
												<option value="1">부장</option>
												<option value="2">팀장</option>
												<option value="3">대리</option>
												<option value="4">사원</option>
												<option value="5">인턴</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="modal-footer org-footer">
							<button type="button" class="btn btn-primary w90-btn ms-auto">저장</button>
							<button type="button" class="btn btn-outline-primary w90-btn" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script type="module" src="${path}/resources/js/orgChart.js"></script>
</body>
</html>