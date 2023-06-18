import * as Tiny from './tinyEditor.js';
import { path } from '../common/common.js';
import * as MyAprData from './myApprovalData.js';

// 멤버 테이블 내용 갈아껴주는 함수
export function setSelectMemberTable(result) {
  let html = '';

  const deptMember = {};
  //팀별로 배열 나눠주기
  for (let i = 0; i < result.length; i++) {
    const item = result[i];
    const deptCode = item.deptCode;

    if (!deptMember[deptCode]) {
      //해당팀이 없다면 팀 넣고, item 넣기
      deptMember[deptCode] = [item];
    } else {
      //있다면 해당 팀에 item넣기
      deptMember[deptCode].push(item);
    }
  }

  //만들어둔 object 반복문 돌리면서 table생성
  for (let deptm in deptMember) {
    html += `
        <tr>
            <td rowspan="${deptMember[deptm].length}" >${
      deptMember[deptm][0].dName ? deptMember[deptm][0].dName : '임시 부서'
    }</td>
            <td class="org-table-member" value="${
              deptMember[deptm][0].userNo
            }" >${deptMember[deptm][0].userName} ${
      deptMember[deptm][0].pName ? deptMember[deptm][0].pName : ''
    }</td>
        </tr>
        `;

    for (let i = 1; i < deptMember[deptm].length; i++) {
      html += `
            <tr>
                <td  class="org-table-member" value="${
                  deptMember[deptm][i].userNo
                }" >${deptMember[deptm][i].userName}  ${
        deptMember[deptm][i].pName ? deptMember[deptm][i].pName : ''
      }</td>
            </tr>
            `;
    }
  }

  let table = document.getElementById('select-member-table');
  table.querySelector('tbody').innerHTML = html;
  let tableBox = document.querySelector('.org-table-content');

  if (table.clientHeight > tableBox.clientHeight) {
    document.querySelector('.org-chart').style.background =
      'var(--color-linear)';
  } else {
    document.querySelector('.org-chart').style.background = 'unset';
  }
}
// 달력요소 단일달력여부, 표시 날짜 값 받아서 세팅 해주는 함수
let setDatePickerType = function (isSingle, startDate, endDate) {
  let setting = {
    locale: {
      separator: ' ~ ', // 시작일시와 종료일시 구분자
      format: 'YYYY-MM-DD', // 일시 노출 포맷
      applyLabel: '확인', // 확인 버튼 텍스트
      cancelLabel: '취소', // 취소 버튼 텍스트
      daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
      monthNames: [
        '1월',
        '2월',
        '3월',
        '4월',
        '5월',
        '6월',
        '7월',
        '8월',
        '9월',
        '10월',
        '11월',
        '12월',
      ],
    },
    timePicker: false, // 시간 노출 여부
    showDropdowns: true, // 년월 수동 설정 여부
    autoApply: false, // 확인/취소 버튼 사용여부
    timePicker24Hour: true, // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
    timePickerSeconds: true, // 초 노출 여부
    // singleDatePicker: true, // 하나의 달력 사용 여부
  };

  if (isSingle) {
    setting.singleDatePicker = true;
  } else {
    setting.singleDatePicker = false;
  }

  if (startDate) setting.startDate = startDate;
  if (endDate) setting.endDate = endDate;

  $('#date').daterangepicker(setting);
};

// 입력된 값에 따라 문서 타입을 한글로 변경해서 반환
let formatApprovalType = (type) => {
  switch (type) {
    case 0:
      return '일반';
    case 1:
      return '연차';
    case 2:
      return '오전반차';
    case 3:
      return '오후반차';
  }
};

// 입력된 값에 따라 문서 status를 한글로 변경해서 반환
let formatApprovalStatus = (status) => {
  switch (status) {
    case -2:
    case -1:
      return '반려';
    case 0:
      return '진행중';
    case 1:
      return '완료';
    case 2:
      return '임시저장';
  }
};

// 결재 수정/작성 모달 창 내용 리셋시켜주는 함수
export function setApprovalModalContent(
  approval,
  lines = [],
  files = [],
  loginUserNo = -1
) {
  const typeTd = document.getElementById('td-approval-table-type');
  const approvalLine = document.querySelector(
    '#approval .approval-lines > ol.scroll-bar'
  );
  const fileLine = document.querySelector(
    '#approval .approval-files > .scroll-bar'
  );
  const fileInput = document.querySelector('#input-add-file');

  // 타입을 종류 태그에 저장
  typeTd.dataset.type = approval.type;

  // 만약 수정일경우를 대비해서 결재번호도 저장시켜둠
  typeTd.dataset.no = approval.approvalNo ? approval.approvalNo : 'none';

  // 제목 리셋
  document.getElementById('approval-title').value = approval.title
    ? approval.title
    : '';

  // 결재라인 리셋
  approvalLine.innerHTML = '';
  for (let line of lines) {
    approvalLine.innerHTML += `<li data-type="${line.type}" data-user="${
      line.userNo
    }">
                    <b>${line.type == 'R' ? '참조' : '결재'}</b> ${
      line.userName
    } ${line.pName ? line.pName : ''}
                </li>`;
  }

  // 첨부파일 리스트 리셋
  fileLine.innerHTML = '';
  for (let file of files) {
    fileLine.innerHTML += `<div class="div-file-saved" data-changename="${file.changeName}" >
                            <button type="button" class="btn-file-delete">
                              <div class="div-minus">
                            </div></button>
                            ${file.originName}
                          </div>`;
  }

  // 첨부파일인풋의 실제 파일들 리셋
  fileInput.files = new DataTransfer().files;

  // 내용 리셋
  tinymce
    .get('approval-tiny')
    .setContent(approval.content ? approval.content : '');
  // 내용 리셋시킨 후 이미지 src들 갈아껴주기
  Tiny.changeImgPath('approval-tiny', path + '/resources/file/approval/');

  if (approval.type == 0) {
    // 일반 타입이면 데이트 선택화면 없애기
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = 'none';
    });

    typeTd.innerHTML = '일반';

    $('#approval').modal('show');
  } else if (approval.type == 1) {
    // 연차 타입이면 데이트 선택 범위 선택되게
    // 종류 예시 연차 [ 10.5 / 19 ]
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = '';
    });

    typeTd.innerHTML = '연차';

    // 수정일 경우 날짜 정보 들어올테니 그에 맞게 날짜 표시
    if (approval.startDate && approval.endDate) {
      setDatePickerType(
        false,
        approval.formatStartDate,
        approval.formatEndDate
      );
    } else {
      setDatePickerType(false);
    }

    // 로그인유저 연차정보 불러오기
    MyAprData.selectUserAnnualInfo();
  } else {
    // 반차 타입이면 데이트 선택 하루만 되게
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = '';
    });

    // todo! 나중에 연차정보 조회해서 와야함
    if (approval.type == 2) {
      typeTd.innerHTML = '오전반차';
    } else {
      typeTd.innerHTML = '오후반차';
    }

    // 수정일 경우 날짜 정보 들어올테니 그에 맞게 날짜 표시
    if (approval.startDate) {
      setDatePickerType(true, approval.formatStartDate);
    } else {
      setDatePickerType(true);
    }

    // 로그인유저 연차정보 불러오기
    MyAprData.selectUserAnnualInfo();
  }

  const deleteBtn = document.getElementById('btn-temp-return-approval-delete');
  const saveBtn = document.getElementById('btn-save-approval');
  const tempBtn = document.getElementById('btn-save-approval-temporary');
  const memoBtn = document.querySelector('#approval .btn-memo-open');
  // 만약 approvalNo 값이 있다면 수정 창이라는 소리임
  if (approval.approvalNo && approval.approvalNo > 0) {
    // 삭제버튼 표시
    deleteBtn.style.display = 'inline-block';

    //결재 저장버튼에다 no값 세팅해주기
    saveBtn.dataset.approvalno = approval.approvalNo;

    if (approval.status && (approval.status == -1 || approval.status == -2)) {
      // 만약 반려문서라면 임시저장버튼 숨기기
      tempBtn.style.display = 'none';

      // 메모 버튼 오픈
      memoBtn.style.display = 'inline-block';
    } else {
      //  임시저장 버튼 표시
      tempBtn.style.display = 'inline-block';
      // 반려문서 아니면 메모 버튼 숨기기
      memoBtn.style.display = 'none';
    }
  } else {
    // 신규 작성창이라는 소리
    // 삭제버튼 숨기기
    deleteBtn.style.display = 'none';

    //  임시저장 버튼 표시
    tempBtn.style.display = 'inline-block';

    //결재 저장버튼 no값 리셋
    saveBtn.dataset.approvalno = -1;

    //메모 버튼 숨기기
    memoBtn.style.display = 'none';
  }
}

