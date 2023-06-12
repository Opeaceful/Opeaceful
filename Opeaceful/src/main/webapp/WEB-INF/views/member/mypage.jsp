<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>Opeaceful</title>
	
	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	
    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/member/mypage.css">
</head>
<body>
	<c:if test="${ not empty alertMsg }">
		<script>swal('${alertMsg}');</script>
		<c:remove var="alertMsg"/>
	</c:if>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="mypage-wrap container">
            <!-- 제목 -->
            <h2 class="title-underline">마이페이지</h2>

            <!-- 회원정보 -->
            <form class="mypage-content container row row-col-2" action="${path}/member/mypage" enctype="multipart/form-data" method="post">
                <!-- 이미지부분 -->
                <div class="col-3 mypage-left">
                    <div class="mypage-profile-box">
                    	<c:if test="${empty loginUser.profileImg}">
	                        <img class="mypage-profile" id="mypage-profile" name="profileImg" src="${path}/resources/file/mypage/basic_profile.png">
                    	</c:if>
                    	<c:if test="${!empty loginUser.profileImg}">
	                        <img class="mypage-profile" id="mypage-profile" name="profileImg" src="${path}/resources/file/mypage/${loginUser.profileImg}">
                    	</c:if>
                    </div>

					<div class="profile-btn">
                    	<button type="button" class="btn btn-outline-primary" id="mypage-img-btn">변경</button>
                    	<input type="file" id="mypage-upfile" name="upfile" accept=".png, .jpg, .jpeg" style="display:none;">
					</div>
					
                </div>

                <!-- 내용부분 -->
                <div class="col-9 mypage-right">

                    <!-- 사번 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">사번</div>
                        <input name="userNo" id="mypage-userNo" style="display: none;" value="${loginUser.userNo}">
                        <input name="eno" style="display: none;" value="${loginUser.eno}">
                        <div class="fs-18 ps-4 col-9" id="mypage-no">${loginUser.eno}</div>
                    </div>
                    
                    <!-- 이름 / 직급 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">이름 / 직급</div>
                        <div class="fs-18 ps-4 col-9">
                            <div class="d-inline" id="mypage-name">${loginUser.userName}</div>
                            <div class="d-inline ms-2 me-2"> / </div>
                            <div class="d-inline" id="mypage-position">${loginUser.PName }</div>
                        </div>
                    </div>
                    
                    <!-- 부서 / 팀 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">부서 / 팀</div>
                        <div class="fs-18 ps-4 col-9">
                        	<c:if test="${!empty topDept.deptName}">
	                            <div class="d-inline" id="mypage-dept">${topDept.deptName}</div>
	                            <div class="d-inline ms-2 me-2"> / </div>
                        	</c:if>
                            <div class="d-inline" id="mypage-team">${loginUser.DName }</div>
                        </div>
                    </div>

                    <!-- 연락처 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">연락처</div>
                        <div class="fs-18 col-9">
                            <input type="tel" id="mypage-phone" name="phone" class="mypage-input form-control box-shadow-put" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" maxlength="13" value="${loginUser.phone}">
                        </div>
                    </div>

                    <!-- 내선번호 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">내선번호</div>
                        <div class="fs-18 col-9">
                        	<c:if test="${empty loginUser.extension }">
	                            <input type="tel" id="mypage-call" name="extension" class="mypage-input form-control box-shadow-put" maxlength="13" value="등록된 내선번호 없음">
                        	</c:if>
                        	<c:if test="${!empty loginUser.extension }">
	                            <input type="tel" id="mypage-call" name="extension" class="mypage-input form-control box-shadow-put" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${loginUser.extension}">
                        	</c:if>
                        </div>
                    </div>

                    <!-- 주소 -->
                    <div class="mb-4 row align-items-start">
                        <div class="fs-14 col-3">주소</div>
                        <div class="fs-18 col-9">
	                        <div class="address-first mb-3">
	                        	<!-- 처음 , 전 위쪽 배치 -->
		                        <input type="text" id="user-address" name="address" class="mypage-input form-control box-shadow-put d-inline" required value="${fn:split(loginUser.address, ',')[0]}">
		                        <button class="btn btn-outline-secondary seach-btn" type="button" id="seach-address">
		                            <i class="fa-solid fa-magnifying-glass"></i>
		                        </button>
	                        </div>
	                        
	                        <!-- 처음 , 제외 아래쪽에 모두 배치 -->
	                        <c:set var="addEtc">
		                        <c:forEach items="${fn:split(loginUser.address, ',')}" var="add" begin="1" varStatus="i"><c:if test="${!i.last}">${add}, </c:if><c:if test="${i.last}">${add} </c:if></c:forEach>
	                        </c:set>
	                        <input type="text" id="user-address-dtail" name="address" class="mypage-input form-control box-shadow-put" required value="${addEtc }" >
                        </div>
                    </div>

                    <!-- 이메일 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">이메일</div>
                        <div class="fs-18 col-9">
                            <input type="email" id="mypage-email" name="email" class="mypage-input form-control box-shadow-put" required pattern=".+@gmail\.com" value="${loginUser.email}">
                        </div>
                    </div>

                    <!-- 입사일 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">입사일</div>
                        <div class="fs-18 ps-4 col-9" id="mypage-date">${loginUser.hireDate}</div>
                    </div>

                </div>
                
                <div class="container text-center">
                    <div class="row justify-content-start">
                        <div class="col-4" style="text-align: start;">
                            <!-- Button trigger modal -->
                            <button type="button" id="mypage-pwd-btn" class="pass-re btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">비밀번호 변경</button>
                        </div>
                        <div class="col-4">
                            <button type="submit" class="w90-btn btn btn-primary">정보변경</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

  
    <!-- 비밀번호 변경 Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">비밀번호 변경</h1>
                </div>
                <div class="change-pwd-div modal-body">
                    <div>
                        <div class="row mb-3">
                            <label for="origin-pwd" class="col-sm-4 col-form-label">현재 비밀번호</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="origin-pwd" name="originPwd">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="change-pwd" class="col-sm-4 col-form-label">새 비밀번호</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="update-pwd" name="updatePwd">
								<div style="font-size: 12px;">(영문 대소문자/숫자 2가지 조합, 8자~16자)</div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="change-pwd-ck" class="col-sm-4 col-form-label">새 비밀번호 확인</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="update-pwd-ck">
                            </div>
                        </div>

                    </div>
	                <div class="modal-footer">
	                    <button type="button" class="w90-btn btn btn-primary" id="mypage-update-btn">확인</button>
	                    <button type="button" class="w90-btn btn btn-outline-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
	                </div>
                </div>
            </div>
        </div>
    </div>
	<div id="toast"></div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${path}/resources/js/common/addressAPI.js"></script>
    <script type="module" src="${path}/resources/js/member/mypage.js"></script>

</body>
</html>