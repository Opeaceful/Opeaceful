<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- (윤지영) 멤버 전체 조회 : 사용자 조회 view  -->
<title>Opeaceful</title>

</head>
<body>
 	<div class="container">
      <div class="title-box">
        <h2 class="title-common">사용자 조회</h2>
    </div>

    <br><br>
    <!--검색창 구역-->
    <div class="d-inline-flex">
    <select class="form-select form-select-sm " >
      <option selected>부서명</option>
      <option value="1">경영지원부</option>
      <option value="2">인사관리부</option>
      <option value="3">...</option>
    </select>
    <select class="form-select form-select-sm ms-1">
      <option selected>팀명</option>
      <option value="1">경영1팀</option>
      <option value="2">경영2팀</option>
      <option value="3">....</option>
    </select>
    <div class="search-wrap">
      <input type="search" name="keyword" class="search-box">
      <button type="button" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
    </div>
    
  </div>

</body>
</html>