//  결재 모달창들 모두 닫기
export function closeApprovalModal() {
  $('#approval').modal('hide');
  $('#end-approval').modal('hide');
}

export function clickCurrentPageBtn() {
  // 현재 선택되어있는정보대로 페이지 다시 세팅해주기
  // 선택되어있는 버튼에 클릭 보냄
  document.querySelector('.selected-btn.page-btn').click();
}

// 결재 모달창에 연차정보 세팅시키는 함수
export function setAnnual(totalAnnual, leftAnnual) {
  const typeTd = document.getElementById('td-approval-table-type');
  // 연차정보 있으면 종류태그에 남은 연차정보도 저장
  typeTd.dataset.totalAnnual = totalAnnual;
  typeTd.dataset.leftAnnual = leftAnnual;

  typeTd.innerText += ` [ ${leftAnnual} / ${totalAnnual} ]`;

  //  연차정보 세팅 후 모달 오픈
  $('#approval').modal('show');
}

// 양식 셀렉트박스에 양식 리스트 넣어주는 함수
export function setCopyFormList(formList, open) {
  let html = `<option value="none" selected>선택 안함</option>`;
  for (let form of formList) {
    html += `<option value="${form.formNo}" >${form.title}</option>`;
  }

  document.getElementById('select-copy-form-no').innerHTML = html;

  // 만약 오픈값이 true 이면 모달도 오픈해주기
  if (open) {
    document.getElementById('select-copy-form-type').selectedIndex = 0;
    $('#modal-select-approval-type').modal('show');
  }
}

// 즐겨찾기 리스트 세팅하는 함수
export function setFavorList(favorList) {
  const tbody = document.querySelector(
    '#approval-line-modal .favor-table tbody.scroll-bar'
  );
  // 스크롤 위치 기억
  let height = tbody.clientHeight;
  let html = '';

  if (!favorList || favorList.length <= 0) {
    html = `<tr>
              <td style="justify-content: center">
                즐겨찾기가 없습니다
              </td>
            </tr>`;
  } else {
    for (let favor of favorList) {
      html += `<tr data-no="${favor.lineNo}">
                <td>
                  <button class="btn-favor-delete btn btn-outline-primary">
                    <div class ="div-minus"></div>
                  </button>
                  <div>
                    ${favor.title}
                  </div>
                </td>
              </tr>`;
    }
  }

  tbody.innerHTML = html;

  // 스크롤 위치 다시 세팅해주기
  tbody.scrollTop = height;
}

// 결재라인 정보 받아다 결재라인 화면에 세팅해주는 함수
export function setApprovalLines(list) {
  const ol = document.querySelector('#approval-line-modal .selected-lines ol');
  let html = '';

  for (let line of list) {
    html += `<li >
              <select name="type" >
                <option value="A" ${
                  line.type === 'A' ? 'selected' : ''
                } >결재</option>
                <option value="R" ${
                  line.type === 'R' ? 'selected' : ''
                } >참조</option>
              </select>
              <div value="${line.userNo}">
                ${line.userName} ${line.pName}
                <button
                  class="btn-selected-delete btn btn-outline-primary"
                >
                  <div class ="div-minus"></div>
                </button>
              </div>
            </li>`;
  }

  // 결재라인 갈아껴주기
  ol.innerHTML = html;
}

// 결재문서 저장용 formData 데이터 만들어서 반환하는 함수
let makeApprovalSendData = function (isUpdate = false) {
  let title = document.getElementById('approval-title').value;
  if (title == '' || !title) {
    // 제목 없으면 리턴
    swal('제목을 입력해주세요.', { buttons: { cancel: '확인' } });
    return null;
  }
  let lineLevelList = [];
  let lineTypeList = [];
  let lineUserNoList = [];
  // 선택된 결재라인 불러오기
  const liList = document.querySelectorAll(
    '#approval .approval-lines ol.scroll-bar > li'
  );
  liList.forEach((li, index) => {
    let lineLevel = index + 1;
    let lineUserNo = Number(li.dataset.user);
    let lineType = li.dataset.type;

    lineLevelList.push(lineLevel);
    lineTypeList.push(lineType);
    lineUserNoList.push(lineUserNo);
  });

  // 만약 선택된 결재자 없으면 그냥 종료
  if (lineLevelList.length <= 0) {
    swal('선택된 결재자 정보가 없습니다.', {
      buttons: { cancel: '확인' },
    });
    return null;
  }

  let type = Number(
    document.getElementById('td-approval-table-type').dataset.type
  );

  let date = document.getElementById('date').value;
  let startDate;
  let endDate;
  let leftAnnual = Number(
    document.getElementById('td-approval-table-type').dataset.leftAnnual
  );
  if (type == 0) {
    // 종류가 일반이면 시작날짜 종료날짜 공백
    startDate = null;
    endDate = null;
  } else if (type == 1) {
    // 종류 연차면 시작날짜 종료날짜 넣어주기
    let dateArr = date.split(' ~ ');
    startDate = dateArr[0];
    endDate = dateArr[1];
  } else {
    // 오전반차 오후반차는 시작/종료날짜 똑같게
    startDate = date;
    endDate = date;
  }

  // 결재 문서 타입이 연차면 선택된 날짜 범위 계산 해서 남은 연차개수랑 비교
  if (type == 1) {
    // 시작 날짜와 종료 날짜를 Date 객체로 변환
    let start = new Date(startDate);
    let end = new Date(endDate);

    // 시작 날짜와 종료 날짜 사이의 일수 계산
    let timeDiff = Math.abs(end.getTime() - start.getTime());
    let diffDays = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;

    if (leftAnnual < diffDays) {
      // 만약 남은연차개수가 선택한 날짜 범위보다 작으면
      // 더이상 진행하지 않고 리턴
      swal('남은 연차일이 부족합니다.', {
        buttons: { confirm: '확인' },
      });
      return null;
    }
  } else if (type > 1) {
    // type 2,3 은 반차용이므로 0.5깎임
    if (leftAnnual < 0.5) {
      // 만약 남은연차개수가 선택한 날짜 범위보다 작으면
      // 더이상 진행하지 않고 리턴
      swal('남은 연차일이 부족합니다.', {
        buttons: { confirm: '확인' },
      });
      return null;
    }
  }
  // 본문데이터랑 본문용 이미지 파일 리스트 담겨서 반환됨
  let finalData = Tiny.returnFormData('approval-tiny');

  // 선택된 타입 저장
  finalData.append('type', type);

  // 첨부파일저장용
  let inputFile = document.getElementById('input-add-file').files;
  for (let file of inputFile) {
    finalData.append('files', file);
  }

  // 만약 수정용이면 기존 첨부파일들 정보도 필요하므로 담아주기
  if (isUpdate) {
    let savedFileArr = document.querySelectorAll('.div-file-saved');
    if (savedFileArr.length > 0) {
      for (let savedFile of savedFileArr) {
        finalData.append('fileNames', savedFile.dataset.changename);
      }
    }
  }

  finalData.append('title', title);
  if (startDate != null) {
    finalData.append('startDate', startDate);
    finalData.append('endDate', endDate);
  }

  // 서로 섞어서 값을 추가
  for (let i = 0; i < lineLevelList.length; i++) {
    finalData.append('levelList', lineLevelList[i]);
    finalData.append('userNoList', lineUserNoList[i]);
    finalData.append('typeList', lineTypeList[i]);
  }

  return finalData;
};

