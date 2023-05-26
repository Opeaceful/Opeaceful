<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Opeaceful</title>

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
    <link rel="stylesheet" href="../../../resources/css/approval.css" />
  </head>
  <body>
    <div class="approval-wrap content-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">결재 양식</h2>
        </div>
        <div class="approval-form-table">
          <table class="table table-common">
            <thead>
              <tr>
                <th scope="col">
                  <input type="checkbox" id="select-all" />
                </th>
                <th scope="col">양식명</th>
                <th scope="col">
                  <select name="" id="">
                    <option value="all" selected>구분</option>
                    <option value="nomal">일반</option>
                    <option value="allOff">연차</option>
                    <option value="amOff">오전반차</option>
                    <option value="pmOff">오후반차</option>
                  </select>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <input type="checkbox" id="save-id" />
                </td>
                <td>
                  <div>
                    양식
                    며어어어어어어어어어어어어어어엉며어어어어어어어어어어어어어어엉
                  </div>
                </td>
                <td>일반</td>
              </tr>
              <tr>
                <td>
                  <input type="checkbox" id="save-id" />
                </td>
                <td>양식 며어어어엉</td>
                <td>일반</td>
              </tr>
              <tr>
                <td>
                  <input type="checkbox" id="save-id" />
                </td>
                <td>양식 며어어어엉</td>
                <td>일반</td>
              </tr>
            </tbody>
          </table>
          <div class="btn-wrap">
            <button class="btn btn-outline-primary">선택삭제</button>
            <button class="btn btn-primary">신규추가</button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
