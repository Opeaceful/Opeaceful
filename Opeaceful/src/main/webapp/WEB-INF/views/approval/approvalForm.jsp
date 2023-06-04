<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> -->
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
      href="${path}/resources/css/approval/approvalForm.css"
    />

  </head>
  <body>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <!-- [승은] -->
    <div class="approval-form-wrap content-wrap">
      <div class="container">
        <div class="title-box">
          <h2 class="title-common">결재 양식</h2>
        </div>
        <div class="approval-form-table">
          <table class="table table-common">
            <thead>
              <tr>
                <th scope="col">
                  <input type="checkbox" id="check-all" />
                </th>
                <th scope="col">양식명</th>
                <th scope="col">
                  <select name="checkType" id="select-show-type">
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
                <td>
                  <input type="checkbox" value="1"  />
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
                  <input type="checkbox" value="2" />
                </td>
                <td>양식 며어어어엉</td>
                <td>일반</td>
              </tr>
              <tr>
                <td>
                  <input type="checkbox" value="3"/>
                </td>
                <td>양식 며어어어엉</td>
                <td>일반</td>
              </tr>
            </tbody>
          </table>
          <div class="btn-wrap">
            <button id="btn-delete-selected-form" class="btn btn-outline-primary">선택삭제</button>
            
            <button
              id="btn-open-add-form"
              class="btn btn-primary position-btn"
              data-bs-toggle="modal"
              data-bs-target="#add-form-modal"
              type="button"
            >
              신규추가
            </button>
          </div>
        </div>
      </div>

      <div
        class="modal fade"
        id="add-form-modal"
        data-bs-backdrop="static"
        data-bs-keyboard="false"
        tabindex="-1"
        aria-labelledby="staticBackdropLabel"
        aria-hidden="true"
      >
        <div
          class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable"
        >
          <div class="modal-content position-modal">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">
                양식 등록
              </h1>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body scroll-bar-none">
              <form id="form-approvalForm" method="post" action="${path}/approval/approvalForm/insertForm" enctype="multipart/form-data" >
                <div class="type-wrap">
                  <div>
                    <div class="type-title">구분</div>
                    <div>
                      <select name="type" id="form-type">
                        <option value="0" selected>일반</option>
                        <option value="1">연차</option>
                        <option value="2">오전반차</option>
                        <option value="3">오후반차</option>
                      </select>
                    </div>
                  </div>
                  <div>
                    <div class="type-title">양식명</div>
                    <input
                      type="text"
                      id="form-name"
                      name="title"
                      maxlength="20"
                    />
                  </div>
                  <button
                    id="btn-copy-form"
                    type="button"
                    class="btn btn-outline-primary"
                  >
                    양식복사
                  </button>
                </div>
              <textarea class="tinymce" id="form-tiny" name="content">
 				내용을 입력해주세요.
              </textarea
                >
                
                <input type="file" id="input-images" name="images" hidden multiple>
              </form>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                id="btn-form-save"
                class="btn btn-primary position-ok ms-auto"
                value = "test"
              >
                저장
              </button>
              <button
                type="button"
                class="btn btn-outline-primary cancel-common position-cancel can"
                data-bs-dismiss="modal"
                data-bs-target="#add-form"
              >
                취소
              </button>
            </div>

            <div id="copy-form">
              <div class="custom-modal">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="staticBackdropLabel">
                    양식 복사
                  </h1>
                  <button id="btn-close-copy-form" type="button" class="btn-close"></button>
                </div>
                <div class="modal-body">
                  <div class="copy-select-wrap">
                    <div>복사할 양식</div>
                    <select name="copyForm" id="copy-select">
                      <option value="1">
                        testtttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt
                      </option>
                    </select>
                    <button
                      type="button"
                      id="btn-copy-reflect"
                      class="btn btn-outline-primary position-ok ms-auto"
                    >
                      복사
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script type="module" src="${path}/resources/js/approval/approvalFormFront.js"></script>
  </body>
</html>