// 결재 테이블 아이템 갈아끼기
export function setTableList(approvalList, count, page, loginUserNo) {
  // 최신정보로 페이지 버튼 정보 리셋
  if (resetPageBtn(page, count)) {
    // 버튼 리셋되면서 페이지 이동이 일어나게 된다면 함수 종료
    return;
  }
  let tableHtml = '';

  if (approvalList != null && approvalList.length > 0) {
    for (let i in approvalList) {
      let approval = approvalList[i];

      let isNotRead;

      // 로그인한 유저번호와 기안자 번호가 같을경우 읽은 반려문서인지, 아닌지 체크
      if (loginUserNo == approval.userNo) {
        isNotRead = approval.status == -1;
      }

      // 만약 내가 참조자거나 결재자인 경우 들어오는 데이터
      if (approval.confirmStatus) {
        isNotRead = approval.confirmStatus == 'N';
      } else {
        isNotRead = approval.status == -1;
      }

      approval.type = formatApprovalType(approval.type);
      approval.status = formatApprovalStatus(approval.status);

      tableHtml += `<tr class="${isNotRead ? 'not-read' : ''}" 
                        data-approvalno="${approval.approvalNo}">
                      <td>${count - (page - 1) * 10 - i}</td>
                      <td>${approval.formatDraftDate}</td>
                      <td>${approval.title}</td>
                      <td>${approval.userName} ${
        approval.pName ? approval.pName : ''
      }${approval.eno != 0 ? '(' + approval.eno + ')' : ''}</td>
                      <td>${approval.status}</td>
                      <td>${approval.type}</td>
                    </tr>`;
    }
  } else {
    tableHtml = `<tr>
                    <td colspan="6">등록된 문서가 없습니다.</td>
                  </tr>`;
  }
  document.querySelector('.my-approval-table tbody').innerHTML = tableHtml;
}

// 선택되어야 하는 버튼번호화, 현재 선택된 문서 갯수가져와서 버튼들 정보 다시 리셋해주는 함수
export function resetPageBtn(currentBtnNum, count) {
  let btns = document.querySelectorAll('.page-btn');

  //최대 페이지 수
  let maxPage = Math.ceil(count / 10);

  // 페이지버튼들 시작 숫자 저장용
  let startPage;

  // 나중에 클릭할 btn 저장해둘 변수
  let clickBtn;

  // 페이지 변동이 있었는지 비교용도 변수
  let changePage = currentBtnNum;

  if (currentBtnNum > maxPage) {
    // 만약 현재 버튼수가 최대페이지수보다 크면
    // 시작 페이지 숫자 = 최대페이지의 10의자리 수 + 1
    // 최대페이지가 0이면 시작 버튼숫자 1로 반환
    startPage = maxPage != 0 ? Math.floor((maxPage - 1) / 10) * 10 + 1 : 1;

    // 선택되어야 하는 버튼 번호 최대페이지수와 같게 다시 세팅
    // 최대페이지가 0이면 선택 버튼숫자 1로 반환
    changePage = maxPage != 0 ? maxPage : 1;
  } else {
    // 그외는 현재 버튼번호 기준으로 세팅
    startPage = Math.floor((currentBtnNum - 1) / 10) * 10 + 1;
  }

  for (let i = 0; i < 10; i++) {
    // 페이지번호 재생성
    let pageNum = startPage + i;
    btns[i].innerText = pageNum;

    if (pageNum > maxPage) {
      //만약 버튼의 숫자가 최대 페이지 수보다 크다면 버튼 비활성화
      btns[i].className = 'disable-btn page-btn';
    } else {
      btns[i].className = 'page-btn';
    }

    if (pageNum == changePage) {
      // 나중에 클릭보낼 btn저장
      clickBtn = btns[i];
    }
  }

  if (startPage > 10) {
    // 페이지버튼 시작 숫자가 10보다 크면 앞으로 가기 버튼 활성화
    document.getElementById('prev-btn').className = '';
  } else {
    document.getElementById('prev-btn').className = 'disable-btn';
  }

  if (startPage + 9 < maxPage) {
    // 시작 숫자 + 9(=마지막페이지버튼숫자임)이
    // 최대페이지 수보다 작을때 뒤로가기 버튼 활성화
    document.getElementById('next-btn').className = '';
  } else {
    document.getElementById('next-btn').className = 'disable-btn';
  }

  if (currentBtnNum != changePage && count > 0) {
    //만약 표시해야할 페이지에 변동이 있으면서 총 카운트 수도 있다면 클릭 보내기
    // 버튼 내용 갈아끼기 다 끝나고 btn에 클릭보냄 => 알아서 테이블내용 갈아껴질것임
    clickBtn.click();
    // 먼저 실행되고있었던 함수 종료 위해 true 리턴
    return true;
  } else {
    clickBtn.className = 'selected-btn page-btn';
  }

  return false;
}

// 안읽은 반려, 승인대기 결재문서 수받아와서 알람버튼에 세팅
export function setAlamNum(returnCount, waitCount, referCount) {
  const waitAlam = document.getElementById('wait-alarm');
  const returnAlam = document.getElementById('return-alarm');
  const referAlam = document.getElementById('refer-alarm');

  waitAlam.innerText = waitCount;
  returnAlam.innerText = returnCount;
  referAlam.innerText = referCount;

  if (waitCount <= 0) {
    waitAlam.className = 'alarm-hide alarm-balloon';
  } else {
    waitAlam.className = 'alarm-balloon';
  }

  if (returnCount <= 0) {
    returnAlam.className = 'alarm-hide alarm-balloon';
  } else {
    returnAlam.className = 'alarm-balloon';
  }

  if (referCount <= 0) {
    referAlam.className = 'alarm-hide alarm-balloon';
  } else {
    referAlam.className = 'alarm-balloon';
  }
}

