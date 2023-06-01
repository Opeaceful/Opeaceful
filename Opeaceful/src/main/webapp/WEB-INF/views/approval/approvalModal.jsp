<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script
      src="https://cdn.tiny.cloud/1/4u88c1x1vlsys5jtx9tpp86cmfiahnx5rgsxendvyyqg2464/tinymce/5/tinymce.min.js"
      referrerpolicy="origin"
    ></script>

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
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="${path}/resources/css/common/common.css" />
    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/approvalModal.css"
    />

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

    <!-- <link rel="stylesheet" href="${path}/resources/css/common/common.css" /> -->
    <!-- <link
      rel="stylesheet"
      href="${path}/resources/css/approval/endApprovalModal.css"
    />
    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/myApproval.css"
    /> -->
    <link
      rel="stylesheet"
      href="${path}/resources/css/approval/approvalModal.css"
    />
  </head>
  <body>
    <!-- [승은] -->
    <!-- <button
      id="test"
      class="btn btn-primary position-btn"
      data-bs-toggle="modal"
      data-bs-target="#approval"
      type="button"
    >
      양식추가
    </button> -->


    <!-- <div
      class="modal fade"
      id="staticBackdrop"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div
        class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
      ></div>
    </div> -->

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
                        <input type="text" name="title" id="approval-title" />
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
                                <button class="btn-file-delete">
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

              <textarea id="editor" readonly>
                Welcome to TinyMCE!
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
              class="btn btn-outline-primary cancel-common position-cancel can"
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
                <button type="button" class="btn-close"></button>
              </div>
              <div class="modal-body">
                <div class="line-wrap">
                  <div class="org-chart">
                    <div>
                      <table class="org-table-head table table-common">
                        <thead>
                          <th width="50%">부서</th>
                          <th width="50%">사원</th>
                        </thead>
                      </table>
                    </div>
                    <div class="org-table-content scroll-bar-none">
                      <table class="table table-common">
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
          selector: "#editor",
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
          selector: "#editor",
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
