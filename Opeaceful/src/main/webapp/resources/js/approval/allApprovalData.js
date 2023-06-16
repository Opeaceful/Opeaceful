import * as AllAprFront from './allApprovalFront.js';
import { path } from '../common/common.js';

let defaultPath = path + '/approval';

// 멤버 검색
export function selectMemberList(keyword, ismodalOpen) {
  $.ajax({
    url: `${path}/member/modalAllMemberView`,
    dataType: 'JSON',
    method: 'POST',
    data: {
      keyword,
    },
    success: function (result) {
      AllAprFront.setSelectMemberTable(result, ismodalOpen);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 결재리스트 검색
export function searchApprovalList(userNo, year, type, page, status, keyword) {
  $.ajax({
    url: `${path}/approval/searchApprovalList`,
    dataType: 'JSON',
    method: 'POST',
    data: {
      userNo,
      year,
      type,
      page,
      status,
      keyword,
    },
    success: function (result) {
      console.log(result);
      AllAprFront.setTableList(result.list, result.count, page);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 선택한 결재 문서 세부 내용 조회
export function selectApproval(approvalNo) {
  $.ajax({
    url: defaultPath + '/selectApproval',
    dataType: 'JSON',
    type: 'POST',
    data: { approvalNo, isAdmin: 'admin' },
    success: function (result) {
      AllAprFront.setEndApprovalModal(
        result.approval,
        result.lines,
        result.files
      );
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 메모 저장
export function insertMemo(formData) {
  $.ajax({
    url: defaultPath + '/insertMemo',
    dataType: 'JSON',
    type: 'POST',
    data: formData,
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    success: function (result) {
      if (result > 0) {
        swal('저장이 완료되었습니다.', {
          buttons: { cancel: '확인' },
        });

        selectMemoList(formData.get('approvalNo'));
        AllAprFront.selectMemoListPage();
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

// 메모 리스트 조회
export function selectMemoList(approvalNo) {
  $.ajax({
    url: defaultPath + '/selectMemoList',
    dataType: 'JSON',
    type: 'POST',
    data: { approvalNo },
    success: function (memoList) {
      AllAprFront.setMemoList(memoList);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 개별 메모 조회
export function selectMemo(memoNo) {
  $.ajax({
    url: defaultPath + '/selectMemo',
    dataType: 'JSON',
    type: 'POST',
    data: { memoNo },
    success: function (result) {
      AllAprFront.setMemoContent(result.memo, result.files, result.loginUser);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

//  메모 삭제
export function deleteMemo(memoNo, approvalNo) {
  $.ajax({
    url: defaultPath + '/deleteMemo',
    dataType: 'JSON',
    type: 'POST',
    data: { memoNo },
    success: function (result) {
      if (result > 0) {
        swal('삭제가 완료되었습니다.', {
          buttons: { cancel: '확인' },
        });

        selectMemoList(approvalNo);
        AllAprFront.selectMemoListPage();
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

// 메모 업데이트
export function updateMemo(formData) {
  $.ajax({
    url: defaultPath + '/updateMemo',
    dataType: 'JSON',
    type: 'POST',
    data: formData,
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    success: function (result) {
      if (result > 0) {
        swal('저장이 완료되었습니다.', {
          buttons: { cancel: '확인' },
        });

        selectMemoList(formData.get('approvalNo'));
        AllAprFront.selectMemoListPage();
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

// 결재 문서 삭제
export function deleteApproval(approvalNo) {
  $.ajax({
    url: defaultPath + '/deleteApproval',
    dataType: 'JSON',
    type: 'POST',
    data: {
      approvalNo,
    },
    success: function (result) {
      if (result > 0) {
        swal('삭제가 완료되었습니다.', {
          buttons: { cancel: '확인' },
        });

        AllAprFront.closeApprovalModal();
        AllAprFront.clickCurrentPageBtn();
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
