import { path } from '../common/common.js';
import * as MyAprFront from './myApprovalFront.js';
import sendAprMessage  from './aprWebsocket.js';

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

// 결재 문서 저장/수정 모두 처리
export function registerApproval(formData, urlPath) {
  $.ajax({
    url: defaultPath + urlPath,
    dataType: 'JSON',
    data: formData,
    enctype: 'multipart/form-data', //form data 설정
    processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
    contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
    type: 'POST',
    success: function (result) {
      // 저장 하자마자 완결상태일 경우
      if (result.result == -1) {
        // Date 객체에서 연도, 월, 일 추출
        let tempDate = new Date();
        const year = tempDate.getFullYear();
        const month = tempDate.getMonth() + 1; // 월은 0부터 시작하므로 +1 해줍니다.
        const day = tempDate.getDate();

        // 추출한 연도, 월, 일로 문자열 생성해서 반환
        let nowDate = `${year}-${month.toString().padStart(2, '0')}-${day
          .toString()
          .padStart(2, '0')}`;

        let content = `<div class="end-approval-lines">
                      <div class="end-approval-lines-wrap">
                        <div class="end-approval-lines-title">결<br />재</div>
                        <div class="end-approval-lines-item">
                          <div class="approver-name">${result.userName} ${result.pName}</div>
                          <div class="approver-sign">
                            <img src="${result.signImg}"/>
                          </div>
                          <div class="approver-date">
                            ${nowDate}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="end-approval-content">
                      ${result.approval.content}
                    </div>`;

        //결재라인 정보 추가해서 완결 다시 날리기
        updateApprovalStateEnd(result.approval.approvalNo, content);
      } else if (result.result == 1) {
        swal('저장이 완료되었습니다.', {
          buttons: { confirm: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();

        if(result.nextAuthorizeUserNo){
          // 다음 결재자에게 알림 메세지 전송
          sendAprMessage( 0 ,result.nextAuthorizeUserNo);
        }
      } else {
        swal('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.', {
          buttons: { cancel: '확인' },
        });
      }

      selectUnReadCount();
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 결재문서 결재처리
export function updateApprovalStateAuthorized(
  approvalNo,
  myLevel,
  content = null
) {
  $.ajax({
    url: defaultPath + '/updateApprovalStateAuthorized',
    type: 'POST',
    dataType: 'JSON',
    data: {
      approvalNo,
      myLevel,
    },
    success: function (map) {
      let result = map.result;
      let userNo = map.nextAuthorizeUserNo;
      if (result > 0) {
        // 완결처리까지 해야하는지 상태 확인
        if (content != null) {
          // 완결 처리
          updateApprovalStateEnd(approvalNo, content);
        } else {
          swal('결재처리가 완료되었습니다.', {
            buttons: { confirm: '확인' },
          });

          MyAprFront.closeApprovalModal();
          MyAprFront.clickCurrentPageBtn();

          if (userNo > 0) {
            // 다음결재자한테 알림 날림
            sendAprMessage(0, userNo);
          }
        }
      } else {
        swal('예기치 않은 오류가 발생했습니다.', {
          buttons: { cancel: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 결재문서 반려처리
export function updateApprovalReturn(approvalNo) {
  $.ajax({
    url: defaultPath + '/updateApprovalReturn',
    type: 'POST',
    data: {
      approvalNo,
    },
    success: function (result) {
      if (result > 0) {
        swal('반려처리가 완료되었습니다.', {
          buttons: { confirm: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();

        // 기안자에게 반려처리 알림 발송
        sendAprMessage(-1, result);
      } else {
        swal('예기치 않은 오류가 발생했습니다.', {
          buttons: { cancel: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();
      }
      selectUnReadCount();
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 결재문서 완결처리
export function updateApprovalStateEnd(approvalNo, content) {
  $.ajax({
    url: defaultPath + '/updateApprovalStateEnd',
    dataType: 'JSON',
    type: 'POST',
    data: {
      approvalNo,
      content,
    },
    success: function (result) {
      if (result > 0) {
        swal('문서가 완결처리되었습니다.', {
          buttons: { confirm: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();

        // 기안자에게 완결처리 알림 발송
        sendAprMessage(1, result);
      } else {
        swal('예기치 않은 오류가 발생했습니다.', {
          buttons: { cancel: '확인' },
        });

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();
      }
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 사원 연차정보 조회하는 용도
export function selectUserAnnualInfo() {
  $.ajax({
    url: defaultPath + '/selectUserAnnualInfo',
    dataType: 'JSON',
    type: 'POST',
    success: function (result) {
      MyAprFront.setAnnual(result.totalAnnual, result.leftAnnual);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 종류별 결재 리스트 조회
export function selectApprovalList(year, type, page, menu, status) {
  $.ajax({
    url: defaultPath + '/selectApprovalList',
    dataType: 'JSON',
    type: 'POST',
    data: {
      year,
      type,
      page,
      menu,
      status,
    },
    success: function (result) {
      MyAprFront.setTableList(
        result.list,
        result.count,
        page,
        result.loginUserNo
      );
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

        MyAprFront.closeApprovalModal();
        MyAprFront.clickCurrentPageBtn();
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

// 안읽은 반려, 승인대기, 참조 결재문서 수 반환
export function selectUnReadCount() {
  $.ajax({
    url: defaultPath + '/selectUnReadCount',
    dataType: 'JSON',
    type: 'POST',
    success: function (result) {
      MyAprFront.setAlamNum(
        result.returnCount,
        result.waitCount,
        result.referCount
      );
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 선택한 결재 문서 세부 내용 조회
export function selectApproval(approvalNo, selectedMenu) {
  $.ajax({
    url: defaultPath + '/selectApproval',
    dataType: 'JSON',
    type: 'POST',
    data: { approvalNo },
    success: function (result) {
      if (selectedMenu == 'return' || selectedMenu == 'temp') {
        MyAprFront.setApprovalModalContent(
          result.approval,
          result.lines,
          result.files,
          result.userNo
        );
      } else {
        MyAprFront.setEndApprovalModal(
          result.approval,
          result.lines,
          result.files,
          result.userNo
        );
      }

      // 문서 조회가일어나면 일단 안읽은 알림 개수 다시 체크
      selectUnReadCount();
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
        MyAprFront.selectMemoListPage();
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
      MyAprFront.setMemoList(memoList);
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
      MyAprFront.setMemoContent(result.memo, result.files, result.loginUser);
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
        MyAprFront.selectMemoListPage();
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
        MyAprFront.selectMemoListPage();
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

// 사인 이미지 조회
export function selectSignImg() {
  $.ajax({
    url: defaultPath + '/selectSignImg',
    type: 'POST',
    success: function (result) {
      MyAprFront.setMySign(result);
    },
    error: function (request) {
      console.log('에러발생');
      console.log(request.status);
    },
  });
}

// 사인 이미지 업데이트
export function updateSignImg(formData) {
  $.ajax({
    url: defaultPath + '/updateSignImg',
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
        selectSignImg();
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
