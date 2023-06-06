import * as Tiny from './tinyEditor.js';
import { path } from '../common/common.js';

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
};

//-------------------- 윈도우 시작시 이벤트 부여 --------------------
window.onload = function () {
  Tiny.setTinymce();
  setDatePicker();
  setDatePickerType(); // 나중에 빼기
  approvalModalEvent();
};
