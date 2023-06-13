/**
 * [혜린]
 */

import {path} from '../common/common.js';
/* dataSet */
let category = document.getElementById('calendar-wrap').dataset.category;
//let cno = document.getElementById('modal-submit-btn').dataset.submit;
  //=======================================  

  
    // ===== 일정추가 모달 내 카테고리 색 지정박스 =====
    //color box div
    let mycol = $(".my-event-col-box");
    let tmcol = $(".tm-event-col-box");
    
    $('.my-event-btn').on('click', function(){
      // console.log("mine check");
      tmcol.css('display', 'none');
      mycol.css('display', 'block');
      modalReset();
    })

    $('.tm-event-btn').on('click', function(){
      // console.log("team check");
      mycol.css('display', 'none');
      tmcol.css('display', 'block');
      modalReset();
    })
    /* 디데이 호버 시 x 버튼 -> 개별로 수정하기!!!!!!!!!!!!11 */
    $(".d-event").hover(function(){
      $(".d-xbtn").css('display', 'block');
    }, function(){
      $(".d-xbtn").css('display', 'none');
    })
    /* 모달 버튼 비활성용 객체 */
    let abled = {
      title: false,
      start: false,
      end: false
    }

    /* 일정 추가 버튼 클릭 시 모달 리셋 */
    $('#addEventBtn').on('click', function(){
      $('#modal-submit-btn').html('일정등록');
      modalReset();
      enable();
    })
    /* 일정 모달 닫기 버든 클릭 함수 */
    function hiddenModal(){
      $('#modal-cancel-btn').click();
    }


    //submit 버튼 클릭
let eveSubmitBtn = $('#modal-submit-btn');

eveSubmitBtn.on('click', function(){
  //insertEvent함수 실행
  insertEvent();
  //모달 닫기
  hiddenModal();
})

  
  /* 모달 일정등록버튼 비활성 함수 */
  function enable(){
    let eveSubmitBtn = document.getElementById('modal-submit-btn');
    
    for(let a in abled){
      if(!abled[a]){
        eveSubmitBtn.disabled = true;
        console.log(abled);
        return;
      }
    }
    eveSubmitBtn.disabled = false;
  }

  $('input[name=dateStart]').focusout(function(){
    if($('input[name=dateStart]').val() == ""){
      abled.start = false;
      console.log(abled);
    }else{
      abled.start = true;
      console.log(abled);
    }
    enable();
  })
  $('input[name=dateEnd]').focusout(function(){
    if($('input[name=dateEnd]').val() == ""){
      abled.end = false;
      console.log(abled);
    }else{
      abled.end = true;
      console.log(abled);
    }
    enable();
  })
  $('#event-title').keyup(function(){
    if($('#event-title').val() == ""){
     abled.title = false;
     console.log(abled);
    }
    if($('#event-title').val() != ""){
      abled.title = true;
      console.log(abled);
    }
    enable();
  })

/* 모달 리셋용 함수 */
function modalReset(){
 $('input[name=dateStart]').val("");
 $('input[name=dateEnd]').val("");
 $('#event-title').val("");
 $('.event-content').val("");
 $('input:radio[name="color"]').prop("checked", false);
 $('input:radio[name="t-color"]').prop("checked", false);
 $('input:checkbox[name=event-d-day]').prop("checked", false);
}


function insertEvent(){
  /* 모달 input 변수들 */
  let eventRadio = $('input:radio[name="event"]:checked').val();
  let startDate = $('input[name=dateStart]').val();
  let endDate = $('input[name=dateEnd]').val();
  let eveTitle = $('#event-title').val();
  let eveContent = $('.event-content').val();
  let eveColorM = $('input:radio[name="color"]:checked').val();
  let eveColorT = $('input:radio[name="t-color"]:checked').val();
  let eveDday = $('input:checkbox[name=event-d-day]:checked').val();
  
  $.ajax({
    type: 'POST',
    url: path+"/calendar/insertEvent",
    data: {category: eventRadio, title: eveTitle, content: eveContent, dDay: eveDday ? 'Y' : 'N'
          ,startDate: startDate, endDate: endDate, colorM: eveColorM, colorT: eveColorT},
    success: function(result){
      if(result>0){
        swal('일정이 등록되었습니다.', {
          buttons: { cancel: '확인' },
        });

        eventList(); // 새로 조회

      }
    },error: function(){
      console.log("ajax insertEvent 에러");
    }



  })
}

