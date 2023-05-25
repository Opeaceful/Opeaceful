<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
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
    <link rel="stylesheet" href="${path}/resources/css/login.css">
</head>
<body>
    <div class="login-wrap">
        <div class="login-div row">
            <!-- 로고 -->
            <div class="login-logo">
                <div class="d-inline">
                    <i class="fa-solid fa-feather"></i>
                </div>
                <div class="d-inline" id="opeaceful">Opeaceful</div>
            </div>

            <!-- 폼 -->
            <div class="login-form">
                <form action="${path}/main" method="post">
                    <div class="login-input">
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="fa-solid fa-user"style="width: 16px;"></i></span>
                            <input type="text" class="form-control box-shadow-put" id="login-id" placeholder="사원번호">
                        </div>
            
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="fa-solid fa-key"></i></span>
                            <input type="password" class="form-control box-shadow-put" id="login-pwd" placeholder="비밀번호">
                        </div>
        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input box-shadow-put" id="save-id">
                            <label class="form-check-label" for="save-id">아이디 저장</label>
                        </div>
                    </div>
                    
                    <div class="login-btn">
                        <button type="submit" class="btn btn-primary" id="login-btn">로그인</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>