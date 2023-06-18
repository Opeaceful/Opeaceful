import { path } from '../common/common.js';
import * as AprFront from './approvalFormFront.js';

let defaultPath = path + '/approval/approvalForm';

export function insertForm(formData) {
  $.ajax({
    url: defaultPath + '/insertForm',
    data: formData,
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    type: 'POST',
    success: function (result) {
      if (result > 0) {
        swal('저장이 완료되었습니다.', {
          buttons: { confirm: '확인' },
        })
        AprFront.clickSelectedBtn();
      } else {
        swal('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.', {
          buttons: { cancel: '확인' },
        });
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
    complete: function () {
      // 에러나든 성공하든 다 끝난 후 버튼 다시 활성화 처리
      document.getElementById('btn-form-save').disabled = false;
    },
  });
}

// 선택한 타입의 폼 총개수 얻어와 버튼 세팅함
export function selectFormListCount(checkType, currentBtnNum) {
  $.ajax({
    url: defaultPath + '/selectFormListCount',
    data: { checkType },
    type: 'POST',
    success: function (count) {
      // 총개수 얻어온 후 버튼 세팅
      AprFront.resetPageBtn(currentBtnNum, count);
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

export function selectFormListPage(actKind, checkType, currentPage) {
  $.ajax({
    url: defaultPath + '/selectFormListPage',
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

export function updateForm(formData) {
  $.ajax({
    url: defaultPath + '/updateForm',
    data: formData,
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    type: 'POST',
    success: function (result) {
      if (result > 0) {
        swal('저장이 완료되었습니다.', {
          buttons: { confirm: '확인' },
        }).then(function () {
          selectForm(formData.get('formNo'));
        });

        AprFront.clickSelectedBtn();
      } else {
        swal('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.', {
          buttons: { cancel: '확인' },
        });
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
    complete: function () {
      // 에러나든 성공하든 다 끝난 후 버튼 다시 활성화 처리
      document.getElementById('btn-form-save').disabled = false;
    },
  });
}

export function deleteFormList(formNoList, currentBtnNum, checkType) {
  $.ajax({
    url: defaultPath + '/deleteForm',
    data: {
      formNoList,
    },
    type: 'POST',
    traditional: true, // 배열 자료형 보낼때 쓰는 옵션
    success: function (result) {
      if (result > 0) {
        selectFormListCount(Number(checkType), Number(currentBtnNum));
        AprFront.closeModal();
        swal('삭제가 완료되었습니다.', {
          buttons: { cancel: '확인' },
        });
      } else {
        swal('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.', {
          buttons: { cancel: '확인' },
        });
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}
