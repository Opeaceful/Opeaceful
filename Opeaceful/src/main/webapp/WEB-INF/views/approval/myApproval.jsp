<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Opeaceful</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <!-- tiny editor -->
    <script
      src="https://cdn.tiny.cloud/1/4u88c1x1vlsys5jtx9tpp86cmfiahnx5rgsxendvyyqg2464/tinymce/5/tinymce.min.js"
      referrerpolicy="origin"
    ></script>
    <!--bootstrap css-->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />
    <!-- 부트스트랩 아이콘 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"
    />
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script
      src="https://kit.fontawesome.com/a2e8ca0ae3.js"
      crossorigin="anonymous"
    ></script>
    <!-- JavaScript Bundle with Popper -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <link rel="stylesheet" href="../../../resources/css/common/common.css" />
    <link
      rel="stylesheet"
      href="../../../resources/css/approval/myApproval.css"
    />
  </head>
  <body>
    <!-- [승은] -->
    <div class="my-approval-wrap content-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">MY 전자결재</h2>
        </div>

        <div class="top-menubar">
          <div class="selected">전체</div>
          <div>진행중</div>
          <div>반려</div>
          <div>완료</div>
          <div>
            <div class="alarm-wrap">
              승인대기
              <div class="alarm"></div>
            </div>
            <!-- <div class="alarm">22</div> -->
          </div>
          <div>결재</div>
          <div class="line"></div>
        </div>

        <div class="inner-wrap">
          <table class="my-approval-table table table-common">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">기안일</th>
                <th>제목</th>
                <th>기안자</th>
                <th>진행상태</th>
                <th scope="col">
                  <select name="checkType" id="check-type">
                    <option value="all" selected>구분</option>
                    <option value="0">일반</option>
                    <option value="1">연차</option>
                    <option value="2">오전반차</option>
                    <option value="3">오후반차</option>
                  </select>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>3</td>
                <td>2023-05-16 09:56</td>
                <td>서지출결의서지출결의서지지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서출결의서~~~</td>
                <td>김사원</td>
                <td>진행중</td>
                <td>일반</td>
              </tr>
              <tr>
                <td>2</td>
                <td>2023-05-16 09:55</td>
                <td>휴가요청~~~</td>
                <td>이사원</td>
                <td>진행중</td>
                <td>연차</td>
              </tr>
              <tr>
                <td>1</td>
                <td>2023-05-16 09:54</td>
                <td>지출결의서~~~</td>
                <td>김사원</td>
                <td>완료</td>
                <td>오후반차</td>
              </tr>
            </tbody>
          </table>

          <div class="btn-wrap">
            <button
              id="btn-add-form"
              class="btn btn-primary position-btn"
              data-bs-toggle="modal"
              data-bs-target="#add-form"
              type="button"
            >
              <i class="fa-solid fa-plus"></i> 신규
            </button>
            <button class="btn btn-outline-primary">My서명</button>
          </div>

          <div class="pagingArea">
            <button class="btn btn-outline-primary"><</button>
            <button class="btn btn-outline-primary">1</button>
            <button class="btn btn-outline-primary">></button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
