/**
 * [지의] - main.js
 */
import { path } from './common/common.js';
/* --------------------------- 현재 시간 표시 --------------------------- */
const today = document.getElementById('main-day');
const time = document.getElementById('main-time');

let d = new Date();

let year = d.getFullYear(); // 년도
let month = d.getMonth() + 1; // 월
let date = d.getDate(); // 날짜
let hur = d.getHours(); // 시
let min = d.getMinutes(); //분
let sec = d.getSeconds(); //초

if (d.getHours() < 10) {
  hur = '0' + hur;
}
if (d.getMinutes() < 10) {
  min = '0' + min;
}
if (d.getSeconds() < 10) {
  sec = '0' + sec;
}

let weekday = new Array(7);
weekday[0] = '일';
weekday[1] = '월';
weekday[2] = '화';
weekday[3] = '수';
weekday[4] = '목';
weekday[5] = '금';
weekday[6] = '토';

let day = weekday[d.getDay()];

if (month < 10) {
  month = '0' + month;
}
if (date < 10) {
  date = '0' + date;
}
today.innerHTML = year + '-' + month + '-' + date + ' (' + day + ')';

function getTime() {
  let d = new Date();

  let hur = d.getHours(); // 시
  let min = d.getMinutes(); //분
  let sec = d.getSeconds(); //초
  if (d.getHours() < 10) {
    hur = '0' + hur;
  }
  if (d.getMinutes() < 10) {
    min = '0' + min;
  }
  if (d.getSeconds() < 10) {
    sec = '0' + sec;
  }

  time.innerHTML = hur + ' : ' + min + ' : ' + sec; // 형식 지정

  setTimeout(getTime, 1000); //1000밀리초(1초) 마다 반복
}

/* --------------------------- 접속상태 표시 --------------------------- */
function onClickState(e) {
  const isActive = e.currentTarget.className.indexOf('active') !== -1;
  if (isActive) {
    e.currentTarget.className = 'select';
  } else {
    e.currentTarget.className = 'select active';
  }
}

document
  .querySelector('#state .select')
  .addEventListener('click', onClickState);

function onClickStateOption(e) {
  const selectedValue = e.currentTarget.innerHTML;
  document.querySelector('#state .text').innerHTML = selectedValue;
  /* --------------------------- 접속 상태 변경 --------------------------- */
  $.ajax({
    type: 'POST',
    dataType: 'json',
    data: { statusType: e.currentTarget.id },
    url: path + '/member/updateStatusType',
    success: function (statusType) {
      // 채팅 모달 option도 변경
      $('#statusList').val(`${statusType}`).prop('selected', true);
    },
    error: function (e) {
      console.log(e.target);
    },
  });
}

var stateList = document.querySelectorAll('#state .option');
for (let i = 0; i < stateList.length; i++) {
  let state = stateList[i];
  state.addEventListener('click', onClickStateOption);
}

/* --------------------------- 칼라모드 표시 --------------------------- */
function onClickMode(e) {
  const isActive = e.currentTarget.className.indexOf('active') !== -1;
  if (isActive) {
    e.currentTarget.className = 'mode-select';
  } else {
    e.currentTarget.className = 'mode-select active';
  }
}

document
  .querySelector('#color-mode .mode-select')
  .addEventListener('click', onClickMode);

function onClickModeOption(e) {
  const selectedValue = e.currentTarget.innerHTML;
  document.querySelector('#color-mode .mode-text').innerHTML = selectedValue;
}

let ModeList = document.querySelectorAll('#color-mode .mode');
for (var i = 0; i < ModeList.length; i++) {
  let mode = ModeList[i];
  mode.addEventListener('click', onClickModeOption);
}

/*다크모드, 화이트모드 변경 : 윤지영에게 문의*/
$('#white-icon').on('click', function () {
  localStorage.setItem('color-theme', 'light');
  // 페이지 새로고침 : 아이콘 색바꿔야해서 새로고침
  location.reload();
});
$('#black-icon').on('click', function () {
  localStorage.setItem('color-theme', 'dark');
  // 페이지 새로고침 : 아이콘 색바꿔야해서 새로고침
  location.reload();
});
/* 다크모드, 화이트모드 아이콘 변경 */
$(function () {
  if (localStorage.getItem('color-theme') == 'light') {
    document.querySelector('.color-show').setAttribute('id', 'white');
  } else {
    document.querySelector('.color-show').setAttribute('id', 'black');
  }
});

/* --------------------------- 입사날짜 구하기 --------------------------- */
$(function () {
  // mainHireDate : main.jsp에서 입사날짜 빼옴
  let hireDate = new Date(mainHireDate);

  let ms = d.getTime() - hireDate.getTime();
  let dDay = ms / (1000 * 60 * 60 * 24);

  document.getElementById('main-d-day').innerHTML = Math.floor(dDay);
});

/* --------------------------- 공지사항 제목부분 클릭시 공지사항 페이지로 --------------------------- */
$('#main-notice-title').on('click', function () {
  location.href = path + '/board/list/N';
});

/* --------------------------- 출근 등록 --------------------------- */
$('#main-on').click(function () {
  swal(hur + ':' + min, '출근 처리 하시겠습니까?', {
    buttons: { confirm: '확인', cancel: '취소' },
  }).then(function (isConfirm) {
    if (isConfirm) {
      $.ajax({
        type: 'POST',
        //url : "",
        url: path + '/attendance/workOn',
        dataType: 'json',
        success: function (result) {
          if (result > 0) {
            location.reload();
          }
        },
        error: function (e) {
          swal('error');
        },
      });
    }
  });
});

/* --------------------------- 퇴근 등록 --------------------------- */
$('#main-off').click(function () {
  swal(hur + ':' + min, '퇴근 처리 하시겠습니까?', {
    buttons: { confirm: '확인', cancel: '취소' },
  }).then(function (isConfirm) {
    if (isConfirm) {
      $.ajax({
        type: 'POST',
        // url : "",
        url: path + '/attendance/workOff',
        dataType: 'json',
        success: function (result) {
          if (result > 0) {
            location.reload();
          }
        },
        error: function (e) {
          swal('error');
        },
      });
    }
  });
});

/* --------------------------- 캘린더 --------------------------- */
document.addEventListener('DOMContentLoaded', function() {
    var calendarM = document.getElementById('calendarM');
    function fullCalendar(){
        /* 전체 캘린더 */
        var request = $.ajax({
            type:"POST",
            url: path+"/calendar/calendarForm/F",
            dataType: "json"
        });
      
        request.done(function(data){
            // console.log(data);
      
            var calendar = new FullCalendar.Calendar(calendarM, {
                plugins: [ 'interaction', 'dayGrid' ],
                header: {
                    left: 'none',
                    center: 'prevYear,prev,title,next,nextYear',
                    right: 'none'
                },
                editable: false, // 일정 움직이는거 막기
                eventLimit: false, // allow "more" link when too many events
                events: data
            });
            calendar.render();
        })
      
        request.fail(function() {
            alert("Request failed");
        });
    }
    fullCalendar();
});
// 시간표시 함수 실행
getTime();

// (승은) 전자결재 이동용 이벤트 부여구역
document.getElementById('main-sign-go').addEventListener('click', () => {
  location.href = path + '/approval/myApproval';
});
document.getElementById('main-sign-ck').addEventListener('click', () => {
  location.href = path + '/approval/myApproval';
});
document.getElementById('main-sign-wait').addEventListener('click', () => {
  location.href = path + '/approval/myApproval?menu=wait';
});
