import { path } from '../common/common.js';
import * as AllAprData from './allApprovalData.js';

// 멤버 테이블 내용 갈아껴주는 함수
export function setSelectMemberTable(result, ismodalOpen) {
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
    }(${deptMember[deptm][0].eno})</td>
        </tr>
        `;

    for (let i = 1; i < deptMember[deptm].length; i++) {
      html += `
            <tr>
                <td  class="org-table-member" value="${
                  deptMember[deptm][i].userNo
                }" >${deptMember[deptm][i].userName}  ${
        deptMember[deptm][i].pName ? deptMember[deptm][i].pName : ''
      }(${deptMember[deptm][i].eno})</td>
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

  if (ismodalOpen) {
    // 한 8명 넘어가면 아래 스크롤표시용 그라데이션 넣어줌
    if (result.length > 8) {
      document.querySelector('.org-chart').style.background =
        'var(--color-linear)';
    }
    $('#modal-select-search-user').modal('show');
  }
}

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

// 날짜 형식 yyyy-MM-dd로포맷팅해서 반환
let formatDate = (date) => {
  let tempDate = new Date(Date.parse(date));
  console.log('날짜변환중 ', tempDate);

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

// 결재 리스트 테이블 아이템 갈아끼기
export function setTableList(approvalList, count, page) {
  // 최신정보로 페이지 버튼 정보 리셋
  if (resetPageBtn(page, count)) {
    // 버튼 리셋되면서 페이지 이동이 일어나게 된다면 함수 종료
    return;
  }
  console.log('버튼 리셋 완료되고 테이블 리셋 시작됨');
  let tableHtml = '';

  if (approvalList != null && approvalList.length > 0) {
    for (let i in approvalList) {
      let approval = approvalList[i];

      approval.type = formatApprovalType(approval.type);
      approval.status = formatApprovalStatus(approval.status);

      tableHtml += `<tr 
                        data-approvalno="${approval.approvalNo}">
                      <td>${count - i - (page - 1) * 10}</td>
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
  document.querySelector('.all-approval-table tbody').innerHTML = tableHtml;
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
    console.log(clickBtn);
    clickBtn.className = 'selected-btn page-btn';
  }

  return false;
}

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
  const returnBtn = document.getElementById('btn-return-approval');
  //결재버튼
  const authorizeBtn = document.getElementById('btn-authorize-approval');

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

  // 기본적으로 결재/반려버튼 비활성화
  returnBtn.style.display = 'none';
  authorizeBtn.style.visibility = 'hidden';

  // 내용 세팅 끝난 후  모달 오픈
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

//  결재 모달창 닫기
export function closeApprovalModal() {
  $('#end-approval').modal('hide');
}

export function clickCurrentPageBtn() {
  // 현재 선택되어있는정보대로 페이지 다시 세팅해주기
  // 선택되어있는 버튼에 클릭 보냄
  document.querySelector('.selected-btn.page-btn').click();
}

//------------------------- 이벤트 부여 구역--------------------------

let defaultEvent = () => {
  // 결재문서 리스트 테이블의 각 행들 눌렸을때 이벤트 부여
  document
    .querySelector('.all-approval-table tbody')
    .addEventListener('click', function (e) {
      // 부모 tr 찾기
      const tr = e.target.closest('tr');
      let approvalNo = tr.dataset.approvalno;

      AllAprData.selectApproval(Number(approvalNo));

      // 일단 클래스 빼기(== 읽음으로 처리)
      tr.className = '';

      //메모 리스트 일단 불러오기
      AllAprData.selectMemoList(Number(approvalNo));
    });
};

let filterEvent = () => {
  // 연도선택 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document.getElementById('select-year').addEventListener('change', (e) => {
    const userNo = document.querySelector('.div-searched-member-name').dataset
      .userno;
    const keyword = document.getElementById('input-search-title').value;
    const type = Number(document.getElementById('check-show-type').value);
    const status = document.getElementById('check-show-status').value;
    // 페이지는 1페이지로 세팅
    AllAprData.searchApprovalList(
      userNo ? Number(userNo) : -1,
      Number(e.target.value),
      type,
      1,
      status,
      keyword
    );
  });

  // 테이블의 결재문서 종류 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document.getElementById('check-show-type').addEventListener('change', (e) => {
    const year = Number(document.getElementById('select-year').value);
    const userNo = document.querySelector('.div-searched-member-name').dataset
      .userno;
    const keyword = document.getElementById('input-search-title').value;
    const status = document.getElementById('check-show-status').value;
    // 페이지는 1페이지로 세팅
    AllAprData.searchApprovalList(
      userNo ? Number(userNo) : -1,
      year,
      Number(e.target.value),
      1,
      status,
      keyword
    );
  });

  // 테이블의 결재문서 상태 셀렉트박스 값 변경시 서버에서 정보 조회해오기
  document
    .getElementById('check-show-status')
    .addEventListener('change', (e) => {
      const year = Number(document.getElementById('select-year').value);
      const type = Number(document.getElementById('check-show-type').value);
      const userNo = document.querySelector('.div-searched-member-name').dataset
        .userno;
      const keyword = document.getElementById('input-search-title').value;
      // 페이지는 1페이지로 세팅
      AllAprData.searchApprovalList(
        userNo ? Number(userNo) : -1,
        year,
        type,
        1,
        e.target.value,
        keyword
      );
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

  // 문서 삭제 버튼에 이벤트 부여
  document
    .getElementById('btn-delete-approval')
    .addEventListener('click', () => {
      swal('문서를 삭제 하시겠습니까?', {
        buttons: { confirm: '확인', cancel: '취소' },
      }).then(function (isConfirm) {
        if (isConfirm) {
          // 결재 문서 삭제 진행
          let approvalNo =
            document.getElementById('end-approval').dataset.approvalno;
          console.log('삭제할 문서 번호 ', approvalNo);
          AllAprData.deleteApproval(Number(approvalNo));
        }
      });
    });
};

let searchMemberEvent = () => {
  // 사원검색 칸 클릭 이벤트
  document
    .getElementById('div-select-member-search')
    .addEventListener('click', () => {
      AllAprData.selectMemberList('', true);
    });

  // 멤버 검색 창에 검색어 입력시 이벤트
  document
    .querySelector('.org-chart .input-search-member')
    .addEventListener('keyup', function () {
      let keyword = document.querySelector(
        '.org-chart .input-search-member'
      ).value;
      AllAprData.selectMemberList(keyword, false);
    });

  // 사원 테이블에서 사원명 클릭시 선택
  document
    .getElementById('select-member-table')
    .addEventListener('click', function (e) {
      if (e.target.className == 'org-table-member') {
        let seleted = document.querySelector('.org-table-selected-member');

        if (seleted) {
          seleted.classList.remove('org-table-selected-member');
        }

        e.target.classList.add('org-table-selected-member');
      }
    });

  // 저장버튼 클릭 시 이벤트
  document
    .getElementById('btn-select-search-member')
    .addEventListener('click', () => {
      let seleted = document.querySelector('.org-table-selected-member');

      if (seleted) {
        let searchDiv = document.querySelector('.div-searched-member-name');
        let userNo = seleted.getAttribute('value');
        let userName = seleted.innerText;

        searchDiv.innerText = userName;
        searchDiv.dataset.userno = userNo;

        const year = Number(document.getElementById('select-year').value);
        const type = Number(document.getElementById('check-show-type').value);
        const status = document.getElementById('check-show-status').value;
        const keyword = document.getElementById('input-search-title').value;

        AllAprData.searchApprovalList(
          Number(userNo),
          year,
          type,
          1,
          status,
          keyword
        );

        $('#modal-select-search-user').modal('hide');
      } else {
        swal('선택된 사원이 없습니다.', {
          buttons: { cancel: '확인' },
        });
      }
    });

  // 선택해제 버튼 클릭 이벤트
  document
    .getElementById('btn-reset-search-member')
    .addEventListener('click', () => {
      let searchDiv = document.querySelector('.div-searched-member-name');
      let seleted = document.querySelector('.org-table-selected-member');

      if (seleted) {
        seleted.classList.remove('org-table-selected-member');
      }
      searchDiv.innerText = '사원 검색';
      searchDiv.dataset.userno = -1;

      const year = Number(document.getElementById('select-year').value);
      const type = Number(document.getElementById('check-show-type').value);
      const status = document.getElementById('check-show-status').value;
      const keyword = document.getElementById('input-search-title').value;

      AllAprData.searchApprovalList(-1, year, type, 1, status, keyword);
      $('#modal-select-search-user').modal('hide');
    });

  // 제목 검색칸 이벤트
  document.getElementById('input-search-title').addEventListener('blur', () => {
    document.querySelector('.selected-btn').click();
  });

  // 제목 검색칸 엔터 이벤트
  document
    .getElementById('input-search-title')
    .addEventListener('keyup', (e) => {
      let key = e.key || e.keyCode;
      if (key === 'Enter' || key === 13) {
        document.querySelector('.selected-btn').click();
      }
    });

  // 검색 아이콘 이벤트
  document
    .querySelector('.div-search-input-wrap button')
    .addEventListener('click', () => {
      document.querySelector('.selected-btn').click();
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
        AllAprData.insertMemo(formData);
      } else {
        let memoNo = e.target.dataset.memono;
        formData.append('memoNo', memoNo);
        AllAprData.updateMemo(formData);
      }
    });

  // 메모 행들 클릭 이벤트
  document
    .querySelector('#memo-modal-back .memo-list-table')
    .addEventListener('click', function (e) {
      console.log(e.target, ' td눌림', e.target.tagName);

      // 부모 tr 찾기
      let memoNo = e.target.closest('tr').dataset.memono;
      AllAprData.selectMemo(Number(memoNo));
    });

  // 메모 삭제
  document
    .getElementById('btn-add-memo-delete')
    .addEventListener('click', () => {
      const approvalNo =
        document.getElementById('end-approval').dataset.approvalno;
      const memoNo =
        document.getElementById('btn-add-memo-save').dataset.memono;
      AllAprData.deleteMemo(memoNo, approvalNo);
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
      const type = Number(document.getElementById('check-show-type').value);
      const status = document.getElementById('check-show-status').value;
      const userNo = document.querySelector('.div-searched-member-name').dataset
        .userno;

      const keyword = document.getElementById('input-search-title').value;

      AllAprData.searchApprovalList(
        userNo ? Number(userNo) : -1,
        year,
        type,
        Number(this.innerText),
        status,
        keyword
      );

      this.className = 'selected-btn page-btn';
    });
  });

  // 페이징바의 앞페이지 버튼 클릭시 동작
  document.getElementById('prev-btn').addEventListener('click', function () {
    const year = Number(document.getElementById('select-year').value);
    const type = Number(document.getElementById('check-show-type').value);
    const pageNum = Number(document.querySelectorAll('.page-btn')[0].innerText);
    const status = document.getElementById('check-show-status').value;

    const userNo = document.querySelector('.div-searched-member-name').dataset
      .userno;

    const keyword = document.getElementById('input-search-title').value;

    if (pageNum > 10) {
      AllAprData.searchApprovalList(
        userNo ? Number(userNo) : -1,
        year,
        type,
        pageNum - 1,
        status,
        keyword
      );
    } else {
      // 그럴일은 없겠지만 만약 앞페이지가 없는데 앞페이지 버튼을 눌렀을경우
      // 1번 버튼 눌린걸로 다시 세팅
      AllAprData.searchApprovalList(userNo, year, type, 1, status, keyword);
    }
  });

  // 페이징바의 뒷페이지 버튼 클릭 시 동작
  document.getElementById('next-btn').addEventListener('click', function () {
    const year = Number(document.getElementById('select-year').value);
    const type = Number(document.getElementById('check-show-type').value);
    const pageNum = Number(document.querySelectorAll('.page-btn')[9].innerText);
    const status = document.getElementById('check-show-status').value;

    const userNo = document.querySelector('.div-searched-member-name').dataset
      .userno;
    const keyword = document.getElementById('input-search-title').value;

    AllAprData.searchApprovalList(
      userNo ? Number(userNo) : -1,
      year,
      type,
      pageNum + 1,
      status,
      keyword
    );
  });
};

//----------------------- 윈도우 시작 이후 동작------------------------------

window.onload = function () {
  searchMemberEvent();
  filterEvent();
  pageBtnEvent();
  defaultEvent();
  setMemoEvent();
};
