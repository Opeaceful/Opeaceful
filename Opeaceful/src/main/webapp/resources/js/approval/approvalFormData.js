import { path } from '../common/common.js';
import * as AprFront from './approvalFormFront.js';

let defaultPath = path + '/approval/approvalForm';

export function insertForm(formData) {
  console.log('저장 시작');
  $.ajax({
    url: defaultPath + '/insertForm',
    data: {
      formData,
    },
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    type: 'POST',
    success: function (result) {
      if (result > 0) {
        swal('저장이 완료되었습니다.', {
          buttons: { confirm: '확인' },
        }).then(function (isConfirm) {
          if (isConfirm) {
            window.location.reload();
          }
        });
      } else {
        swal('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.', {
          buttons: { cancel: '확인' },
        });
      }
      // 버튼 다시 활성화 처리
      document.getElementById('btn-form-save').disabled = false;
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

export function selectForm(formNo) {
  $.ajax({
    url: defaultPath + '/selectForm',
    dataType: 'JSON',
    data: {
      formNo,
    },
    type: 'POST',
    success: function (form) {
      AprFront.resetAddForm(form.type, form.title, form.content);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

export function selectFormList(actKind, checkType, currentPage) {
  $.ajax({
    url: defaultPath + '/selectFormList',
    dataType: 'JSON',
    data: {
      checkType,
      currentPage,
    },
    type: 'POST',
    success: function (formList) {
      if (actKind == 'table') {
        AprFront.setTableList(formList);
      } else if (actKind == 'copy') {
        AprFront.setCopyList(formList);
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}
