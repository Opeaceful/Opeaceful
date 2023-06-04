let InputFileList = [];

export function resetInputFileList() {
  InputFileList = [];
}

export function getInputFileList() {
  return InputFileList;
}

export function setTinymce() {
  var plugins = [
    'advlist',
    // "autolink",
    // "lists",
    // "link",
    'image',
    'charmap',
    // "print",
    'preview',
    // "anchor",
    'searchreplace',
    'visualblocks',
    // "code",
    'fullscreen',
    'insertdatetime',
    // "media",
    'table',
    'paste',
    // "code",
    // "help",
    // "wordcount",
    'save',
  ];
  var edit_toolbar =
    'formatselect fontselect fontsizeselect |' +
    ' forecolor backcolor |' +
    ' bold italic underline strikethrough |' +
    ' alignjustify alignleft aligncenter alignright |' +
    ' bullist numlist |' +
    ' table tabledelete |' +
    ' image';

  tinymce.init({
    language: 'ko_KR', //한글판으로 변경
    selector: '.tinymce',
    height: 500,
    // menubar: false,
    plugins: plugins,
    toolbar: edit_toolbar,
    maxlength: 3000,
    setup: function (editor) {
      // 최대 입력글자수 이상 넘어가면 더이상 글자 입력 안되게 막음
      editor.on('keydown', function (e) {
        var content =
          editor.contentDocument.getElementById('tinymce').innerHTML;

        // approval테이블의 경우 최대 4000글자지만 img src등을 갈아끼우는 등의처리를 하게되므로
        // 여유분을 남기기위해 3000으로 글자 제한함
        var maxLength = 3000;
        console.log(content.length);
        if (content.length >= maxLength - 1) {
          // delete 키가 백스페이스키가 아니면 키 입력 막음
          if (e.key != 'Delete' && e.key != 'Backspace') {
            e.preventDefault();
            swal('최대 입력가능한 글자수를 초과하였습니다.', {
              buttons: { cancel: '확인' },
            });
          }
        }
      });
    },

    /*** image upload ***/
    image_title: true,
    /* enable automatic uploads of images represented by blob or data URIs*/
    automatic_uploads: true,
    /*
      URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
      images_upload_url: 'postAcceptor.php',
      here we add custom filepicker only to Image dialog
    */
    file_picker_types: 'image',
    /* and here's our custom image picker*/
    file_picker_callback: function (cb, value, meta) {
      var input = document.createElement('input');
      input.setAttribute('type', 'file');
      input.setAttribute('accept', 'image/*');

      /*
        Note: In modern browsers input[type="file"] is functional without
        even adding it to the DOM, but that might not be the case in some older
        or quirky browsers like IE, so you might want to add it to the DOM
        just in case, and visually hide it. And do not forget do remove it
        once you do not need it anymore.
      */
      input.onchange = function () {
        var file = this.files[0];

        var reader = new FileReader();
        reader.onload = function () {
          /*
            Note: Now we need to register the blob in TinyMCEs image blob
            registry. In the next release this part hopefully won't be
            necessary, as we are looking to handle it internally.
          */
          var id = 'blobid' + new Date().getTime();
          var blobCache = tinymce.activeEditor.editorUpload.blobCache;
          var base64 = reader.result.split(',')[1];
          var blobInfo = blobCache.create(id, file, base64);

          blobCache.add(blobInfo);

          /* call the callback and populate the Title field with the file name */
          cb(blobInfo.blobUri(), { title: file.name });

          InputFileList.push({
            src: blobInfo.blobUri(),
            file: file,
          });

          console.log(InputFileList);
        };
        reader.readAsDataURL(file);
      };
      //위에서 만든 인풋 타입 파일인 요소에 클릭 줌
      input.click();
    },
    /*** image upload ***/

    content_style:
      'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }',
  });
}

// 본문에 등록되어있던 이미지들 실제 파일을 FormData로 + 내용부분 입력값 리턴
export function returnFormData(tinyId) {
  /*
        tinymce.triggerSave() : textarea에 내용 매핑시키는 함수인듯 
                              이거 안하면 textarea 내용 그냥 태그없이 문자열로만 찍힘
        tinymce.activeEditor : 에디터 하나일때 사용
        tinymce.get('아이디값') :  에디터 여러개일때 사용
        tinymce.activeEditor.setContent(html 문자열로); : 에디터에 원하는 문자열 세팅
      

        글자 확인 
        tinymce.activeEditor.getContent()    
        tinymce.get('tinymce').getContent() 
        //위 두개는 tinymce에서 제공해주는거 
          -> 이걸로 blob으로 저장된 파일 찍으면 글자 몇만개 나옴.... 비추 

        tinymce.activeEditor.contentDocument.getElementById('tinymce').innerHTML
        document.querySelector('.tinymce').value   

      */

  // input의  FileList는 내용 변경이 불가하고 통째로 갈아끼는것만 가능함
  // 그래서 이럴때 DataTransfer를 생성해서 갈아껴주는 용도로 사용한다
  // 서버로 넘기기 위한 input태그에 파일들 옮겨담기는 아래와 같이 하면 됨
  // let dataTransfer = new DataTransfer();
  // dataTransfer.items.add(file); // 이런식으로 파일들을 담음
  // document.getElementById('인풋요소 아이디').files = dataTransfer.files; // 인풋 파일리스트 갈아끼기

  let dataTransfer = new DataTransfer();
  // dataTransfer.items.add(file); // 이런식으로 파일들을 담음
  // document.getElementById('인풋요소 아이디').files = dataTransfer.files; // 인풋 파일리스트 갈아끼기

  // 하지만 여기서는 파일들을 리스트화해서 바로 서버로 전송하려고 하기 때문에 FormData를 사용함
  // form 태그를 사용해서 숨겨둔 인풋요소의 값을 전송시킬거면 DataTransfer로 사용할것
  let formData = new FormData();
  let fileList = [...InputFileList]; // 얕은복사
  let imgArr = tinymce.get(tinyId).contentDocument.getElementsByTagName('img');

  // 본문내용의 이미지들을 돌면서 등록된 파일들을 찾음
  for (let img of imgArr) {
    let imgSrc = img.src;
    // 신규로 추가된 이미지들의 src는 blob로 시작되도록 해두었음
    // -> 신규로 추가된게 아니라면 굳이 파일을 찾을 이유가 없으므로 패스
    if (imgSrc.startsWith('blob')) {
      for (let i in fileList) {
        // 만약 파일리스트에 저장된 src와 현재 이미지 src가 같다면 파일을 서버로넘길 dataTransfer리스트에 저장
        if (fileList[i].src == imgSrc) {
          dataTransfer.items.add(fileList[i].file);
          // formData.append('images', fileList[i].file);
          // 저장했으면 기존 배열에서는 해당 아이템 삭제
          fileList.splice(i, 1);

          // 현재 이미지 태그의 src를 서버로넘길 dataTransfer리스트 인덱스값으로 변경
          // -> 서버에서 다시한번 확인하면서 인덱스값을 실제 src값으로 바꾸어줄 예정
          img.src = dataTransfer.items.length - 1;
          console.log('dataTransfer 아이템 길이 ', dataTransfer.items.length);
          break;
        }
      }
    }
  }
  // formData에 본문내용 담아주기
  // formData.append('content', tinymce.get(tinyId).getContent());

  // 정보 뽑아내기 끝나면 다음을 위해 파일리스트 비우기
  resetInputFileList();

  return dataTransfer;
}