// 날짜 형식 yyyy-MM-dd로포맷팅해서 반환
let formatDate = (date) => {
  let tempDate = new Date(Date.parse(date));

  // Date 객체에서 연도, 월, 일 추출
  const year = tempDate.getFullYear();
  const month = tempDate.getMonth() + 1; // 월은 0부터 시작하므로 +1 해줍니다.
  const day = tempDate.getDate();

  // 추출한 연도, 월, 일로 문자열 생성해서 반환
  return `${year}-${month.toString().padStart(2, '0')}-${day
    .toString()
    .padStart(2, '0')}`;
};

// 날짜 형식 yyyy-MM-dd HH:ss 로포맷팅해서 반환
let formatDateTime = (date) => {
  let tempDate = new Date(date);

  // Date 객체에서 연도, 월, 일 시간 추출
  const year = tempDate.getFullYear();
  const month = tempDate.getMonth() + 1; // 월은 0부터 시작하므로 +1 해줍니다.
  const day = tempDate.getDate();
  const hours = tempDate.getHours().toString().padStart(2, '0');
  const minutes = tempDate.getMinutes().toString().padStart(2, '0');

  // 문자열 생성해서 반환
  return `${year}-${month.toString().padStart(2, '0')}-${day
    .toString()
    .padStart(2, '0')} ${hours}:${minutes}`;
};

// 이미지 src 경로 바꿔주는 함수
let changeEndApprovalImgPath = (contentEl, imgPath) => {
  let imgArr = contentEl.getElementsByTagName('img');

  if (imgArr) {
    for (let img of imgArr) {
      let imgSrc = img.src;
      //  기존 이미지들 src 갈아끼기
      // 이미지 실제 이름만 가져옴
      imgSrc = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);

      // 이미지 경로 재설정
      img.src = imgPath + imgSrc;
    }
  }
};

// 결재 서명용 이미지 src 경로 + 기본이미지 주소 바꿔주는 함수
let changeEndApprovalSignImgPath = (contentEl, imgPath) => {
  let imgArr = contentEl.getElementsByTagName('img');

  if (imgArr) {
    for (let img of imgArr) {
      let imgSrc = img.src;
      //  기존 이미지들 src 갈아끼기
      // 이미지 실제 이름만 가져옴
      imgSrc = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);

      // 이미지 경로 재설정
      img.src = imgPath + imgSrc;
      // 이미지 기본 이미지 경로 재설정
      img.onerror = (event) => {
        event.target.src =
          path + '/resources/image/approval/defaultiSignature.png';
      };
    }
  }
};

// 결재문서 디테일 상세화면 세팅후 모달 오픈
export function setEndApprovalModal(approval, lines, files, loginUserNo) {
  const defaultFilePath = path + '/resources/file/approval/';
  const defaultSignPath = path + '/resources/file/signature/';
  const signImgPath = path + '/resources/file/signature/';
  const typeTd = document.getElementById('td-approval-type');
  const statusTd = document.getElementById('td-approval-status');
  const draftDateTd = document.getElementById('td-approval-draft-date');
  const userTd = document.getElementById('td-approval-user');
  const requestDateTd = document.getElementById('td-approval-request-date');
  const referTd = document.getElementById('td-approval-refer');
  const filesDiv = document.querySelector(
    '#end-approval .approval-files > div.scroll-bar'
  );
  const finalApprovalWrap = document.querySelector('.final-approval-wrap');
  const selectedMenu = document.querySelector('.top-menubar-item.selected')
    .dataset.menu;
  const returnBtn = document.getElementById('btn-return-approval');
  //결재버튼
  const authorizeBtn = document.getElementById('btn-authorize-approval');
  // 기본적으로 내 레벨 0으로 초기화
  authorizeBtn.dataset.mylevel = '0';
  // 문서 번호 세팅
  document.getElementById('end-approval').dataset.approvalno =
    approval.approvalNo;

  if (approval.type == 0) {
    // 일반
    // 신청일자란 비활성화
    requestDateTd.parentNode.style.display = 'none';
  } else {
    // 그외 신청일자란 활성화
    requestDateTd.parentNode.style.display = 'table-row';
    let startDate = approval.formatStartDate;
    if (approval.type == 1) {
      // 연차
      let endDate = approval.formatEndDate;
      // 신청일자 세팅
      requestDateTd.innerText = startDate + ' ~ ' + endDate;
    } else {
      // 반차들 신청일자 세팅
      requestDateTd.innerText = startDate;
    }
  }

  // 종류 텍스트 세팅
  typeTd.innerText = formatApprovalType(approval.type);
  // 상태 텍스트 세팅
  statusTd.innerText = formatApprovalStatus(approval.status);
  // 기안일 세팅
  draftDateTd.innerText = approval.formatDraftDate;
  // 기안자 세팅
  userTd.innerText = `${approval.userName} ${approval.pName}(${approval.eno})`;

  // 첨부파일 세팅
  let fileHtml = ``;
  if (files.length > 0) {
    for (let file of files) {
      fileHtml += `<div>
                    ${file.originName}
                    <button class="btn-file-download">
                      <a href="${
                        defaultFilePath + file.changeName
                      }" download="${file.originName}">
                        <i class="bi bi-download"></i>
                      </a>
                    </button>
                  </div>`;
    }
  }
  filesDiv.innerHTML = fileHtml;

  // 참조자 세팅용
  let referNames = [];

  // 기본적으로 본문 내용 날림
  finalApprovalWrap.innerHTML = '';

  // 본문내용 세팅용
  let finalContentHtml = '';

  //본문에 타이틀 추가
  finalContentHtml += `<h2 ><u id="h-approval-title">${approval.title}</u></h2>`;

  // 문서상태가 완결상태가 아닐경우에만 결재라인 내용추가
  if (approval.status != 1) {
    let lineItems = '';
    for (let i in lines) {
      if (lines[i].type == 'R') {
        referNames.push(
          `${lines[i].userName} ${lines[i].pName}(${lines[i].eno})`
        );
      } else {
        if (lines[i].userNo == loginUserNo) {
          // 내 레벨 저장
          authorizeBtn.dataset.mylevel = lines[i].level;
        }

        let img = '';
        let date = '';
        if (lines[i].status == 2) {
          img = `<img src="${signImgPath + lines[i].signatureImg}" />`;
          date = formatDate(lines[i].date);
        } else if (lines[i].status == -1) {
          img = `<div class="return_text">반려</div>`;
          date = formatDate(lines[i].date);
        }

        lineItems += `<div class="end-approval-lines-item" data-userno="${
          lines[i].userNo
        }">
                      <div class="approver-name">${lines[i].userName} ${
          lines[i].pName ? lines[i].pName : ''
        }</div>
                      <div class="approver-sign">
                        ${img}
                      </div>
                      <div class="approver-date">
                        ${date}
                      </div>
                    </div>`;
      }
    }

    // 본문에 결재라인 세팅(결재 제목 + 기안자꺼 추가 해서 안에 결재아이템들 넣고 생성)
    finalContentHtml += `<div class="end-approval-lines">
                          <div class="end-approval-lines-wrap">
                            <div class="end-approval-lines-title">결<br />재</div>
                            <div class="end-approval-lines-item">
                              <div class="approver-name">${approval.userName} ${
      approval.pName
    }</div>
                              <div class="approver-sign">
                                <img
                                  src="${signImgPath + approval.signatureImg}"
                                />
                              </div>
                              <div class="approver-date">
                                ${formatDate(approval.formatDraftDate)}
                              </div>
                            </div>
                            ${lineItems}
                          </div>
                        </div> `;
  }

  // 본문에 본문내용 추가
  finalContentHtml += `<div class="end-approval-content">
                        ${approval.content}
                      </div>`;

  // 실제 본문 내용 위에서 세팅한 내용으로 변경
  finalApprovalWrap.innerHTML = finalContentHtml;

  let signAreaEl = finalApprovalWrap.querySelector('.end-approval-lines-wrap');
  let contentAreaEl = finalApprovalWrap.querySelector('.end-approval-content');

  // 이미지 src 갈아껴주기
  if (signAreaEl) {
    changeEndApprovalSignImgPath(signAreaEl, defaultSignPath);
  }
  changeEndApprovalImgPath(contentAreaEl, defaultFilePath);

  // 참조자 세팅
  referTd.innerText = referNames.join(', ');

  // 기본적으로 삭제 버튼 비활성화(관리자만 관리쪽 메뉴에서 삭제 가능함)
  document.getElementById('btn-delete-approval').style.display = 'none';

  // 결재문서 상태 대기중인 메뉴에서 문서 선택했을때
  if (selectedMenu == 'wait') {
    // 결재 버튼 활성화, 반려버튼 활성화
    returnBtn.style.display = 'inline-block';
    authorizeBtn.style.visibility = 'visible';
    authorizeBtn.dataset.userno = loginUserNo;
    authorizeBtn.dataset.lastsrc = lines[lines.length - 1].signatureImg;
  } else {
    returnBtn.style.display = 'none';
    authorizeBtn.style.visibility = 'hidden';
  }

  // todo! 내용 세팅 끝난 후  모달 오픈
  $('#end-approval').modal('show');
}

