import { path } from '../common/common.js';
import * as MyAprFront from './myApprovalFront.js';

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
