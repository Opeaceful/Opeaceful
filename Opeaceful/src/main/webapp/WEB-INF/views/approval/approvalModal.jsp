<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> -->
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
    <link rel="stylesheet" href="../../../resources/css/common/common.css" />
    <link
      rel="stylesheet"
      href="../../../resources/css/approval/approvalModal.css"
    />
  </head>
  <body>
    <button
      id="test"
      class="btn btn-primary position-btn"
      data-bs-toggle="modal"
      data-bs-target="#add-form"
      type="button"
    >
      양식추가
    </button>

    <div
      class="modal fade"
      id="add-form"
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
          <div class="modal-body">
            <form method="post" action="">
              <div class="info-wrap">
                <table class="write-approval-table table">
                  <tr>
                    <td>
                      <div>일자</div>
                    </td>
                    <td><input type="date" name="" id="" /></td>
                    <td>
                      <div>종류</div>
                    </td>
                    <td>일반</td>
                  </tr>
                  <tr>
                    <td>
                      <div>제목</div>
                    </td>
                    <td colspan="3"><input type="text" /></td>
                  </tr>

                  <tr>
                    <td>
                      <div>결재라인</div>
                    </td>
                    <td colspan="3">
                      <button
                        id="btn-add-form"
                        class="btn btn-outline-primary position-btn"
                        type="button"
                      >
                        <i class="fa-solid fa-plus"></i>선택
                      </button>
                      <div>
                        <div>1. <b>결재</b> 뫄뫄뫄 부장</div>
                        <div>2. 참조 뫄뫄뫄 팀장</div>
                        <div>3. 결재 뫄뫄뫄 과장</div>
                      </div>
                    </td>
                  </tr>

                  <tr>
                    <td>
                      <div>첨부</div>
                    </td>
                    <td colspan="3">
                      <button
                        id="btn-add-form"
                        class="btn btn-outline-primary position-btn"
                        type="button"
                      >
                        <i class="fa-solid fa-plus"></i>첨부
                      </button>
                    </td>
                  </tr>
                </table>
              </div>

              <textarea id="editor" readonly>
                Welcome to TinyMCE!
              </textarea>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              id="btn-save"
              class="btn btn-primary position-ok ms-auto"
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

          <!-- <div id="copy-form">
            <div class="custom-modal">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">
                  양식 복사
                </h1>
                <button type="button" class="btn-close"></button>
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
                    id="btn-copy-save"
                    class="btn btn-outline-primary position-ok ms-auto"
                  >
                    복사
                  </button>
                </div>
              </div>
            </div>
          </div> -->
        </div>
      </div>
    </div>

    <script>
      //todo!! 서버로 내용 저장 시킬때 이미지파일들 따로 저장시키고 img태그 안에 src 내용들도 바꿔껴야함
      // 만약에 수정하면 파일 삭제시키는 것도 들어가야 할듯

      setTimeout(() => {
        document.getElementById("test").click();
      }, 100);
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
