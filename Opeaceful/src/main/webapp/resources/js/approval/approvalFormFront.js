import * as Tiny from './tinyEditor.js';
import * as AprData from './approvalFormData.js';
import { path } from '../common/common.js';

// 양식추가 폼 내용 리셋 함수
export function resetAddForm(
  formType = '0',
  formTitle = '',
  content = '',
  btnText,
  btnValue
) {
  //기본적으로 양식 종류 일반 셀렉트
  document.querySelector('#form-type').value = formType;

  // 양식명 리셋
  document.getElementById('form-name').value = formTitle;

  // 에디터 내용 리셋
  tinymce.activeEditor.setContent(content);
  if (content != '') {
    tinymce.triggerSave();
    changeImgPath();
  }

  // 버튼명, 값 바꾸기
  if (btnText != null) {
    document.getElementById('btn-form-save').innerText = btnText;
  }
  if (btnValue != null) {
    document.getElementById('btn-form-save').value = btnValue;
  }
}

// 서버에서 가져온 이미지 src 경로 재설정 해주는 함수
// path경로가 변경될 경우를 대비
let changeImgPath = function () {
  let imgArr = tinymce
    .get('form-tiny')
    .contentDocument.getElementsByTagName('img');

  if (imgArr) {
    for (let img of imgArr) {
      let imgSrc = img.src;
      // 신규로 추가된 이미지들의 src는 blob로 시작되도록 해두었음
      // 그외 / 로 시작하지 않는 기존 이미지들 src 갈아끼기
      if (!imgSrc.startsWith('blob')) {
        // 이미지 실제 이름만 가져옴
        imgSrc = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);

        // 이미지 경로 재설정
        img.src = path + '/resources/file/approval/' + imgSrc;
      }
    }
  }
};

// 양식 테이블 아이템 갈아끼기
export function setTableList(formList) {
  let tableHtml = '';

  if (formList != null && formList.length > 0) {
    for (let form of formList) {
      switch (form.type) {
        case 0:
          form.type = '일반';
          break;
        case 1:
          form.type = '연차';
          break;
        case 2:
          form.type = '오전반차';
          break;
        case 3:
          form.type = '오후반차';
          break;
      }

      tableHtml += `<tr>
                      <td>
                        <input type="checkbox" value="${form.formNo}" />
                      </td>
                      <td>
                        <div>${form.title}</div>
                      </td>
                      <td>${form.type}</td>
                    </tr>`;
    }
  } else {
    tableHtml = `<tr>
                    <td colspan="3">등록된 양식이 없습니다.</td>
                  </tr>`;
  }
  console.log(tableHtml);
  document.querySelector('.approval-form-table tbody').innerHTML = tableHtml;
}

//복사리스트에 아이템 갈아끼기
export function setCopyList(formList) {
  let optionHtml = '';

  if (formList && formList.length > 0) {
    for (let form of formList) {
      optionHtml += `<option value="${form.formNo}">${form.title}</option>`;
    }
  } else {
    optionHtml = `<option value="-1">선택가능한 양식이 없습니다.</option>`;
  }

  document.getElementById('copy-select').innerHTML = optionHtml;

  // 복사창 열기
  document.getElementById('copy-form').style.display = 'flex';
}

// --------------------------------------- 이벤트 할당구역 ------------------------------

