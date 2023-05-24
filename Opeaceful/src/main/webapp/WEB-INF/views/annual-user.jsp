<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/annual-user.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    <div class="content-wrap">
        <div class="annual-wrap container">
            <!-- 제목 -->
            <h4 class="title-underline">연차</h4>
    
            <!-- 내용부분 -->
            <div class="annual-content">
                <!-- <div>
                    <input type="text" class="form-control box-shadow-put" id="annual-user" placeholder="사원명">
                    <button type="button" id="user-select-btn" class="w90-btn btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">조회</button>
                </div> -->
                <div class="search-wrap2 input-group mb-3">
                    <input type="text" class="search-input2 form-control box-shadow-none" id="annual-user" placeholder="사원명">
                    <button id="user-select-btn" class="btn btn-outline-secondary" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
                <div class="annual-user-info container row align-items-center">
                        <div class="col-9">
                            <span class="ms-5 fs-3" id="annual-user-name">노지의</span>
                            <span class="ms-5 fs-5" id="annual-dept">IT 운영부</span>
                            <span class="ms-5 fs-5" id="annual-team">개발팀</span>
                            <span class="ms-5 annual-only-text">입사일</span>
                            <span class="ms-2 fs-5" id="annual-hire-date"> 2019-02-08</span>
                        </div>
                        <div class="col-3">
                            <span class="annual-only-text">누적연차</span>
                            <span class="ms-2 fs-5" id="annual-use">4.5</span>
                            <span class="ms-2 fs-5">/</span>
                            <input type="text" id="annual-count" class="annual-count ms-2 fs-5 form-control box-shadow-put" value="16">
                            <button type="button" class="btn btn-success ms-2 mb-1">수정</button>
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

                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>연차</td>
                                <td>2022-04-13</td>
                                <td>2022-04-14</td>
                                <td>1</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>총 사용 연차</td>
                                <td>30</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

            </div>
        </div>
    </div>

</body>
</html>