// 메모리스트 세팅하면서 메모 개수도 표시하는 함수
export function setMemoList(memoList) {
  const count = memoList.length;

  // 메모 버튼에 메모 수 표시
  document.querySelectorAll('.btn-memo-open').forEach((btn) => {
    btn.innerText = `메모(${count})`;
  });

  let html = '';
  for (let memo of memoList) {
    html += `<tr data-memono="${memo.memoNo}">
              <td>${memo.userName} ${memo.pName}(${memo.eno})</td>
              <td>
                ${memo.content}
              </td>
              <td>${formatDateTime(memo.date)}</td>
            </tr>`;
  }

  if (memoList.length <= 0) {
    html = `<tr>
              <td colspan="3">작성된 메모가 없습니다</td>
            </tr>`;
  }

  // 메모 리스트 세팅
  document.querySelector('#memo-modal-back .memo-list-table').innerHTML = html;
}

// 메모 내용 세팅
export function setMemoContent(memo, files, loginUser) {
  const memoContent = document.getElementById('memo-add-content');
  const memoInput = document.getElementById('input-memo-add-file');
  const deleteBtn = document.getElementById('btn-add-memo-delete');
  const saveBtn = document.getElementById('btn-add-memo-save');
  let fileHtml = '';

  for (let file of files) {
    fileHtml += `<div class="memo-file-item">
                  <a href="${
                    path + '/resources/file/approval/' + file.changeName
                  }" download="${file.originName}">${file.originName}</a>
                </div>`;
  }

  // todo! 나중에 첨부파일 삭제도 가능하게 해야함
  document.querySelector('#memo-modal-back .memo-files').innerHTML = fileHtml;

  // 메모 내용부분 리셋
  memoContent.value = memo.content;

  //만약 본인이라면 자동으로 수정버전으로 보이게 처리
  if (loginUser == memo.userNo) {
    // 인풋요소 파일 리셋
    memoInput.files = new DataTransfer().files;
    memoInput.style.display = 'inline';
    memoContent.readOnly = false;

    deleteBtn.style.display = 'inline-block';
    saveBtn.style.display = 'inline-block';

    // 저장버튼에 현재 메모 번호 저장
    saveBtn.dataset.memono = memo.memoNo;
  } else {
    memoInput.style.display = 'none';
    memoContent.readOnly = true;

    deleteBtn.style.display = 'none';
    saveBtn.style.display = 'none';

    saveBtn.dataset.memono = '';
  }

  // 세팅 끝난 후 메모 내용 보이게 처리
  /* 메모 리스트 감추기 */
  document.querySelector('#memo-modal-back .memo-list').style.display = 'none';
  /* 메모 추가/디테일 화면 오픈 */
  document.querySelector('#memo-modal-back .memo-detail').style.display =
    'block';
}

// 메모 리스트 화면으로 돌아가는 함수
export function selectMemoListPage() {
  /* 메모 리스트 오픈 */
  document.querySelector('#memo-modal-back .memo-list').style.display = 'block';
  /* 메모 추가/디테일 화면 감추기 */
  document.querySelector('#memo-modal-back .memo-detail').style.display =
    'none';
}

// 사인이미지 받아와서 이미지들 리셋시키는 함수
export function setMySign(signImg) {
  const mySign = document.getElementById('img-my-sign');
  const newSignImg = document.getElementById('img-new-sign');
  const newSingInput = document.getElementById('input-new-sign');

  // 이미지 캐시를 남기지 않기 위한 현재시간 저장용 변수
  var timestamp = new Date().getTime();
  // 서명이미지란들 리셋
  newSignImg.src = '';
  newSingInput.files = new DataTransfer().files;

  if (signImg != null && signImg != '') {
    // 계속해서 동일한 이름으로 이미지 덮어쓰기를 하기때문에
    // 캐시를 남기지 않고 그때그때 이미지 리로드를 하기위해 이미지 캐시 타임설정을 현재시간으로 함
    mySign.src =
      path + '/resources/file/signature/' + signImg + '?t=' + timestamp;

    var imageElements = document.querySelectorAll('.end-approval-lines img'); // 이미지 요소들 선택, 적절한 CSS 선택자 사용
    // 각 이미지의 URL에 랜덤한 쿼리 매개변수 추가하여 캐시를 회피
    imageElements.forEach(function (imageElement) {
      var imageUrl = imageElement.src;
      var timestamp = new Date().getTime();
      imageUrl = imageUrl + '?t=' + timestamp;
      imageElement.src = imageUrl;
    });
  } else {
    mySign.src = '';
  }
}

// 기안 모달 관련 기본 이벤트들은 approvalModal.js 안에 있음.
// db와 통신하는 등의 추가적인 이벤트들만 따로 작성해서 부여할 예정
// ------------------------------ 이벤트 부여 구역 --------------------------------

// 신규 추가시 양식 선택 모달창 관련 이벤트 부여 구역
let selectFormModalEvent = () => {
  // 신규 추가 버튼 클릭시 전자결재 양식들 불러온 후 모달 오픈
  document.getElementById('btn-add-approval').addEventListener('click', () => {
    MyAprData.selectFormList(0, true);
  });

  // 양식 구분 select 박스 값 변경시 그에 해당하는 양식 리스트 불러오기
  document
    .getElementById('select-copy-form-type')
    .addEventListener('change', (e) => {
      MyAprData.selectFormList(Number(e.target.value));
    });

  // 양식선택 후 저장버튼 눌렀을 경우 기안서 모달 열기
  document
    .getElementById('btn-select-copy-form-type')
    .addEventListener('click', () => {
      let formNo = document.getElementById('select-copy-form-no').value;
      if (formNo == 'none') {
        // 선택한 양식 없이 진행하는 것임 -> 결재 모달화면 내용 리셋시키기
        let approval = {
          type: document.getElementById('select-copy-form-type').value,
        };
        setApprovalModalContent(approval);
      } else {
        MyAprData.selectForm(Number(formNo));
      }
    });
};

