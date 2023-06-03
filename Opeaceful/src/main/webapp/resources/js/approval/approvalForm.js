import * as Tiny from './tinyEditor.js';
import { path } from '../common/common.js';

let sendForm = function () {
  $.ajax({
    url: path + '/approvalForm/insertForm',
  });
};

// 양식추가 폼 내용 리셋 함수
let clearAddForm = function (
  formType = 'nomal',
  formName = '',
  content = '',
  btnText = '저장',
  btnValue = '0'
) {
  //기본적으로 양식 종류 일반 셀렉트
  document.querySelector('#form-type').value = formType;

  // 양식명 리셋
  document.getElementById('form-name').value = formName;

  // 에디터 내용 리셋
  tinymce.activeEditor.setContent(content);

  // 버튼명, 값 바꾸기
  document.getElementById('btn-form-save').innerText = btnText;
  document.getElementById('btn-form-save').value = btnValue;
};

// 모달 안의 이벤트들 모음
let setFormModalInnerEvent = function () {
  // 양식복사창 열기 버튼 이벤트 부여
  document
    .getElementById('btn-copy-form')
    .addEventListener('click', function () {
      // todo! 열기전에 복사할 양식 리스트 서버에서 불러다가 세팅시켜야함

      document.getElementById('copy-form').style.display = 'flex';
    });

  // 양식복사창 닫기 버튼 이벤트 부여
  document
    .getElementById('btn-close-copy-form')
    .addEventListener('click', function () {
      document.getElementById('copy-form').style.display = 'none';
    });

  // 양식선택 후 복사버튼 이벤트 부여
  document
    .getElementById('btn-copy-reflect')
    .addEventListener('click', function () {
      // todo! 양식선택하고 저장버튼 눌렀을 때 이벤트
      let seleted = document.getElementById('copy-select').value;
      console.log(seleted);
    });

  // 양식 모달 저장버튼 이벤트
  document
    .getElementById('btn-form-save')
    .addEventListener('click', function () {
      // 이미지 태그안에 저장된 파일 리스트 돌려받는 함수
      let finalData = Tiny.returnFormData('form-tiny');

      console.log(
        '최종 이미지 파일 리스트 ',
        finalData.formData.getAll('image')
      );

      // todo! 텍스트에디터 내용 포함해서 db에 저장시키기
      if (this.value == '0') {
        console.log('신규');
      } else {
        console.log('수정');
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
    console.log(this, ischecked, inputArr);

    for (let input of inputArr) {
      input.checked = ischecked;
    }
  });

  // 타입 셀렉트박스 값 변경시 실행할 이벤트
  document
    .getElementById('select-show-type')
    .addEventListener('change', function () {
      console.log(this.value);
      // todo! 값 변경될때마다 새로 테이블 꾸며주기
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

        Tiny.resetInputFileList();

        // todo! 내용 세팅 끝난 후  모달 오픈
        $('#add-form-modal').modal('show');
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

      console.log(this, inputArr);
      // todo! 선택된 리스트 삭제

      swal('선택된 양식을 삭제 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          console.log('todo 삭제시작하기');
        }
      });
    });

  // 신규양식추가버튼 이벤트 부여
  document
    .getElementById('btn-open-add-form')
    .addEventListener('click', function () {
      Tiny.resetInputFileList();
      clearAddForm();
    });
};

//-------------------- 윈도우 시작시 이벤트 부여 --------------------
window.onload = function () {
  Tiny.setTinymce();
  clearAddForm();
  setDefaultEvent();
  setFormModalInnerEvent();
};
