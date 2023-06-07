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

export function setApprovalModalContent(approval) {
  if (approval.type == 0) {
    // 일반 타입이면 데이트 선택화면 없애기
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = 'none';
    });
  } else if (approval.type == 1) {
    // 연차 타입이면 데이트 선택 범위 선택되게
    // 종류 예시 연차 [ 10.5 / 19 ]
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = 'unset';
    });
    setDatePickerType(false);

    if (approval.startDate) {
    }
  } else {
    // 반차 타입이면 데이트 선택 하루만 되게
    document.querySelectorAll('.date-td').forEach((td) => {
      td.style.display = 'unset';
    });
    setDatePickerType(true);
  }

  $('#approval').modal('show');
}

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

// 신규 추가시 양식 선택 모달창 관련 이벤트 추가
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
      // if (formNo == 'none') {
      //   // 선택한 양식 없이 진행하는 것임 -> 결재 모달화면 내용 리셋시키기
      // } else {
      //   MyAprData.selectForm(Number(formNo));
      // }

      $('#approval').modal('show');
    });
};

// 추가적으로 기안서 작성/수정 모달 안의 이벤트 부여
// 기본 이벤트들은 approvalModal.js 안에 있음.
// db와 통신하는 등의 추가적인 이벤트들만 따로 작성해서 부여할 예정
let extraAprModalEvent = function () {
  // 결재라인 모달 열기
  document
    .getElementById('btn-add-lines')
    .addEventListener('click', function () {
      MyAprData.selectMemberList('');

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

      //todo! 내 즐겨찾기 리스트 불러오는 로직 필요

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
      // todo! 즐겨찾기에 현재 결재라인 저장
      // 저장이후 결과에 따라 저장되고/ 안되고 메세지 표시
      // + 내 즐겨찾기 리스트 다시 받아다 모달에 뿌려주기

      // 즐겨찾기 창 닫기
      document.querySelector('.favor-modal-back').style.display = 'none';
      swal('즐겨찾기가 저장되었습니다.', {
        buttons: { cancel: '확인' },
      });
    });
};

//-------------------- 윈도우 시작시 이벤트 부여 --------------------
window.onload = function () {
  Tiny.setTinymce();
  setDatePickerType(false); // 나중에 빼기
  extraAprModalEvent();
  selectFormModalEvent();
};