//일정클릭 => 수정모달 초기세팅
//1) 삭제버튼 디스플레이 블록, 일정등록버튼 글씨 수정으로 변경




 document.addEventListener('DOMContentLoaded', function() {

    var calendarM = document.getElementById('calendarM');
   // var calendarT = document.getElementById('calendarT');
   // var calendarF = document.getElementById('calendarF');

    var calendarMini = document.getElementById('mini-calendar');
 


  //=======================================  

  function myCalendar(){
    /* 내 캘린더 */
    var request = $.ajax({
      type:"POST",
      url: path+"/calendar/calendarForm/M",
      dataType: "json"
    })

    request.done(function(data){
      console.log(data);

    var calendar = new FullCalendar.Calendar(calendarM, {
      plugins: [ 'interaction', 'dayGrid' ],
      header: {
        left: 'none',
        center: 'prevYear,prev,title,next,nextYear',
        right: 'today'
      },
      //defaultDate: '2020-02-12', //defaultDate없으면 현재날짜 -> 나중에 지워주기
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: data
    });
    calendar.render();
 })

  request.fail(function() {
    alert( "Request failed");
  });
}

//=======================================

function teamCalendar(){
  /* 팀 캘린더 */
  var request = $.ajax({
    type:"POST",
    url: path+"/calendar/calendarForm/T",
    dataType: "json"
  })

  request.done(function(data){
    console.log(data);

  var calendar = new FullCalendar.Calendar(calendarM, {
    plugins: [ 'interaction', 'dayGrid' ],
    header: {
      left: 'none',
      center: 'prevYear,prev,title,next,nextYear',
      right: 'today'
    },
    //defaultDate: '2020-02-12', //defaultDate없으면 현재날짜 -> 나중에 지워주기
    editable: true,
    eventLimit: true, // allow "more" link when too many events
    events: data
  });
  calendar.render();
})

request.fail(function() {
  alert( "Request failed");
});
}

//=======================================

function fullCalendar(){
  /* 전체 캘린더 */
  var request = $.ajax({
    type:"POST",
    url: path+"/calendar/calendarForm/F",
    dataType: "json"
  })

  request.done(function(data){
    console.log(data);

  var calendar = new FullCalendar.Calendar(calendarM, {
    plugins: [ 'interaction', 'dayGrid' ],
    header: {
      left: 'none',
      center: 'prevYear,prev,title,next,nextYear',
      right: 'today'
    },
    //defaultDate: '2020-02-12', //defaultDate없으면 현재날짜 -> 나중에 지워주기
    editable: true,
    eventLimit: true, // allow "more" link when too many events
    events: data
  });
  calendar.render();
})

request.fail(function() {
  alert( "Request failed");
});
}


function miniCalendar(){
  /* 미니 캘린더 */
  var request = $.ajax({
    type:"POST",
    url: path+"/calendar/calendarForm/F",
    dataType: "json"
  })

  request.done(function(data){
    console.log(data);

    var calendarMin = new FullCalendar.Calendar(calendarMini, {
      aspectRatio: 1.2,
      plugins: [ 'interaction', 'dayGrid' ],
      header: {
        left: 'none',
        center: 'prev,title,next',
        right: 'none'
      },
      // defaultDate: '2020-02-12', //defaultDate없으면 현재날짜 -> 나중에 지워주기
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: data
    });

   
    calendarMin.render();
  })

request.fail(function() {
  alert( "Request failed");
});
}
function eventList(){
  if(category == 'M'){
    myCalendar();
  }
  if(category == 'T'){
    teamCalendar();
  }
  if(category == 'F'){
    fullCalendar();
  }
}
eventList();
miniCalendar();



// if($('.input-memo').focus()){
//     console.log(" 포커스 눌림");
//     $('.memo-wrap').css('background-color', 'rgba(197, 194, 194, 0.342)');
// }


 })

 /* 캘린더 내부 메모 */
 $('.input-memo').focusout(function(){
    // if(this.val != ""){
      
    // }

    $.ajax({
      type: 'POST',
      url: path+"/calendar/addMemo",
      data: {memo: $('.input-memo').val()},
      success: function(result){
        console.log("addMemo결과값 : " + result);

        if(result != null){
          $('.input-memo').val(result);
        }
      },error: function(){
        console.log("ajax addMemo 에러");
      }
    })

 })