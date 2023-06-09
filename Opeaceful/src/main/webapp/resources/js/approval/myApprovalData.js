import { path } from '../common/common.js';
import * as MyAprFront from './myApprovalFront.js';

let defaultPath = path + '/approval';

// 멤버 검색
export function selectMemberList(keyword) {
  $.ajax({
    url: `${path}/member/modalAllMemberView`,
    dataType: 'JSON',
    method: 'POST',
    data: {
      keyword,
    },
    success: function (result) {
      MyAprFront.setSelectMemberTable(result);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 양식 조회
export function selectForm(formNo) {
  $.ajax({
    url: defaultPath + '/approvalForm/selectForm',
    dataType: 'JSON',
    data: {
      formNo,
    },
    type: 'POST',
    success: function (form) {
      console.log(form);
      MyAprFront.setApprovalModalContent(form);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 양식 리스트 조회
export function selectFormList(checkType, open) {
  $.ajax({
    url: defaultPath + '/approvalForm/selectFormList',
    dataType: 'JSON',
    data: {
      checkType,
    },
    type: 'POST',
    success: function (formList) {
      MyAprFront.setCopyFormList(formList, open);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 결재라인 조회
// (즐겨찾기용 == "favor" / 실제 결재문서용 == "approval")
export function selectLineList(type, no) {
  $.ajax({
    url: defaultPath + '/selectLineList',
    dataType: 'JSON',
    data: { type, no },
    type: 'POST',
    success: function (list) {
      if (type == 'favor') {
        MyAprFront.setApprovalLines(list);
      } else if (type == 'approval') {
        //  todo! 나중에 쓰일때 작성하기
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 즐겨찾기리스트 조회 (로그인한 유저 정보 기반으로 조회해옴)
export function selectFavorList() {
  $.ajax({
    url: defaultPath + '/selectFavorList',
    dataType: 'JSON',
    type: 'POST',
    success: function (favorList) {
      MyAprFront.setFavorList(favorList);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 즐겨찾기 저장
export function insertFavor(favor) {
  $.ajax({
    url: defaultPath + '/insertFavor',
    traditional: true,
    data: {
      title: favor.title,
      levelList: favor.level,
      typeList: favor.type,
      userNoList: favor.userNo,
    },
    type: 'POST',
    success: function (result) {
      if (result > 0) {
        // 성공
        swal('즐겨찾기가 저장되었습니다.', {
          buttons: { cancel: '확인' },
        });

        // 즐겨찾기 리스트 재조회 해서 뿌려주기
        selectFavorList();
      } else {
        swal('즐겨찾기 저장에 실패하였습니다. 다시 시도해주세요.', {
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

// 즐겨찾기 삭제
export function deleteFavor(favorNo) {
  $.ajax({
    url: defaultPath + '/deleteFavor',
    dataType: 'JSON',
    data: { favorNo },
    type: 'POST',
    success: function (result) {
      if (result > 0) {
        // 성공
        swal('즐겨찾기가 삭제되었습니다.', {
          buttons: { cancel: '확인' },
        });

        // 즐겨찾기 리스트 재조회 해서 뿌려주기
        selectFavorList();
      } else {
        swal('즐겨찾기 삭제에 실패하였습니다. 다시 시도해주세요.', {
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

// 결재 문서 저장
export function insertApproval(formData) {
  $.ajax({
    url: defaultPath + '/insertApproval',
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
          // todo! 저장 완료시 이후 동작 추후 추가
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
    // complete: function () {
    //   // 에러나든 성공하든 다 끝난 후 버튼 다시 활성화 처리
    //   document.getElementById('btn-form-save').disabled = false;
    // },
  });
}
