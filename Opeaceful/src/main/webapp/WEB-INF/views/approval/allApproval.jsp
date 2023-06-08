<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Opeaceful</title>
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

    <link rel="stylesheet" href="${path}/resources/css/common/common.css" />
    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/myApproval.css"
    />
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/sidebar.jsp" />
  
    <!-- [승은] -->
    <div class="my-approval-wrap content-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">전자결재</h2>
        </div>

        <div class="top-menubar">
          <div class="selected">전체</div>
          <div>진행중</div>
          <div>반려</div>
          <div>완료</div>
          <div>승인대기</div>
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
                <td>
                  서지출결의서지출결의서지지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서지출결의서출결의서~~~
                </td>
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
            <!-- <button
              id="btn-add-form"
              class="btn btn-primary position-btn"
              data-bs-toggle="modal"
              data-bs-target="#add-form"
              type="button"
            >
              <i class="fa-solid fa-plus"></i> 신규
            </button> -->
            <!-- <button
              id="test"
              data-bs-toggle="modal"
              data-bs-target="#sign"
              type="button"
              class="btn btn-outline-primary"
            >
              My서명
            </button> -->
          </div>

          <div class="pagingArea">
            <button class="btn btn-outline-primary"><</button>
            <button class="btn btn-outline-primary">1</button>
            <button class="btn btn-outline-primary">></button>
          </div>

          <div
            class="modal fade"
            id="sign"
            data-bs-backdrop="static"
            data-bs-keyboard="false"
            tabindex="-1"
            aria-labelledby="staticBackdropLabel"
            aria-hidden="true"
          >
            <div
              class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable"
            >
              <div class="modal-content position-modal">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="staticBackdropLabel">
                    서명 등록
                  </h1>
                  <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Close"
                  ></button>
                </div>
                <div class="modal-body scroll-bar-none">
                  <div class="sign-img-wrap">
                    <div class="sign-img-item">
                      <img src="${path}/resources/image/main/eat.svg" alt="" />
                    </div>

                    <div class="sign-img-item">
                      <img
                        src="${path}/resources/image/mypage/basic_profile.png"
                        alt=""
                      />
                    </div>
                  </div>
                  <input type="file" hidden />

                  <div class="sign-btn-wrap">
                    <button id="btn-sign-img-save" class="btn btn-primary">
                      저장
                    </button>
                    <button class="btn btn-outline-primary">취소</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    
	<jsp:include page="/WEB-INF/views/approval/endApprovalModal.jsp" />

  </body>
</html>
