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
            <td rowspan="${deptMember[deptm].length}" >${deptMember[deptm][0].dName}</td>
            <td value="${deptMember[deptm][0].userNo}" >${deptMember[deptm][0].userName}</td>
        </tr>
        `;

    for (let i = 1; i < deptMember[deptm].length; i++) {
      html += `
            <tr>
                <td value="${deptMember[deptm][i].userNo}" >${deptMember[deptm][i].userName}</td>
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

let setDatePicker = function () {
  $('#date').daterangepicker();
  $('#date').on('show.daterangepicker', function (ev, picker) {
    $('.yearselect').css('float', 'left');
    $('.monthselect').css('float', 'right');
    $('.cancelBtn').css('float', 'right');
  });
};

let setDatePickerType = function (type) {
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

  if (type == 'single') {
    setting.singleDatePicker = true;
  }

  console.log(setting);

  $('#date').daterangepicker(setting);
};

// 기안서 작성/수정 모달 안의 이벤트 부여 구역
let approvalModalEvent = function () {
  // 결재라인 모달 열기
  document
    .getElementById('btn-add-lines')
    .addEventListener('click', function () {
      MyAprData.selectMemberList('');
      document.getElementById('approval-line-modal').style.display = 'flex';
    });

  // 결재라인 모달 닫기
  document
    .getElementById('btn-approval-line-modal-close')
    .addEventListener('click', function () {
      document.getElementById('approval-line-modal').style.display = 'none';
    });

  // 첨부 버튼 클릭 시 이벤트
  document
    .getElementById('btn-add-file')
    .addEventListener('click', function () {});

  // 결재라인 멤버 검색 창 이벤트
  document
    .querySelector('.org-chart .input-search-member')
    .addEventListener('keyup', function () {
      let keyword = document.querySelector(
        '.org-chart .input-search-member'
      ).value;
      MyAprData.selectMemberList(keyword);
    });
};

//-------------------- 윈도우 시작시 이벤트 부여 --------------------
window.onload = function () {
  Tiny.setTinymce();
  setDatePicker();
  setDatePickerType(); // 나중에 빼기
  approvalModalEvent();
};
