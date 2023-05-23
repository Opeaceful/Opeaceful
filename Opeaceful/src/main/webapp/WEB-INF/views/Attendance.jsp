<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
<script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="../../resources/js/Attendance.js"></script>
<link rel="stylesheet" href="../../resources/css/common/common.css">
<link rel="stylesheet" href="../../resources/css/Attendance.css">
</head>
<body>
	<div id="sidebar"></div>
	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">근태 조회</h2>
			</div>
            <div class="col-3 bg-light p-3 border">
                <div class="row">
                    <div class="col">
                        <span>기간</span>
                    </div>
                    <div class="col">
                        <select id="select_year" onchange="javascript:lastday();"></select>
                        <select id="select_month" onchange="javascript:lastday();"></select>
                        <select id="select_day"></select>
                    </div>
                  </div>
             </div>
             <div class="col-sm-9 bg-light p-3 border">
                <div class="row">
                    <div class="col-1">
                        <span class="col">사원명</span>
                    </div>
                    <div class="col-4">
                        <input type="text" class="form-control con-2" id="exampleFormControlInput1">
                    </div>
                    <div class="col-2">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#change" style="-bs-btn-padding-y: .25rem; - -bs-btn-padding-x: .5rem; - -bs-btn-font-size: .75rem;">조회</button>
                    </div>
                  </div>
             </div>
             <table class="table table-hover table-common">
                <thead>
                    <tr class="table-active">
                        <th>일자</th>
                        <th>사원명</th>
                        <th>출근시간</th>
                        <th>퇴근시간</th>
                        <th>근무시간</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>2023/05/23</th>
                        <th>박가영</th>
                        <th>09:00</th>
                        <th>18:00</th>
                        <th>9시간</th>
                        <th></th>
                    </tr>
                    <div><i class="fa-solid fa-minus team-minus"></i> 
                        <i class="fa-solid fa-pen position-change"></i></div>
                </tbody>
            </table>
		</div>
	</div>
    <script>

        $(document).ready(function () {
          setDateBox();
        });
      
        // select box 연도 , 월 표시
        function setDateBox() {
          var dt = new Date();
          var year = "";
          var com_year = dt.getFullYear();
      
          // 발행 뿌려주기
          $("#year").append("<option value=''>년도</option>");
      
          // 올해 기준으로 -50년부터 +1년을 보여준다.
          for (var y = (com_year - 50); y <= (com_year + 1); y++) {
            $("#year").append("<option value='" + y + "'>" + y + " 년" + "</option>");
          }
      
          // 월 뿌려주기(1월부터 12월)
          var month;
          $("#month").append("<option value=''>월</option>");
          for (var i = 1; i <= 12; i++) {
            $("#month").append("<option value='" + i + "'>" + i + " 월" + "</option>");
          }
      
          // 일 뿌려주기(1일부터 31일)
          var day;
          $("#day").append("<option value=''>일</option>");
          for (var i = 1; i <= 31; i++) {
            $("#day").append("<option value='" + i + "'>" + i + " 일" + "</option>");
          }
      
        }
      
      </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>