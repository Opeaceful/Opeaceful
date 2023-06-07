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
                  <td width="40%">연차</td>
                  <td width="10%">
                    <div>상태</div>
                  </td>
                  <td width="40%">완결</td>
                </tr>

                <tr>
                  <td width="10%">
                    <div>기안일</div>
                  </td>
                  <td width="40%">
                    <!-- <i class="bi bi-calendar-week"></i><input id="date" /> -->
                    2023-05-16
                  </td>

                  <td width="10%">
                    <div>기안자</div>
                  </td>
                  <td width="30%">김뫄뫄 사원(23051601)</td>
                </tr>
                <tr>
                  <td width="10%">
                    <div>신청일자</div>
                  </td>
                  <td colspan="3" width="40%">
                    <!-- <i class="bi bi-calendar-week"></i><input id="date" /> -->
                    2023-05-16 ~ 2023-05-17
                  </td>
                </tr>
                <tr>
                  <td>
                    <div>참조</div>
                  </td>
                  <td colspan="3">김뫄뫄 사원, 이뫄뫄 사원</td>
                </tr>
                <tr>
                  <td>
                    <div>첨부</div>
                  </td>
                  <td colspan="3">
                    <div class="approval-files">
                      <div class="scroll-bar">
                        <div>
                          fjkdlsjf.jpg
                          <button class="btn-file-download">
                            <i class="bi bi-download"></i>
                          </button>
                        </div>
                        <div>
                          fjkdlsjf.jpg
                          <button class="btn-file-download">
                            <i class="bi bi-download"></i>
                          </button>
                        </div>
                        <div>
                          fjkdlsjf.jpg
                          <button class="btn-file-download">
                            <i class="bi bi-download"></i>
                          </button>
                        </div>
                        <div>
                          fjkdlsjf.jpg
                          <button class="btn-file-download">
                            <i class="bi bi-download"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </td>
                </tr>

                <tr>
                  <td colspan="4">
                    <div></div>
                    <div class="final-approval-wrap">
                      <h2><u>2023년 상반기 A프로젝트 보고서</u></h2>
                      <div class="end-approval-lines">
                        <div class="end-approval-lines-wrap">
                          <div class="end-approval-lines-title">결<br />재</div>
                          <div class="end-approval-lines-item">
                            <div class="approver-name">뫄뫄뫄 사원</div>
                            <div class="approver-sign">
                              <img
                                src="${path}/resources/image/mypage/basic_profile.png"
                                alt=""
                              />
                            </div>
                            <div class="approver-date">2023-05-26</div>
                          </div>
                          <div class="end-approval-lines-item">
                            <div class="approver-name">뫄뫄뫄 부장</div>
                            <div class="approver-sign">
                              <img
                                src="${path}/resources/image/main/absence.svg"
                                alt=""
                              />
                            </div>
                            <div class="approver-date">2023-05-26</div>
                          </div>
                          <div class="end-approval-lines-item">
                            <div class="approver-name">뫄뫄뫄뫄 본부장</div>
                            <div class="approver-sign">
                              <img
                                src="${path}/resources/image/main/absence.svg"
                                alt=""
                              />
                            </div>
                            <div class="approver-date">2023-05-26</div>
                          </div>
                        </div>
                      </div>
                      <div class="end-approval-content">
                        <p>Welcome to TinyMCE!</p>
                        <p><br data-mce-bogus="1" /></p>
                        <p>dddddddddddd</p>
                        <p>d</p>
                        <p>d</p>
                        <p>d</p>
                        <p>d</p>
                        <p>d</p>
                        <p>d</p>
                        <p>d</p>
                        <table
                          style="border-collapse: collapse; width: 100%"
                          border="1"
                        >
                          <tbody>
                            <tr>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%"><br /></td>
                            </tr>
                            <tr>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%"><br /></td>
                            </tr>
                            <tr>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%"><br /></td>
                              <td style="width: 31.3593%">
                                <br data-mce-bogus="1" />
                              </td>
                            </tr>
                          </tbody>
                        </table>
                        <p>d</p>
                        <p><br data-mce-bogus="1" /></p>
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <!-- <button type="button" class="btn btn-primary">결재 취소</button> -->
            <button type="button" class="btn btn-outline-danger">삭제</button>
            <button type="button" class="btn btn-outline-primary">반려</button>
            <button type="button" class="btn btn-outline-primary">
              메모(0)
            </button>
            <button type="button" class="btn btn-outline-primary">인쇄</button>

            <button type="button" class="btn btn-primary position-ok ms-auto">
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

          <!-- 메모모달 구역 -->
          <div id="memo-modal-back" class="modal-back">
            <div id="memo-modal" class="modal-content position-modal">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">메모</h1>
                <button
                  type="button"
                  class="btn-close"
                  id="btn-memo-modal-close"
                ></button>
              </div>
              <div class="modal-body">
                <div class="memo-modal-body">
                  <!-- 메모 리스트 구역 -->
                  <div class="memo-list">
                    <table
                      style="margin-bottom: 0px"
                      class="table table-common"
                    >
                      <thead>
                        <tr>
                          <th>작성자</th>
                          <th>내용</th>
                          <th>등록일</th>
                        </tr>
                      </thead>
                    </table>
                    <table class="table table-common">
                      <tbody class="memo-list-table scroll-bar">
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                        <tr>
                          <td>뫄뫄뫄 사원</td>
                          <td>
                            내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                          </td>
                          <td>2023-05-28</td>
                        </tr>
                      </tbody>
                    </table>
                    <div>
                      <button id="btn-add-memo" class="btn btn-outline-primary">
                        작성
                      </button>
                    </div>
                  </div>
                  <!-- 메모 상세보기/추가 구역 -->
                  <div class="memo-detail">
                    <!-- <h3><</h3> -->
                    <table class="memo-detail-table table table-common">
                      <tbody>
                        <tr>
                          <td>
                            <div>첨부</div>
                          </td>
                          <td>
                            <div class="memo-files-wrap">
                              <button
                                id="btn-memo-add-file"
                                class="btn btn-outline-primary"
                              >
                                추가
                              </button>
                              <div class="memo-files scroll-bar">
                                <div class="memo-file-item">
                                  fjkdlsjfkdlsf.jpg
                                  <!-- <input class="form-control  form-control-sm" type="file" id="formFile"> -->
                                  <button
                                    id="btn-memo-file-delete"
                                    class="btn-file-delete"
                                  >
                                    <i class="fa-solid fa-minus"></i>
                                  </button>
                                </div>
                                <div class="memo-file-item">
                                  <input
                                    class="form-control form-control-sm"
                                    type="file"
                                    id="formFile"
                                  />
                                  <button
                                    id="btn-memo-file-delete"
                                    class="btn-file-delete"
                                  >
                                    <i class="fa-solid fa-minus"></i>
                                  </button>
                                </div>
                              </div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div>내용</div>
                          </td>
                          <td>
                            <textarea
                              name="content"
                              id="memo-content"
                              cols="30"
                              rows="10"
                              maxlength="1000"
                              class="scroll-bar"
                            ></textarea>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <div class="memo-btn-wrap">
                      <button
                        id="btn-memo-back"
                        class="btn btn-outline-primary"
                      >
                        뒤로가기
                      </button>
                      <div>
                        <button
                          id="btn-memo-delete"
                          class="btn btn-outline-primary"
                        >
                          삭제
                        </button>
                        <button id="btn-memo-save" class="btn btn-primary">
                          저장
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 결재/반려 모달구역 -->
          <div id="approval-confirm-back" class="modal-back">
            <div id="confirm-modal" class="modal-content position-modal">
              <div class="modal-header">
                <button
                  type="button"
                  class="btn-close"
                  id="btn-confirm-modal-close"
                ></button>
              </div>
              <div class="modal-body">
                <div class="confirm-body">
                  <h4>결재를 진행하시겠습니까?</h4>
                  <div class="confirm-btn-wrap">
                    <button class="btn btn-primary">확인</button>
                    <button class="btn btn-outline-primary">취소</button>
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
