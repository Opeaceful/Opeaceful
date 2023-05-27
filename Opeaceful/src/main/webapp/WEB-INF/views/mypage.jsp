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

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/mypage.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="mypage-wrap container">
            <!-- 제목 -->
            <h2 class="title-underline">마이페이지</h2>

            <!-- 회원정보 -->
            <div class="mypage-content container row row-col-2">

                <!-- 이미지부분 -->
                <div class="col-3 mypage-left">
                    <div class="mypage-profile-box">
                        <img class="mypage-profile" src="${path}/resources/image/mypage/basic_profile.png">
                    </div>
                    <div class="profile-btn"><button type="button" class="btn btn-outline-primary">변경</button></div>
                </div>

                <!-- 내용부분 -->
                <div class="col-9 mypage-right">

                    <!-- 사번 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">사번</div>
                        <div class="fs-18 ps-4 col-9" id="mypage-no">230522</div>
                    </div>
                    
                    <!-- 이름 / 직급 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">이름 / 직급</div>
                        <div class="fs-18 ps-4 col-9">
                            <div class="d-inline" id="mypage-name">노지의</div>
                            <div class="d-inline ms-2 me-2"> / </div>
                            <div class="d-inline" id="mypage-position">사원</div>
                        </div>
                    </div>
                    
                    <!-- 부서 / 팀 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">부서 / 팀</div>
                        <div class="fs-18 ps-4 col-9">
                            <div class="d-inline" id="mypage-dept">IT</div>
                            <div class="d-inline ms-2 me-2"> / </div>
                            <div class="d-inline" id="mypage-team">개발 1팀</div>
                        </div>
                    </div>

                    <!-- 연락처 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">연락처</div>
                        <div class="fs-18 col-9">
                            <input type="tel" id="mypage-phone" class="mypage-input form-control box-shadow-put" required pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13">
                        </div>
                    </div>

                    <!-- 내선번호 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">내선번호</div>
                        <div class="fs-18 col-9">
                            <input type="tel" id="mypage-call" class="mypage-input form-control box-shadow-put" required pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13">
                        </div>
                    </div>

                    <!-- 주소 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">주소</div>
                        <div class="fs-18 col-9">
                            <input type="text" id="mypage-address" class="mypage-input form-control box-shadow-put">
                        </div>
                    </div>

                    <!-- 이메일 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">이메일</div>
                        <div class="fs-18 col-9">
                            <input type="email" id="mypage-email" class="mypage-input form-control box-shadow-put" pattern=".+@gmail\.com">
                        </div>
                    </div>

                    <!-- 입사일 -->
                    <div class="mb-4 row align-items-center">
                        <div class="fs-14 col-3">입사일</div>
                        <div class="fs-18 ps-4 col-9" id="mypage-date">2023-05-22</div>
                    </div>

                </div>
                
                <div class="container text-center">
                    <div class="row justify-content-start">
                        <div class="col-4" style="text-align: start;">
                            <!-- Button trigger modal -->
                            <button type="button" class="pass-re btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">비밀번호 변경</button>
                        </div>
                        <div class="col-4">
                            <button type="button" class="w90-btn btn btn-primary">정보변경</button>
                        </div>
                    </div>
                </div>
            </div>


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
                    <form>
                        <div class="row mb-3">
                            <label for="origin-pwd" class="col-sm-4 col-form-label">현재 비밀번호</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="origin-pwd">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="change-pwd" class="col-sm-4 col-form-label">새 비밀번호</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="change-pwd">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="change-pwd-ck" class="col-sm-4 col-form-label">새 비밀번호 확인</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control box-shadow-put" id="change-pwd-ck">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="w90-btn btn btn-primary">확인</button>
                    <button type="button" class="w90-btn btn btn-outline-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                </div>
            </div>
        </div>
    </div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${path}/resources/js/addressAPI.js"></script>
    
    <script>
    $('#mypage-phone,#mypage-call').keyup(function (event) {
    event = event || window.event;
    var _val = this.value.trim();
    this.value = autoHypenTel(_val);
    });

    </script>
</body>
</html>