// 모달 안의 이벤트들 모음
let setFormModalInnerEvent = function () {
  // 양식복사창 열기 버튼 이벤트 부여
  document
    .getElementById('btn-copy-form')
    .addEventListener('click', function () {
      AprData.selectFormList('copy');
    });

  // 양식복사창 닫기 버튼 이벤트 부여
  document
    .getElementById('btn-close-copy-form')
    .addEventListener('click', function () {
      document.getElementById('copy-form').style.display = 'none';
    });

  // 양식복사창 양식선택 후 복사버튼 이벤트 부여
  document
    .getElementById('btn-copy-reflect')
    .addEventListener('click', function () {
      // 양식선택하고 저장버튼 눌렀을 때 선택된 것
      let seleted = document.getElementById('copy-select').value;

      if (seleted != '-1') {
        AprData.selectForm(seleted);
      }

      document.getElementById('copy-form').style.display = 'none';
    });

  // 양식 모달 저장버튼 이벤트
  document
    .getElementById('btn-form-save')
    .addEventListener('click', function () {
      let title = document.getElementById('form-name').value;

      // 만약 타이틀에 작성된 내용이 없다면 리턴
      if (title.trim() == '') {
        swal('양식명을 입력해주세요', {
          buttons: { cancel: '확인' },
        });
        return;
      }

      // 혹시 모를 중복 클릭을 막기위해 버튼 비활성화 처리
      this.disabled = true;

      // 이미지 태그안에 저장된 파일 리스트 돌려받는 함수
      let finalData = Tiny.returnFormData('form-tiny');
      // 신규 추가
      finalData.append('title', title);
      finalData.append('type', document.getElementById('form-type').value);

      console.log('버튼 value ', this.value);

      // todo! 텍스트에디터 내용 포함해서 db에 저장시키기
      if (this.value == '0') {
        // 폼 저장 전송
        AprData.insertForm(finalData);
      } else {
        // 폼 수정
        finalData.append('formNo', Number(this.value));
        AprData.updateForm(finalData);
      }
    });

  // 양식 모달 삭제버튼 이벤트
  document
    .getElementById('btn-form-delete')
    .addEventListener('click', function () {
      swal('현재 문서를 삭제하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          let formNoList = [document.getElementById('btn-form-save').value];
          AprData.deleteFormList(formNoList);
        }
      });
    });

  // 모달 취소버튼, 닫기버튼 클릭시 tinymce에서 열려있는 더보기 메뉴도 없애기
  document
    .querySelector('.modal-footer > .cancel-common')
    .addEventListener('click', function () {
      if (document.querySelector('body > .tox-tinymce-aux')) {
        document.querySelector('body > .tox-tinymce-aux').innerHTML = '';
      }
    });
  document
    .querySelector('.modal-header .btn-close')
    .addEventListener('click', function () {
      if (document.querySelector('body > .tox-tinymce-aux')) {
        document.querySelector('body > .tox-tinymce-aux').innerHTML = '';
      }
    });
};

// 기본 이벤트틀 모음
let setDefaultEvent = function () {
  // 체크박스 전체선택/해제용 이벤트
  document.getElementById('check-all').addEventListener('click', function () {
    let ischecked = this.checked;
    let inputArr = document.querySelectorAll(
      ".approval-form-table tbody input[type='checkbox']"
    );

    for (let input of inputArr) {
      input.checked = ischecked;
    }
  });

  // 선택된 리스트 삭제 버튼에 이벤트 부여
  document
    .getElementById('btn-delete-selected-form')
    .addEventListener('click', function () {
      let inputArr = [];
      document
        .querySelectorAll(
          ".approval-form-table tbody input[type='checkbox']:checked"
        )
        .forEach((input) => {
          inputArr.push(Number(input.value));
        });

      swal('선택된 양식을 삭제 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          AprData.deleteFormList(inputArr);
        }
      });
    });

  // 타입 셀렉트박스 값 변경시 실행할 이벤트
  document
    .getElementById('select-show-type')
    .addEventListener('change', function () {
      console.log(this.value);
      AprData.selectFormList('table', this.value, 1);

      // todo! 페이지 버튼 1번 눌린걸로 처리하기
      // + 버튼들 만들어야함....
    });

  // 양식 리스트 테이블의 td 눌렸을때 이벤트 부여
  document
    .querySelector('.approval-form-table tbody')
    .addEventListener('click', function (e) {
      console.log(e.target.tagName);

      // 눌린게 td태그이면서 안에 텍스트 값이 있을때만 동작하도록 막음
      // -> checkbox 있는 곳 td는 눌려도 반응하지 않도록 한 것임
      if (
        (e.target.tagName == 'TD' || e.target.tagName == 'DIV') &&
        e.target.innerText != ''
      ) {
        // todo! 눌린거 체크박스 value값에 대응되는 양식 찾아서 그 내용대로 창 열어주기
        console.log(
          e.target,
          ' td눌림',
          e.target.closest('tr').querySelector("input[type='checkbox']")
        );
        let formNo = e.target
          .closest('tr')
          .querySelector("input[type='checkbox']").value;
        resetAddForm(undefined, undefined, undefined, '수정', formNo);

        AprData.selectForm(formNo);
        document.getElementById('btn-form-delete').style.display = 'block';

        Tiny.resetInputFileList();

        // todo! 내용 세팅 끝난 후  모달 오픈
        $('#add-form-modal').modal('show');
      }
    });

  // 신규양식추가버튼 이벤트 부여
  document
    .getElementById('btn-open-add-form')
    .addEventListener('click', function () {
      Tiny.resetInputFileList();
      document.getElementById('btn-form-delete').style.display = 'none';
      resetAddForm(undefined, undefined, undefined, '저장', 0);
    });
};

//-------------------- 윈도우 시작시 이벤트 부여 --------------------
window.onload = function () {
  Tiny.setTinymce();
  resetAddForm();
  setDefaultEvent();
  setFormModalInnerEvent();
};
