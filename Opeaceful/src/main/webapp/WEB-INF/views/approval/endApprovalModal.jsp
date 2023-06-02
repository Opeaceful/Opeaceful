 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    
     <!-- tiny editor -->
    <script
      src="https://cdn.tiny.cloud/1/4u88c1x1vlsys5jtx9tpp86cmfiahnx5rgsxendvyyqg2464/tinymce/5/tinymce.min.js"
      referrerpolicy="origin"
    ></script>


    <!-- css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"
    />

    <!-- js -->
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

    <script>
      //todo!! 서버로 내용 저장 시킬때 이미지파일들 따로 저장시키고 img태그 안에 src 내용들도 바꿔껴야함
      // 만약에 수정하면 파일 삭제시키는 것도 들어가야 할듯

      test1();
      let downloadPic = function (url, name) {
        const img = new Image();
        const canvas = document.createElement("canvas");
        const ctx = canvas.getContext("2d");
        img.onload = function () {
          canvas.width = this.width;
          canvas.height = this.height;
          ctx.drawImage(this, 0, 0);

          const elt = document.createElement("a");
          elt.setAttribute("href", canvas.toDataURL("image/png"));
          elt.setAttribute("download", `${name}.png`);
          elt.style.display = "none";
          document.body.appendChild(elt);
          elt.click();
          document.body.removeChild(elt);
        };
        img.crossOrigin = "anonymous";
        img.src = url;
      };

      function test1() {
        var plugins = [
          "advlist",
          // "autolink",
          // "lists",
          // "link",
          "image",
          "charmap",
          // "print",
          "preview",
          // "anchor",
          "searchreplace",
          "visualblocks",
          // "code",
          "fullscreen",
          "insertdatetime",
          // "media",
          "table",
          "paste",
          // "code",
          // "help",
          // "wordcount",
          "save",
        ];
        var edit_toolbar =
          "formatselect fontselect fontsizeselect |" +
          " forecolor backcolor |" +
          " bold italic underline strikethrough |" +
          " alignjustify alignleft aligncenter alignright |" +
          " bullist numlist |" +
          " table tabledelete |" +
          " image";

        tinymce.init({
          language: "ko_KR", //한글판으로 변경
          selector: "#tinymce",
          height: 500,
          // menubar: false,
          plugins: plugins,
          toolbar: edit_toolbar,

          /*** image upload ***/
          image_title: true,
          /* enable automatic uploads of images represented by blob or data URIs*/
          automatic_uploads: true,
          /*
              URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
              images_upload_url: 'postAcceptor.php',
              here we add custom filepicker only to Image dialog
          */
          file_picker_types: "image",
          /* and here's our custom image picker*/
          file_picker_callback: function (cb, value, meta) {
            console.log("test1");
            var input = document.createElement("input");
            input.setAttribute("type", "file");
            input.setAttribute("accept", "image/*");

            /*
              Note: In modern browsers input[type="file"] is functional without
              even adding it to the DOM, but that might not be the case in some older
              or quirky browsers like IE, so you might want to add it to the DOM
              just in case, and visually hide it. And do not forget do remove it
              once you do not need it anymore.
              */
            input.onchange = function () {
              console.log("test2");
              console.log("test");
              var file = this.files[0];

              var reader = new FileReader();
              reader.onload = function () {
                /*
                      Note: Now we need to register the blob in TinyMCEs image blob
                      registry. In the next release this part hopefully won't be
                      necessary, as we are looking to handle it internally.
                      */
                var id = "blobid" + new Date().getTime();
                var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                var base64 = reader.result.split(",")[1];
                var blobInfo = blobCache.create(id, file, base64);

                blobCache.add(blobInfo);

                /* call the callback and populate the Title field with the file name */
                cb(blobInfo.blobUri(), { title: file.name });
                console.log(blobInfo.blobUri());
              };
              reader.readAsDataURL(file);

              // 여기에 이미지 넣으면 어디로 저장 될지 넣어야하는듯
            };
            //위에서 만든 인풋 타입 파일인 요소에 클릭 줌
            input.click();
          },
          /*** image upload ***/

          content_style:
            "body { font-family:Helvetica,Arial,sans-serif; font-size:14px }",
        });

        $("#save").on("click", function () {
          var content = tinymce.activeEditor.getContent();
          console.log(
            tinymce.activeEditor.contentDocument.getElementById("tinymce")
              .innerHTML
          );
        });
      }

      function test2() {
        var tinyEditor = tinymce.init({
          selector: "#tinymce",
          min_height: 500,
          max_height: 1000,
          menubar: false,
          paste_as_text: true,
          fullpage_default_font_size: "14px",
          branding: false,
          plugins:
            "autolink code link autoresize paste contextmenu image preview",
          toolbar:
            "undo redo | fontsizeselect | forecolor | bold italic strikethrough underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link custom_image | code preview",
          fontsize_formats:
            "10px 12px 14px 16px 18px 20px 22px 24px 28px 32px 36px 48px",
          setup: function (editor) {
            editor.ui.registry.addButton("custom_image", {
              icon: "image",
              tooltip: "insert Image",
              onAction: function () {
                // 이미지 버튼이 눌렸을 때 처리하는 곳
                console.log("test");
                // documentUpload({
                //   multiple: false,
                //   accept: ".jpg, .png",
                //   callback: function (data) {
                //     if (data.rs_st === 0) {
                //       var fileInfo = data.rs_data;
                //       tinymce.execCommand(
                //         "mceInsertContent",
                //         false,
                //         /**
                //                        "<img src='" + fileInfo.fullPath + "' data-mce-src='" + fileInfo.fullPath + "' data-originalFileName='" + fileInfo.orgFilename + "' >");
                //                        **/
                //         "<img src='" +
                //           fileInfo.thumbnailPath +
                //           "' data-mce-src='" +
                //           fileInfo.thumbnailPath +
                //           "' data-originalFileName='" +
                //           fileInfo.orgFilename +
                //           "' >"
                //       );
                //     }
                //   },
                // });
              },
            });
          },
        });
      }

      $("#date").daterangepicker();

      $("#date").daterangepicker({
        locale: {
          separator: " ~ ", // 시작일시와 종료일시 구분자
          format: "YYYY-MM-DD", // 일시 노출 포맷
          applyLabel: "확인", // 확인 버튼 텍스트
          cancelLabel: "취소", // 취소 버튼 텍스트
          daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
          monthNames: [
            "1월",
            "2월",
            "3월",
            "4월",
            "5월",
            "6월",
            "7월",
            "8월",
            "9월",
            "10월",
            "11월",
            "12월",
          ],
        },
        timePicker: false, // 시간 노출 여부
        showDropdowns: true, // 년월 수동 설정 여부
        autoApply: true, // 확인/취소 버튼 사용여부
        timePicker24Hour: true, // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
        timePickerSeconds: true, // 초 노출 여부
        // singleDatePicker: true, // 하나의 달력 사용 여부
      });

      $("#date").on("show.daterangepicker", function (ev, picker) {
        $(".yearselect").css("float", "left");
        $(".monthselect").css("float", "right");
        $(".cancelBtn").css("float", "right");
      });
      
      
      $('.modal-backdrop').last().css("display", "none");
    </script>

    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
    <!-- <script src="${contextPath}/resources/js/orgChartEnroll.js"></script> -->
  </body>
</html>
