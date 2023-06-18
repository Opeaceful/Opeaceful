<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${path}/resources/css/approval/memo.css" />

</head>
<body>




	<!-- 메모모달 구역 -->
	<div id="memo-modal-back" class=" modal fade modal-back"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div id="memo-modal"
			class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content position-modal">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">메모</h1>
					<button type="button" class="btn-close" id="btn-memo-modal-close"></button>
				</div>
				<div class="modal-body">
					<div class="memo-modal-body">
						<!-- 메모 리스트 구역 -->
						<div class="memo-list">
							<table style="margin-bottom: 0px" class="table table-common">
								<thead>
									<tr>
										<th>작성자</th>
										<th>내용</th>
										<th>등록일</th>
									</tr>
								</thead>
							</table>
							<table class="table table-common">
								<tbody class="memo-list-table scroll-bar">
								</tbody>
							</table>
							<div>
								<button id="btn-add-memo" class="btn btn-outline-primary">
									작성</button>
							</div>
						</div>
						<!-- 메모 상세보기/추가 구역 -->
						<div class="memo-detail">
							<!-- <h3><</h3> -->
							<table class="memo-detail-table table table-common">
								<tbody>
									<tr>
										<td>
											<div>첨부</div>
										</td>
										<td>
											<div class="memo-files-wrap">
												<input class="form-control form-control-sm" type="file"
													id="input-memo-add-file" multiple />
												<div class="memo-files scroll-bar">
													<div class="memo-file-item">
														<a href="" download=""></a>
													</div>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div>내용</div>
										</td>
										<td><textarea name="content" id="memo-add-content"
												cols="30" rows="10" maxlength="1000" class="scroll-bar"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="memo-btn-wrap">
								<button id="btn-add-memo-back" class="btn btn-outline-primary">
									뒤로가기</button>
								<div>
									<button id="btn-add-memo-delete" class="btn btn-danger">
										삭제</button>
									<button id="btn-add-memo-save" class="btn btn-primary">
										저장</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="module" src="${path}/resources/js/approval/memo.js"></script>
</body>
</html>