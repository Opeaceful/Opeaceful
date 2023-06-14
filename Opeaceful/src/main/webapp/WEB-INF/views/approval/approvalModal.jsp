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
	
	<!-- jQuery ui / Sortable 사용용도 -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" type="text/javascript"></script>

    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/approvalModal.css"
    />
  </head>
  <body>
    <!-- [승은] -->

	<div class="modal fade" id="modal-select-approval-type"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content position-modal">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">결재양식 선택</h1>

					<button type="button" class="btn-close" data-bs-dismiss="modal" data-bs-target="#modal-select-approval-type"
						aria-label="Close"></button>
				</div>
				<div class="modal-body scroll-bar-none">
					<div class="div-copy-form-type-wrap">
					
						<div>구분</div>
						
						<select  id="select-copy-form-type">
		                    <option value="0" selected>일반</option>
		                    <option value="1">연차</option>
		                    <option value="2">오전반차</option>
		                    <option value="3">오후반차</option>
		                </select>
	                    
	                    <select  id="select-copy-form-no" >
	                    	<option value="none" selected>선택 안함</option>
		                    <option value="1">양식명</option>
		                    <option value="2">123456789123456789123456789</option>
		                    <option value="3">양식명</option>
	                    </select>
					
					</div>
					
				
				</div>
				<div class="modal-footer">
					<button id="btn-select-copy-form-type" type="button" class="btn btn-primary" data-bs-dismiss="modal" data-bs-target="#modal-select-approval-type">
						선택</button>
				</div>
			</div>
		</div>
	</div>

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
                      <td class="date-td" width="10%">
                        <div>일자</div>
                      </td>
                      <td class="date-td" width="40%">
                        <i class="bi bi-calendar-week"></i><input id="date" />
                      </td>
                      <td width="10%">
                        <div>종류</div>
                      </td>
                      <td id="td-approval-table-type" width="40%">연차 [ 10.5 / 19 ]</td>
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
                          <input type="file" id="input-add-file" multiple hidden>
                          <div class="approval-files">
                            <div class="scroll-bar">
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <textarea class="tinymce" id="approval-tiny" name="content" maxlength="3000" >
              </textarea>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" id="btn-save-approval-temporary" class="btn btn-outline-primary">
              임시 저장
            </button>
             <button
               id="btn-temp-return-approval-delete"
               class="btn btn-outline-danger"
             >
               삭제
             </button>
            <button type="button" class="btn-memo-open btn btn-outline-primary">
              메모(0)
            </button>

            <button type="button" id="btn-save-approval" class="btn btn-primary position-ok ms-auto">
              결재/저장
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
		              <div class="input-group mb-3">
		                <input type="text" class="form-control box-shadow-none input-search-member" placeholder="사원번호/이름 입력" >
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
                                <button
                                  class="btn-favor-delete btn btn-outline-primary"
                                >
                                   <div class ="div-minus"></div>
                                </button>
                                <div>
	                                ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
                                </div>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <button
                                  class="btn-favor-delete btn btn-outline-primary"
                                >
                                   <div class ="div-minus"></div>
                                </button>
                                <div>
	                                ㅇㅇㅇㅇㅇㅇ
                                </div>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <button
                                  class="btn-favor-delete btn btn-outline-primary"
                                >
                                   <div class ="div-minus"></div>
                                </button>
                                <div>
	                                ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
                                </div>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                    <div class="selected-lines">
                      <ol class="scroll-bar">
                      </ol>
                      <button
                        id="btn-add-favor"
                        class="btn btn-outline-primary"
                      >
                        즐겨찾기 추가
                      </button>
                    </div>

                    <button id="btn-submit-line" class="btn btn-primary">
                      결제라인 저장
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
                      <button id="btn-save-favor-line" class="btn btn-primary">저장</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <script type="module" src="${path}/resources/js/approval/approvalModal.js"></script>

  </body>
</html>
