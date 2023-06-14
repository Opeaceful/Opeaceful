 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/endApprovalModal.css"
    />

  </head>
  <body>
    <!-- [승은] -->

    <div
      class="modal fade"
      id="end-approval"
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
            <h1 class="modal-title fs-5" id="staticBackdropLabel">전자결재</h1>

            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body scroll-bar-none">
            <table class="end-approval-table table">
              <tbody>
                <tr>
                  <td width="10%">
                    <div>종류</div>
                  </td>
                  <td width="40%" id="td-approval-type"></td>
                  <td width="10%">
                    <div >상태</div>
                  </td>
                  <td width="40%" id="td-approval-status"></td>
                </tr>

                <tr>
                  <td width="10%">
                    <div>기안일</div>
                  </td>
                  <td width="40%" id="td-approval-draft-date">
                    2023-05-16
                  </td>

                  <td width="10%">
                    <div>기안자</div>
                  </td>
                  <td width="30%" id="td-approval-user"></td>
                </tr>
                <tr>
                  <td width="10%">
                    <div>신청일자</div>
                  </td>
                  <td id="td-approval-request-date" colspan="3" width="40%">
                    
                  </td>
                </tr>
                <tr>
                  <td>
                    <div>참조</div>
                  </td>
                  <td colspan="3" id="td-approval-refer"></td>
                </tr>
                <tr>
                  <td>
                    <div>첨부</div>
                  </td>
                  <td colspan="3">
                    <div class="approval-files">
                      <div class="scroll-bar">
                      </div>
                    </div>
                  </td>
                </tr>

                <tr>
                  <td colspan="4">
                    <div></div>
                    <div class="final-approval-wrap">
                      <h2 ><u id="h-approval-title"></u></h2>
                      <div class="end-approval-lines">
                        <div class="end-approval-lines-wrap">
                          <div class="end-approval-lines-title">결<br />재</div>
                        </div>
                      </div>
                      <div class="end-approval-content">
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" id="btn-delete-approval" class="btn btn-outline-danger">삭제</button>
            <button type="button" id="btn-return-approval" class="btn btn-outline-primary">반려</button>
            <button type="button" class="btn-memo-open btn btn-outline-primary">
              메모(0)
            </button>
            <button type="button" id="btn-print-approval" class="btn btn-outline-primary">인쇄</button>

            <button type="button" id="btn-authorize-approval" class="btn btn-primary position-ok ms-auto">
              결재
            </button>
            <button
              type="button"
              class="btn btn-outline-primary cancel-common position-cancel can"
              data-bs-dismiss="modal"
              data-bs-target="#add-form"
            >
              닫기
            </button>
          </div>
        </div>
      </div>
    </div>
    
  </body>
</html>