// 추가적으로 기안서 작성/수정 모달 안의 이벤트 부여
let extraAprModalEvent = () => {
  // 결재/저장 버튼 클릭 시 이벤트
  document
    .getElementById('btn-save-approval')
    .addEventListener('click', function (e) {
      swal('결재를 신청 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          let formData;
          let approvalNo = e.target.dataset.approvalno;
          if (approvalNo && Number(approvalNo) > 0) {
            // 수정이라는 뜻이므로 요청 수정으로 보내야함

            // 보낼 정보들 담아주는 함수(수정용으로 세팅)
            formData = makeApprovalSendData(true);

            formData.append('approvalNo', Number(approvalNo));
            MyAprData.registerApproval(formData, '/updateApproval');
          } else {
            // 신규로 보내면 됨

            // 아래함수에서 알림창 다 날리기때문에 여기서는 따로 처리 X
            let formData = makeApprovalSendData(false);
            if (formData != null) {
              MyAprData.registerApproval(formData, '/insertApproval');
            }
          }
        }
      });
    });

  // 임시 저장 버튼 클릭 시 이벤트
  document
    .getElementById('btn-save-approval-temporary')
    .addEventListener('click', function () {
      swal('임시저장 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          let approvalNo =
            document.getElementById('btn-save-approval').dataset.approvalno;

          let formData;
          if (approvalNo && Number(approvalNo) > 0) {
            // 수정이라는 뜻이므로 요청 수정으로 보내야함

            // 보낼 정보들 담아주는 함수(수정용으로 세팅)
            formData = makeApprovalSendData(true);
            if (formData != null) {
              // 상태 임시저장 값으로 지정
              formData.append('status', 2);
              formData.append('approvalNo', Number(approvalNo));
              MyAprData.registerApproval(formData, '/updateApproval');
            }
          } else {
            // 신규로 보내면 됨

            // 보낼 정보들 담아주는 함수
            formData = makeApprovalSendData(false);
            if (formData != null) {
              // 상태 임시저장 값으로 지정
              formData.append('status', 2);
              MyAprData.registerApproval(formData, '/insertApproval');
            }
          }
        }
      });
    });

  // todo! 삭제버튼 이벤트는 나중에 관리자 화면에서도 부여해줘야함
  // 임시저장/반려 문서용 삭제 버튼에 이벤트 부여
  document
    .getElementById('btn-temp-return-approval-delete')
    .addEventListener('click', () => {
      swal('문서를 삭제 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          // 결재 문서 삭제 진행
          let approvalNo =
            document.getElementById('btn-save-approval').dataset.approvalno;
          MyAprData.deleteApproval(Number(approvalNo));
        }
      });
    });
};

// 결재라인 모달창 관련 이벤트 부여 구역
let selectAprLineModalEvent = () => {
  // 결재라인 모달 열기
  document
    .getElementById('btn-add-lines')
    .addEventListener('click', function () {
      MyAprData.selectMemberList('');
      MyAprData.selectFavorList();

      // 만약 이미 선택되어있던 결재자 정보가 있었다면 결재라인모달 상에도 그 정보 보여주기
      let liList = document.querySelectorAll(
        '#approval .approval-lines ol.scroll-bar > li'
      );
      let html = '';

      liList.forEach((li) => {
        let userName = li.innerText.slice(3);
        let userNo = Number(li.dataset.user);
        let type = li.dataset.type;

        html += `<li >
                  <select name="type" >
                    <option value="A" ${
                      type === 'A' ? 'selected' : ''
                    } >결재</option>
                    <option value="R" ${
                      type === 'R' ? 'selected' : ''
                    } >참조</option>
                  </select>
                  <div value="${userNo}">
                    ${userName}
                    <button
                      class="btn-selected-delete btn btn-outline-primary"
                    >
                      <div class ="div-minus"></div>
                    </button>
                  </div>
                </li>`;
      });

      // 결재라인 리셋
      document.querySelector(
        '#approval-line-modal .selected-lines ol'
      ).innerHTML = html;

      // 모든 세팅 끝난 후 모달 오픈
      document.getElementById('approval-line-modal').style.display = 'flex';
    });

  // 결재라인 멤버 검색 창 이벤트
  document
    .querySelector('.org-chart .input-search-member')
    .addEventListener('keyup', function () {
      let keyword = document.querySelector(
        '.org-chart .input-search-member'
      ).value;
      MyAprData.selectMemberList(keyword);
    });

  // 즐겨찾기 저장버튼 이벤트
  document
    .getElementById('btn-save-favor-line')
    .addEventListener('click', () => {
      let favorTitle = document.getElementById('input-favor-title').value;
      let liList = document.querySelectorAll(
        '#approval-line-modal .selected-lines > ol > li'
      );

      // 나중에 서버에 넘겨줄 객체
      let favor = { title: favorTitle, level: [], type: [], userNo: [] };

      liList.forEach((li, index) => {
        let level = index + 1;
        let div = li.getElementsByTagName('div')[0];
        let userNo = Number(div.getAttribute('value'));
        let type = li.getElementsByTagName('select')[0].value;

        favor.level.push(level);
        favor.type.push(type);
        favor.userNo.push(userNo);
      });

      // 만약 선택된 결재자 없으면 그냥 종료
      if (favor.level.length <= 0) {
        swal('선택된 결재자 정보가 없습니다.', {
          buttons: { cancel: '확인' },
        });
        // 즐겨찾기 창 닫기
        document.querySelector('.favor-modal-back').style.display = 'none';
        return;
      }

      // 즐겨찾기 저장 보내기
      MyAprData.insertFavor(favor);

      // 즐겨찾기 창 닫기
      document.querySelector('.favor-modal-back').style.display = 'none';
    });

  // 즐겨찾기 삭제버튼 이벤트
  document
    .querySelector('#approval-line-modal .favor-table tbody')
    .addEventListener('click', function (e) {
      let currentNode = e.target;
      //
      if (
        currentNode.classList.contains('btn-favor-delete') ||
        currentNode.classList.contains('div-minus')
      ) {
        swal('즐겨찾기를 삭제하시겠습니까?', {
          buttons: { confirm: '확인', cancel: '취소' },
        }).then(function (isConfirm) {
          if (isConfirm) {
            let tr;
            while (currentNode !== null) {
              if (currentNode.tagName === 'TR') {
                tr = currentNode;
                break;
              }
              currentNode = currentNode.parentNode;
            }
            // 즐겨찾기 삭제
            let favorNo = tr.dataset.no;
            MyAprData.deleteFavor(Number(favorNo));
          }
        });
      }
    });

  // 즐겨찾기 더블클릭 시 내용 불러와서 결재라인에 세팅
  document
    .querySelector('#approval-line-modal .favor-table tbody')
    .addEventListener('dblclick', (e) => {
      let currentNode = e.target;
      // 삭제버튼 클릭한게 아니어야함
      if (
        !currentNode.classList.contains('btn-favor-delete') &&
        !currentNode.classList.contains('div-minus')
      ) {
        let tr;
        while (currentNode !== null) {
          if (currentNode.tagName === 'TR') {
            tr = currentNode;
            break;
          }
          currentNode = currentNode.parentNode;
        }
        // 즐겨찾기 정보 불러와서 세팅
        let favorNo = tr.dataset.no;
        MyAprData.selectLineList('favor', Number(favorNo));
      }
    });
};

