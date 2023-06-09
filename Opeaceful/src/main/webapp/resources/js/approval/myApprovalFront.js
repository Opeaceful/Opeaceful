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
      'linear-gradient( #ffff0000, 99%, #f1f1f1 )';
  } else {
    document.querySelector('.org-chart').style.background = 'unset';
  }
}

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

// 서버에서 가져온 이미지 src 경로 재설정 해주는 함수
// path경로가 변경될 경우를 대비
let changeImgPath = function () {
  let imgArr = tinymce
    .get('form-tiny')
    .contentDocument.getElementsByTagName('img');

  if (imgArr) {
    for (let img of imgArr) {
      let imgSrc = img.src;
      // 신규로 추가된 이미지들의 src는 blob로 시작되도록 해두었음
      // 그외 / 로 시작하지 않는 기존 이미지들 src 갈아끼기
      if (!imgSrc.startsWith('blob')) {
        // 이미지 실제 이름만 가져옴
        imgSrc = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);

        // 이미지 경로 재설정
        img.src = path + '/resources/file/approval/' + imgSrc;
      }
    }
  }
};

// 결재 수정/작성 모달 창 내용 리셋시켜주는 함수
export function setApprovalModalContent(approval) {
  console.log(approval);

  const typeTd = document.getElementById('td-approval-table-type');

  // 타입을 종류 태그에 저장
  typeTd.dataset.type = approval.type;

  // 만약 수정일경우를 대비해서 결재번호도 저장시켜둠
  typeTd.dataset.no = approval.approvalNo ? approval.approvalNo : 'none';

  // 제목 리셋
  document.getElementById('approval-title').value = approval.title
    ? approval.title
    : '';

  // todo! 결재라인.... 첨부.... 기존에 내용 있었으면 끌어오기

  // 결재라인 리셋
  document.querySelector(
    '#approval .approval-lines > ol.scroll-bar'
  ).innerHTML = '';

  // 첨부파일 리스트 리셋
  document.querySelector('#approval .approval-files > .scroll-bar').innerHTML =
    '';

  // 첨부파일인풋의 실제 파일들 리셋
  document.querySelector('#input-add-file').files = new DataTransfer().files;

  // 내용 리셋
  tinymce.get('form-tiny').setContent(approval.content ? approval.content : '');
  // 내용 리셋시킨 후 이미지 src들 갈아껴주기
  changeImgPath();

  if (approval.type == 0) {
    // 일반 타입이면 데이트 선택화면 없애기
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = 'none';
    });

    typeTd.innerHTML = '일반';
  } else if (approval.type == 1) {
    // 연차 타입이면 데이트 선택 범위 선택되게
    // 종류 예시 연차 [ 10.5 / 19 ]
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = '';
    });

    // todo! 나중에 연차정보 조회해서 와야함
    typeTd.innerHTML = '연차 [ 10 / 19 ]';

    // 수정일 경우 날짜 정보 들어올테니 그에 맞게 날짜 표시
    if (approval.startDate && approval.endDate) {
      setDatePickerType(false, approval.startDate, approval.endDate);
    } else {
      setDatePickerType(false);
    }
  } else {
    // 반차 타입이면 데이트 선택 하루만 되게
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = '';
    });

    // todo! 나중에 연차정보 조회해서 와야함
    if (approval.type == 2) {
      typeTd.innerHTML = '오전반차 [ 10 / 19 ]';
    } else {
      typeTd.innerHTML = '오후반차 [ 10 / 19 ]';
    }

    // 수정일 경우 날짜 정보 들어올테니 그에 맞게 날짜 표시
    if (approval.startDate) {
      setDatePickerType(true, startDate);
    } else {
      setDatePickerType(true);
    }
  }

  $('#approval').modal('show');
}

// 셀렉트박스에 양식 리스트 넣어주는 함수
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
                  <i class="fa-solid fa-minus"></i>
                </button>
              </div>
            </li>`;
  }

  // 결재라인 갈아껴주기
  ol.innerHTML = html;
}

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
// 기본 이벤트들은 approvalModal.js 안에 있음.
// db와 통신하는 등의 추가적인 이벤트들만 따로 작성해서 부여할 예정
let extraAprModalEvent = () => {};

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
                      <i class="fa-solid fa-minus"></i>
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

      console.log(favor);
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

//---------------------------- 윈도우 시작시 이벤트 부여 -----------------------------
window.onload = function () {
  Tiny.setTinymce();
  setDatePickerType(false); // 나중에 빼기
  extraAprModalEvent();
  selectFormModalEvent();
  selectAprLineModalEvent();
};
