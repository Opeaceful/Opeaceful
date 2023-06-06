<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/approvalModal.css"
    />

    <!-- daterangepicker css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"
    />

    <!-- daterangepicker js -->
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"
    ></script>


    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/approvalModal.css"
    />
  </head>
  <body>
    <!-- [승은] -->

    <div
      class="modal fade"
      id="approval"
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
              기안서 작성
            </h1>

            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body scroll-bar-none">
            <form method="post" action="">
              <div class="info-wrap">
                <table class="write-approval-table table">
                  <tbody>
                    <tr>
                      <td width="10%">
                        <div>일자</div>
                      </td>
                      <td width="40%">
                        <i class="bi bi-calendar-week"></i><input id="date" />
                      </td>
                      <td width="10%">
                        <div>종류</div>
                      </td>
                      <td width="40%">연차</td>
                    </tr>
                    <tr>
                      <td>
                        <div>제목</div>
                      </td>
                      <td colspan="3">
                        <input type="text" name="title" id="approval-title" maxlength="30"/>
                      </td>
                    </tr>

                    <tr>
                      <td>
                        <div>결재라인</div>
                      </td>
                      <td colspan="3">
                        <div class="approval-line-wrap">
                          <button
                            id="btn-add-lines"
                            class="btn btn-outline-primary position-btn"
                            type="button"
                          >
                            <i class="fa-solid fa-plus"></i> 선택
                          </button>
                          <div class="approval-lines">
                            <ol class="scroll-bar">
                              <li><b>결재</b> 뫄뫄뫄 부장</li>
                              <li><b>참조</b> 뫄뫄뫄 팀장</li>
                            </ol>
                          </div>
                        </div>
                      </td>
                    </tr>

                    <tr>
                      <td>
                        <div>첨부</div>
                      </td>
                      <td colspan="3">
                        <div class="approval-line-wrap">
                          <button
                            id="btn-add-file"
                            class="btn btn-outline-primary position-btn"
                            type="button"
                          >
                            <i class="fa-solid fa-plus"></i> 첨부
                          </button>
                          <div class="approval-files">
                            <div class="scroll-bar">
                              <div>
                                fjkdlsjf.jpg
                                <button type="button" class="btn-file-delete">
                                  <i class="fa-solid fa-minus"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <textarea class="tinymce" id="form-tiny" name="content" maxlength="3000" >
              </textarea>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-primary">
              임시 저장
            </button>

            <button type="button" class="btn btn-primary position-ok ms-auto">
              저장
            </button>
            <button
              type="button"
              class="btn btn-outline-primary cancel-common position-cancel"
              data-bs-dismiss="modal"
              data-bs-target="#add-form"
            >
              취소
            </button>
          </div>

          <div id="approval-line-modal">
            <div class="custom-modal">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">
                  결재라인
                </h1>
                <button type="button" id="btn-approval-line-modal-close" class="btn-close"></button>
              </div>
              <div class="modal-body">
                <div class="line-wrap">
                  <div class="org-chart">
                    <div>
                       <!--검색창-->         
		              <div class="search-wrap2 input-group mb-3 ms-1">
		                <input type="text" class="search-input2 form-control box-shadow-none input-search-member" placeholder="사원번호/이름 입력" >
		                <button class="btn btn-outline-secondary search-btn2" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
		              </div>
                      <table class="org-table-head table table-common">
                        <thead>
                          <th width="50%">부서</th>
                          <th width="50%">사원</th>
                        </thead>
                      </table>
                    </div>
                    <div class="org-table-content scroll-bar-none">
                      <table class="table table-common" id="select-member-table">
                        <tbody>
                          <tr>
                            <td rowspan="2">경영전략</td>
                            <td>김뫄뫄 사원</td>
                          </tr>
                          <tr>
                            <td>김뫄뫄 사원</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <div class="my-list">
                    <div class="my-favor">
                      <div>
                        <table class="favor-table table table-common">
                          <thead>
                            <th>My 즐겨찾기</th>
                          </thead>
                          <tbody class="scroll-bar">
                            <tr>
                              <td>
                                ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
                                <button
                                  class="btn-favor-delete btn btn-outline-primary"
                                >
                                  삭제
                                </button>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                    <div class="selected-lines">
                      <ol class="scroll-bar">
                        <li>
                          <select name="" id="">
                            <option value="" selected>결재</option>
                            <option value="">참조</option>
                          </select>
                          한우정아 부사장
                          <button
                            class="btn-selected-delete btn btn-outline-primary"
                          >
                            <i class="fa-solid fa-minus"></i>
                          </button>
                        </li>
                        <li>
                          <select name="" id="">
                            <option value="" selected>결재</option>
                            <option value="">참조</option>
                          </select>
                          김뫄뫄 사원
                          <button
                            class="btn-selected-delete btn btn-outline-primary"
                          >
                            <i class="fa-solid fa-minus"></i>
                          </button>
                        </li>
                        <li>
                          <select name="" id="">
                            <option value="" selected>결재</option>
                            <option value="">참조</option>
                          </select>
                          김뫄뫄 부서장
                          <button
                            class="btn-selected-delete btn btn-outline-primary"
                          >
                            <i class="fa-solid fa-minus"></i>
                          </button>
                        </li>
                        <li>
                          <select name="" id="">
                            <option value="" selected>결재</option>
                            <option value="">참조</option>
                          </select>
                          김뫄뫄 부서장
                          <button
                            class="btn-selected-delete btn btn-outline-primary"
                          >
                            <i class="fa-solid fa-minus"></i>
                          </button>
                        </li>
                      </ol>
                      <button
                        id="btn-add-favor"
                        class="btn btn-outline-primary"
                      >
                        즐겨찾기 추가
                      </button>
                    </div>

                    <button id="btn-submit-line" class="btn btn-primary">
                      결제라인 추가
                    </button>
                  </div>
                </div>
              </div>
              <div class="favor-modal-back">
                <div id="favor-add-modal" class="modal-content position-modal">
                  <div class="modal-header">
                    <button
                      type="button"
                      class="btn-close"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    ></button>
                  </div>
                  <div class="modal-body">
                    <div class="favor-modal-body">
                      <div>
                        즐겨찾기 명
                        <input
                          type="text"
                          id="input-favor-title"
                          maxlength="15"
                        />
                      </div>
                      <p>※현재 선택된 결재자 정보를 My즐겨찾기로 저장합니다</p>
                      <button class="btn btn-primary">저장</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    

  </body>
</html>