// 전자결재 디테일 화면 모달창 관련 이벤트 부여구역
let setEndModalEvent = () => {
  // 반려버튼 이벤트
  document
    .getElementById('btn-return-approval')
    .addEventListener('click', () => {
      swal('반려 처리하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          // 결재 문서 반려 진행
          let approvalNo = Number(
            document.getElementById('end-approval').dataset.approvalno
          );

          MyAprData.updateApprovalReturn(approvalNo);
        }
      });
    });

  // 결재버튼 이벤트
  document
    .getElementById('btn-authorize-approval')
    .addEventListener('click', (e) => {
      swal('결재 진행하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          // 결재 문서 결재 진행
          let approvalNo = Number(
            document.getElementById('end-approval').dataset.approvalno
          );
          const lines = document.querySelectorAll('.end-approval-lines-item');
          let lastLine = lines[lines.length - 1];
          let lastLineUserNo = lastLine.dataset.userno;
          let loginUserNo = Number(e.target.dataset.userno);
          let myLevel = Number(e.target.dataset.mylevel);
          let contentHtml = null;

          // 본인이 마지막 결재자일 경우 완결처리위한 세팅 모두 하고 보내기
          if (lastLineUserNo == loginUserNo) {
            // Date 객체에서 연도, 월, 일 추출
            let tempDate = new Date();
            const year = tempDate.getFullYear();
            const month = tempDate.getMonth() + 1; // 월은 0부터 시작하므로 +1 해줍니다.
            const day = tempDate.getDate();

            // 추출한 연도, 월, 일로 문자열 생성해서 반환
            let nowDate = `${year}-${month.toString().padStart(2, '0')}-${day
              .toString()
              .padStart(2, '0')}`;

            // 마지막 라인에 이미지 넣기
            lastLine.querySelector(
              '.approver-sign'
            ).innerHTML = `<img src="${e.target.dataset.lastsrc}">`;
            // 마지막 라인에 현재날짜로 날짜 입력하기
            lastLine.querySelector('.approver-date').innerText = nowDate;

            // 완결처리를 위한 본문내용 세팅해서 보내기
            const content = document
              .querySelector('.final-approval-wrap')
              .cloneNode(true);
            let h2 = content.querySelector('.final-approval-wrap > h2');
            h2.remove();
            contentHtml = content.innerHTML;
          }

          // 내 라인상태 결재로 변경하기
          MyAprData.updateApprovalStateAuthorized(
            approvalNo,
            myLevel,
            contentHtml
          );
        }
      });
    });

  // 인쇄 버튼이벤트
  document
    .getElementById('btn-print-approval')
    .addEventListener('click', () => {
      const finalWrap = document.querySelector('.final-approval-wrap');
      const sw = screen.width;
      const sh = screen.height;
      const w = 800; //팝업창 가로길이
      const h = 600; //세로길이
      let xpos = (sw - w) / 2; //화면에 띄울 위치
      let ypos = (sh - h) / 2; //중앙에 띄웁니다.

      const pHeader = `<html>
                        <head>
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
                            <link rel="stylesheet" href="${path}/resources/css/common/common.css">
                            <link rel="stylesheet" href="${path}/resources/css/common/sidebar.css">
                            <link rel="stylesheet" href="${path}/resources/css/approval/endApprovalModal.css" />
                            <title></title>
                        </head>
                        <body>
                          <div class="final-approval-wrap">`;
      const pgetContent = finalWrap.innerHTML + '<br>';
      //이사이에 안넣고 싶은 div가 있다면 class print-none 추가해주면 됌

      const pFooter = '</div></body></html>';
      let pContent = pHeader + pgetContent + pFooter;

      let pWin = window.open(
        '',
        'print',
        'width=' +
          w +
          ',height=' +
          h +
          ',top=' +
          ypos +
          ',left=' +
          xpos +
          ',status=yes,scrollbars=yes'
      );

      pWin.document.open(); //팝업창 오픈
      pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
      setTimeout(() => {
        pWin.document.close(); //클로즈
        pWin.print(); //윈도우 인쇄 창
        pWin.close(); //닫기
      }, 100);
    });
};

// 내결재 화면 기본 이벤트들 부여구역
let setDefaultPageEvent = () => {
  // 상단 메뉴바 아이템들 클릭 이벤트 할당
  document.querySelectorAll('.top-menubar-item').forEach((item) => {
    item.addEventListener('click', (e) => {
      // e.target이 .top-menubar-item인지 확인
      let menubar = e.target;
      let count = 0;
      // 현재 클릭된 메뉴바 요소 찾는데 무한반복 방지 위해 최대 10번만 돌림
      while (menubar !== null && count < 10) {
        if (!menubar.classList.contains('top-menubar-item')) {
          menubar = menubar.parentNode;
          break;
        }
        count++;
      }

      document.querySelector('.top-menubar-item.selected').className =
        'top-menubar-item';

      menubar.className = 'selected top-menubar-item';

      // 선택된 메뉴에 맞게 셀렉트박스들 선택값 초기값으로 리셋
      let menu = menubar.dataset.menu;
      const currentYear = new Date().getFullYear();
      const year = document.getElementById('select-year');
      const type = document.getElementById('check-show-type');
      const status = document.getElementById('check-show-status');

      let html = ``;
      switch (menu) {
        case 'draft':
          html = `<option value="all" selected>상태 </option>
                <option value="0">진행중</option>
                <option value="1">완료</option>`;
          break;
        case 'temp':
          html = `<option value="2" selected>상태 </option>`;
          break;
        case 'return':
          html = `<option value="-1" selected >상태 </option>`;
          break;
        case 'refer':
          html = `<option value="all" selected>상태 </option>
                <option value="0">진행중</option>
                <option value="1">완료</option>
                <option value="-1" >반려</option>`;
          break;
        case 'wait':
          html = `<option value="0" selected>상태 </option>`;
          break;
        case 'authorized':
          html = `<option value="all" selected>상태 </option>
                <option value="0">진행중</option>
                <option value="1">완료</option>
                <option value="-1" >반려</option>`;
          break;
      }

      year.value = currentYear;
      status.innerHTML = html;
      type.value = -1;

      // 리셋 후 정보 불러오기
      MyAprData.selectApprovalList(
        Number(year.value),
        Number(type.value),
        1,
        menu,
        status.value
      );
    });
  });

  // 연도선택 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document.getElementById('select-year').addEventListener('change', (e) => {
    const menu = document.querySelector('.top-menubar-item.selected').dataset
      .menu;
    const type = Number(document.getElementById('check-show-type').value);
    const status = document.getElementById('check-show-status').value;

    // 페이지는 1페이지로 세팅
    MyAprData.selectApprovalList(Number(e.target.value), type, 1, menu, status);
  });

  // 테이블의 결재문서 종류 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document.getElementById('check-show-type').addEventListener('change', (e) => {
    const year = Number(document.getElementById('select-year').value);
    const menu = document.querySelector('.top-menubar-item.selected').dataset
      .menu;
    const status = document.getElementById('check-show-status').value;

    MyAprData.selectApprovalList(year, Number(e.target.value), 1, menu, status);
  });

  // 테이블의 결재문서 상태 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document
    .getElementById('check-show-status')
    .addEventListener('change', (e) => {
      const year = Number(document.getElementById('select-year').value);
      const type = Number(document.getElementById('check-show-type').value);
      const menu = document.querySelector('.top-menubar-item.selected').dataset
        .menu;

      MyAprData.selectApprovalList(year, type, 1, menu, e.target.value);
    });

  // 결재문서 리스트 테이블의 각 행들 눌렸을때 이벤트 부여
  document
    .querySelector('.my-approval-table tbody')
    .addEventListener('click', function (e) {
      // 부모 tr 찾기
      const tr = e.target.closest('tr');
      let approvalNo = tr.dataset.approvalno;
      let selectedMenu = document.querySelector('.selected.top-menubar-item')
        .dataset.menu;
      MyAprData.selectApproval(Number(approvalNo), selectedMenu);

      // 일단 클래스 빼기(== 읽음으로 처리)
      tr.className = '';

      //메모 리스트 일단 불러오기
      MyAprData.selectMemoList(Number(approvalNo));
    });
};

