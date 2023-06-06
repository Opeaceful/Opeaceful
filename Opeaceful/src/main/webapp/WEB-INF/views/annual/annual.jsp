<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	
    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
    <link rel="stylesheet" href="${path}/resources/css/annual.css">

</head>
<body>

    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="container">
            <!-- 제목 -->
			<div class="title-box">
				<h2 class="title-common">총 연차 관리</h2>
			</div>
            <!-- 내용부분 -->
            <div class="annual-content container">
                <!-- 수정버튼 -->
                <div class="modify-btn">
                    <!-- Button trigger modal -->
                    <button type="button" class="w90-btn btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">수정</button>
                </div>
                
                <!-- 표 -->
                <div class="row annual-table-div">
                    <div class="col-md-6">
                        <table class="annual-table table table-common">
                            <thead>
                                <tr>
                                    <th scope="col">근로기간</th>
                                    <th scope="col">연차 유급휴가 발생</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${annual}" var="a">
                            	    <c:if test="${a.year eq 0}">
										<tr>
		                                    <td class="annual-year">${a.year + 1}년 미만</td>
		                                    <td class="annual-count">${a.annualUnit}</td>
		                                </tr>
                            		</c:if>
                            		<c:if test="${a.year > 0 && a.year <= 10}">
										<tr>
		                                    <td class="annual-year">${a.year}년</td>
		                                    <td class="annual-count">${a.annualUnit}</td>
		                                </tr>
                            		</c:if>
                            	</c:forEach>
                            </tbody>          
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="annual-table table table-common">
                            <thead>
                                <tr>
                                    <th scope="col">근로기간</th>
                                    <th scope="col">연차 유급휴가 발생</th>
                                </tr>
                            </thead>
                            <tbody>
								<c:forEach items="${annual}" var="a">
                            		<c:if test="${a.year > 10}">
										<tr>
		                                    <td class="annual-year">${a.year}년</td>
		                                    <td class="annual-count">${a.annualUnit}</td>
		                                </tr>
                            		</c:if>
                            	</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
			</div>
		</div>
	</div>


    <!-- 연차 수정 Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
				<form action="${path}/annual/setting" method="post">
	                <div class="modal-header">
	                    <h1 class="modal-title fs-5" id="staticBackdropLabel">총 연차 변경</h1>
	                </div>
	                <div class="annual-modify-modal modal-body">
                        <div class="row mb-3">
                            <label for="annual-year-select" class="col-sm-4 col-form-label">근로기간</label>
                            <div class="col-sm-8">
                                <select class="form-select box-shadow-put" aria-label="Default select example" name="year">
                                    <option selected>근로기간 선택</option>
	                        		<c:forEach items="${annual}" var="a">
		                        		<c:if test="${a.year eq 0}">
			                                <option value="${a.year}">${a.year + 1}년 미만</option>
	                            		</c:if>
	                            		<c:if test="${a.year > 0}">
											<option value="${a.year}">${a.year}년</option>
	                            		</c:if>
	                            	</c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="annual-count-modify" class="col-sm-4 col-form-label">연차 유급휴가</label>
                            <div class="col-sm-8">
                                <input type="number" class="form-control box-shadow-put" id="annual-count-modify" name="annualUnit">
                            </div>
                        </div>
	                </div>
	                <div class="modal-footer">
	                    <button type="submit" class="w90-btn btn btn-primary">확인</button>
	                    <button type="button" class="w90-btn btn btn-outline-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
	                </div>
                </form>
            </div>
        </div>
    </div>


</body>
</html>