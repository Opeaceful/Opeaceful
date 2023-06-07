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