// 사인 모달 이벤트 영역
let signModalEvent = () => {
  // 사인 모달 열기 버튼
  document
    .getElementById('btn-open-sign-modal')
    .addEventListener('click', () => {
      MyAprData.selectSignImg();
      $('#sign-modal').modal('show');
    });

  // 신규 이미지 영역 클릭 시 인풋 클릭되도록 처리
  document.getElementById('img-new-sign').addEventListener('click', () => {
    document.getElementById('input-new-sign').click();
  });

  // 사인 이미지 인풋에 이미지 들어오면 미리보기 표시
  document
    .getElementById('input-new-sign')
    .addEventListener('change', (input) => {
      const newSignImg = document.getElementById('img-new-sign');
      let reader = new FileReader();

      reader.readAsDataURL(input.target.files[0]);

      reader.onload = function (e) {
        let url = e.target.result;
        newSignImg.src = url;
      };
    });

  // 저장버튼 클릭 시
  document.getElementById('btn-sign-img-save').addEventListener('click', () => {
    let formData = new FormData();
    const signImgInput = document.getElementById('input-new-sign');

    if (signImgInput.files.length > 0) {
      formData.append('signImg', signImgInput.files[0]);
      MyAprData.updateSignImg(formData);
    } else {
      swal('파일을 등록해주세요.', {
        buttons: { cancel: '확인' },
      });
    }
  });

  // 취소버튼
  document.querySelectorAll('.btn-sign-img-cancle').forEach((btn) => {
    btn.addEventListener('click', () => {
      $('#sign-modal').modal('hide');
    });
  });
};

// 메모 관련 이벤트들 부여구역
let setMemoEvent = () => {
  // 메모 버튼 클릭 이벤트
  document.querySelectorAll('.btn-memo-open').forEach((btn) => {
    btn.addEventListener('click', () => {
      /* 메모 리스트 오픈 */
      document.querySelector('#memo-modal-back .memo-list').style.display =
        'block';

      /* 메모 추가/디테일 화면 감추기 */
      document.querySelector('#memo-modal-back .memo-detail').style.display =
        'none';

      // 메모 모달 오픈
      $('#memo-modal-back').modal('show');
    });
  });

  // 메모 저장버튼 클릭 이벤트
  document
    .getElementById('btn-add-memo-save')
    .addEventListener('click', (e) => {
      const approvalNo =
        document.getElementById('end-approval').dataset.approvalno;

      let formData = new FormData();
      formData.append('approvalNo', approvalNo);
      formData.append(
        'content',
        document.getElementById('memo-add-content').value
      );
      for (let file of document.getElementById('input-memo-add-file').files) {
        formData.append('memoFiles', file);
      }
      if (e.target.dataset.memono == 'null') {
        //  메모 저장 요청
        MyAprData.insertMemo(formData);
      } else {
        let memoNo = e.target.dataset.memono;
        formData.append('memoNo', memoNo);
        MyAprData.updateMemo(formData);
      }
    });

  // 메모 행들 클릭 이벤트
  document
    .querySelector('#memo-modal-back .memo-list-table')
    .addEventListener('click', function (e) {
      // 부모 tr 찾기
      let memoNo = e.target.closest('tr').dataset.memono;
      MyAprData.selectMemo(Number(memoNo));
    });

  // 메모 삭제
  document
    .getElementById('btn-add-memo-delete')
    .addEventListener('click', () => {
      const approvalNo =
        document.getElementById('end-approval').dataset.approvalno;
      const memoNo =
        document.getElementById('btn-add-memo-save').dataset.memono;
      MyAprData.deleteMemo(memoNo, approvalNo);
    });
};

// 페이징 바 버튼 이벤트 할당구역
let pageBtnEvent = function () {
  // 각페이지 버튼에 이벤트 할당
  document.querySelectorAll('.page-btn').forEach(function (el) {
    el.addEventListener('click', function () {
      // 기존에 선택되어있던 버튼이 있었다면 선택 해제
      if (document.querySelector('.selected-btn') != null) {
        document.querySelector('.selected-btn').className = 'page-btn';
      }

      const year = Number(document.getElementById('select-year').value);
      const menu = document.querySelector('.top-menubar-item.selected').dataset
        .menu;
      const type = Number(document.getElementById('check-show-type').value);
      const status = document.getElementById('check-show-status').value;

      MyAprData.selectApprovalList(
        year,
        type,
        Number(this.innerText),
        menu,
        status
      );

      this.className = 'selected-btn page-btn';
    });
  });

  // 페이징바의 앞페이지 버튼 클릭시 동작
  document.getElementById('prev-btn').addEventListener('click', function () {
    const year = Number(document.getElementById('select-year').value);
    const menu = document.querySelector('.top-menubar-item.selected').dataset
      .menu;
    const type = Number(document.getElementById('check-show-type').value);
    const pageNum = Number(document.querySelectorAll('.page-btn')[0].innerText);
    const status = document.getElementById('check-show-status').value;

    if (pageNum > 10) {
      MyAprData.selectApprovalList(year, type, pageNum - 1, menu, status);
    } else {
      // 그럴일은 없겠지만 만약 앞페이지가 없는데 앞페이지 버튼을 눌렀을경우
      // 1번 버튼 눌린걸로 다시 세팅
      MyAprData.selectApprovalList(year, type, 1, menu, status);
    }
  });

  // 페이징바의 뒷페이지 버튼 클릭 시 동작
  document.getElementById('next-btn').addEventListener('click', function () {
    const year = Number(document.getElementById('select-year').value);
    const menu = document.querySelector('.top-menubar-item.selected').dataset
      .menu;
    const type = Number(document.getElementById('check-show-type').value);
    const pageNum = Number(document.querySelectorAll('.page-btn')[9].innerText);
    const status = document.getElementById('check-show-status').value;
    MyAprData.selectApprovalList(year, type, pageNum + 1, menu, status);
  });
};

//---------------------------- 윈도우 시작시 이벤트 부여 -----------------------------
window.onload = function () {
  Tiny.setTinymce();
  setDatePickerType(false); // 나중에 빼기
  extraAprModalEvent();
  selectFormModalEvent();
  selectAprLineModalEvent();
  pageBtnEvent();
  setDefaultPageEvent();
  setMemoEvent();
  signModalEvent();
  setEndModalEvent();
};
