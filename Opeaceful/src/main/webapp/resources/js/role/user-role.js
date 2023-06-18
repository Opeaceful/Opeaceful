/*
 * 작성자 윤지영
 * uesr권한부여 JS
 */

import { path } from "../common/common.js";
import { checkMemberNo } from "../common/memberSelect.js";

//확인 버튼 눌렀을때 allview에서 처리할 이벤트
$("#all-member-modal-button").click(function () {
  if (checkMemberNo.length > 1) {
    swal("한명만 선택해주세요");
  } else {
    location.href = `${path}/role/selectMRole/${checkMemberNo[0]}`;
  }
});

//권한변경될때마다 ajax호출
$("#uesr-granting-table input").click(function (e) {
  userRoleGranting(e.target.id, e.target.checked);
});

function userRoleGranting(id, checked) {
  $.ajax({
    url: `${path}/role/userRoleGranting`,
    dataType: "JSON",
    method: "post",
    data: {
      userNo: uesrNo,
      roleCode: id,
      checked: checked,
    },
    success: function (result) {
      if (result > 0) {
        if (checked) {
          swal("권한이 등록되었습니다.");
        } else {
          swal("권한이 삭제되었습니다.");
        }
      } else {
        swal(
          "권한 수정이 실패하였습니다. 지속적으로 발생한다면 담당자에게 문의하세요."
        );
      }
    },
    error: function (request) {
      console.log(request.status);
      swal(
        "데이터 로딩에 실패했습니다.",
        "지속적으로 발생시 담당자에게 문의하세요."
      );
    },
  });
}

$("#member-search-keyword").on("keyup", function(event) {
  if (event.key === "Enter") {
    event.preventDefault();
    if(checkMemberNo.length == 1){
      location.href = `${path}/role/selectMRole/${checkMemberNo[0]}`;
    }else if(checkMemberNo.length > 1){
      $("#all-user-view").modal("show");
    }
}});