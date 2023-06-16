/**
 * [혜린]
 */

import {path} from '../common/common.js';
/* dataSet */
let category = document.getElementById('calendar-wrap').dataset.category;


  
    // ===== 일정추가 모달 내 카테고리 색 지정박스 =====
    //color box div
    let mycol = $(".my-event-col-box");
    let tmcol = $(".tm-event-col-box");

    /* 모달 내 카테고리 버튼에 따른 색 영역 변경 */
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

    /* 모달 일정수정버튼 비활성 함수 */
    function enableU(){
      let eveSubmitBtn = document.getElementById('modal-update-btn');
      
      for(let a in abled){
        if(!abled[a]){
          eveSubmitBtn.disabled = true;
          console.log(abled);
          return;
        }
      }
      eveSubmitBtn.disabled = false;
    }


    /* 일정 추가 버튼 클릭 시 모달 리셋 */
    $('#addEventBtn').on('click', function(){
      $('#dlt-event-btn').css('display','none');
      $('#modal-update-btn').css('display','none');
      $('#modal-submit-btn').css('display','block');
      $('#event-modal').modal('show');
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

    //update 버튼 클릭
    let updateBtn = $('#modal-update-btn');
    updateBtn.on('click', function(){
      //updateEvent함수 실행
      updateEvent();
      //모달 닫기
      hiddenModal();
    })

    // delete 버튼 클릭
    $('#dlt-event-btn').on('click', function(){
      deleteEvent();
      hiddenModal();
    })

  /* 모달 내 입력에 따른 버튼 비활성화 조건 */
  $('input[name=dateStart]').focusout(function(){
    if($('input[name=dateStart]').val() == ""){
      abled.start = false;
      console.log(abled);
    }else{
      abled.start = true;
      console.log(abled);
    }
    enable();
    enableU();
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
    enableU();
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
    enableU();
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
 $('.apv-hidden').css('display','block');
}

/* 일정추가 함수 */
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
    success: function(){
        location.reload();
    },error: function(){
      console.log("ajax insertEvent 에러");
    }
  })
}

/* 일정수정 함수 */
function updateEvent(){
  /* 모달 input 변수들 */
  let eventRadio = $('input:radio[name="event"]:checked').val();
  let startDate = $('input[name=dateStart]').val();
  let endDate = $('input[name=dateEnd]').val();
  let eveTitle = $('#event-title').val();
  let eveContent = $('.event-content').val();
  let eveColorM = $('input:radio[name="color"]:checked').val();
  let eveColorT = $('input:radio[name="t-color"]:checked').val();
  let eveDday = $('input:checkbox[name=event-d-day]:checked').val();

  let udtBtn = document.getElementById('modal-update-btn');
  console.log("update에 가져온 dataset수정버튼cno:",udtBtn.getAttribute('data-update'));

  let cno = udtBtn.getAttribute('data-update');

  $.ajax({
    type: 'POST',
    url: path+"/calendar/updateEvent",
    data: {category: eventRadio, title: eveTitle, content: eveContent, dDay: eveDday ? 'Y' : 'N'
          ,startDate: startDate, endDate: endDate, colorM: eveColorM, colorT: eveColorT, cno: cno},
    dataType: 'json',
    success: function(){
      location.reload();
    },error: function(){
      console.log("ajax updateEvent 에러");
    }
  })
}

/* 일정삭제 함수 */
function deleteEvent(){
  let udtBtn = document.getElementById('modal-update-btn');
  console.log("delete에 가져온 dataset수정버튼cno:",udtBtn.getAttribute('data-update'));
  let cno = udtBtn.getAttribute('data-update');

  $.ajax({
    type: 'POST',
    url: path+"/calendar/deleteEvent",
    data: {cno: cno},
    dataType: 'json',
    success: function(){
      location.reload();
    },error: function(){
      console.log("ajax deleteEvent 에러");
    }
  })
}

/* ============================== fullCalendar ======================================= */

 document.addEventListener('DOMContentLoaded', function() {

    var calendarM = document.getElementById('calendarM');
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
      editable: false,
      eventLimit: true, // allow "more" link when too many events
      events: data,

      eventClick: function(info){

        /* 선택된 일정 정보 표시 + 일정 수정 모달창 열림 */
        console.log("클릭됨");
        modalReset();
        $('#event-modal').modal('show');
        $('#dlt-event-btn').css('display','block');
        $('#modal-update-btn').css('display','block');
        $('#modal-submit-btn').css('display','none');
        enableU();
        abled.start = true;
        abled.end = true;
        abled.title = true;
        enableU();

        console.log("일정 고유번호 : "+info.event.id);

        let cno = info.event.id;

        let udtBtn = document.getElementById('modal-update-btn');
        udtBtn.dataset.update = cno;
        console.log("dataset수정버튼cno:",udtBtn.getAttribute('data-update'));

        let startDate = $('input[name=dateStart]');
        let endDate = $('input[name=dateEnd]');
        let eveTitle = $('#event-title');
        let eveContent = $('.event-content');
        let eveDday = $('input:checkbox[name=event-d-day]');

        $.ajax({
          type:"POST",
          url: path+"/calendar/selectEvent",
          data: {id : cno},
          dataType: "json",
          success: function(result){
            /* 조회된 일정의 정보 모달에 띄우기 */
            console.log(result);
            console.log("캘린더 일정 제목: ",result.title);
            console.log("색깔",result.backgroundColor);
            let col = result.backgroundColor;
            console.log("문자열 시작",col.indexOf("c")); //c시작위치
            console.log("문자열 끝 다음숫자",col.indexOf(")")); //) 마지막괄호 위치 -1
            console.log("잘라낸 문자열 : " , col.substring(col.indexOf("c") ,col.indexOf(")")));
            let cName = col.substring(col.indexOf("c") ,col.indexOf(")"));

            $("label[name='"+result.category+"']").click(); //카테고리 라디오버튼
            startDate.val(result.start);
            endDate.val(result.end);
            eveTitle.val(result.title);
            eveContent.val(result.content);
            $("label[for='"+cName+"']").click(); // 색지정 라디오버튼
            
            if(result.dDay == 'Y'){ // 디데이 표시면 checked
              eveDday.prop('checked',true); 
            }

          }
        })

      }

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
    editable: false,
    eventLimit: true, // allow "more" link when too many events
    events: data,
      eventClick: function(info){
        /* 선택된 일정 정보 표시 + 일정 수정 모달창 열림 */
        console.log("클릭됨");
        modalReset();
        $('#event-modal').modal('show');
        $('#dlt-event-btn').css('display','block');
        $('#modal-update-btn').css('display','block');
        $('#modal-submit-btn').css('display','none');
        enableU();
        abled.start = true;
        abled.end = true;
        abled.title = true;
        enableU();
        console.log("카테고리담긴값",info.event.category);
        
        console.log("일정 고유번호 : "+info.event.id);

        let cno = info.event.id;

        let udtBtn = document.getElementById('modal-update-btn');
        udtBtn.dataset.update = cno;
        console.log("dataset수정버튼cno:",udtBtn.getAttribute('data-update'));

        let startDate = $('input[name=dateStart]');
        let endDate = $('input[name=dateEnd]');
        let eveTitle = $('#event-title');
        let eveContent = $('.event-content');
        let eveDday = $('input:checkbox[name=event-d-day]');

        $.ajax({
          type:"POST",
          url: path+"/calendar/selectEvent",
          data: {id : cno},
          dataType: "json",
          success: function(result){
            console.log("result.category",result.category)
            
            /* 조회된 일정의 정보 모달에 띄우기 */
            console.log(result);
            console.log("캘린더 일정 제목: ",result.title);
            console.log("색깔",result.backgroundColor);
            let col = result.backgroundColor;
            console.log("문자열 시작",col.indexOf("c")); //c시작위치
            console.log("문자열 끝 다음숫자",col.indexOf(")")); //) 마지막괄호 위치 -1
            console.log("잘라낸 문자열 : " , col.substring(col.indexOf("c") ,col.indexOf(")")));
            let cName = col.substring(col.indexOf("c") ,col.indexOf(")"));

            $("label[name='"+result.category+"']").click(); //카테고리 라디오버튼
            startDate.val(result.start);
            endDate.val(result.end);
            eveTitle.val(result.title);
            eveContent.val(result.content);
            $("label[for='"+cName+"']").click(); // 색지정 라디오버튼
            
            if(result.dDay == 'Y'){ // 디데이 표시면 checked
              eveDday.prop('checked',true); 
            }
            /* 연차일정은 수정 못하게 */
            if(result.category == 'H'){

              $('#dlt-event-btn').css('display','none');
              $('#modal-update-btn').css('display','none');
            }
          }
        })
      }
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
    editable: false,
    eventLimit: true, // allow "more" link when too many events
    events: data,
      eventClick: function(info){
        /* 선택된 일정 정보 표시 + 일정 수정 모달창 열림 */
        console.log("클릭됨");
        modalReset();
        $('#event-modal').modal('show');
        $('#dlt-event-btn').css('display','block');
        $('#modal-update-btn').css('display','block');
        $('#modal-submit-btn').css('display','none');
        enableU();
        abled.start = true;
        abled.end = true;
        abled.title = true;
        enableU();

        console.log("일정 고유번호 : "+info.event.id);

        let cno = info.event.id;

        let udtBtn = document.getElementById('modal-update-btn');
        udtBtn.dataset.update = cno;
        console.log("dataset수정버튼cno:",udtBtn.getAttribute('data-update'));

        let startDate = $('input[name=dateStart]');
        let endDate = $('input[name=dateEnd]');
        let eveTitle = $('#event-title');
        let eveContent = $('.event-content');
        let eveDday = $('input:checkbox[name=event-d-day]');

        $.ajax({
          type:"POST",
          url: path+"/calendar/selectEvent",
          data: {id : cno},
          dataType: "json",
          success: function(result){
            /* 조회된 일정의 정보 모달에 띄우기 */
            console.log(result);
            console.log("캘린더 일정 제목: ",result.title);
            console.log("색깔",result.backgroundColor);
            let col = result.backgroundColor;
            console.log("문자열 시작",col.indexOf("c")); //c시작위치
            console.log("문자열 끝 다음숫자",col.indexOf(")")); //) 마지막괄호 위치 -1
            console.log("잘라낸 문자열 : " , col.substring(col.indexOf("c") ,col.indexOf(")")));
            let cName = col.substring(col.indexOf("c") ,col.indexOf(")"));

            $("label[name='"+result.category+"']").click(); //카테고리 라디오버튼
            startDate.val(result.start);
            endDate.val(result.end);
            eveTitle.val(result.title);
            eveContent.val(result.content);
            $("label[for='"+cName+"']").click(); // 색지정 라디오버튼
            
            if(result.dDay == 'Y'){ // 디데이 표시면 checked
              eveDday.prop('checked',true); 
            }
            /* 연차일정 모달 제한*/
            if(result.category == 'H'){


              /* 연차일정은 수정 못하게 */
              $('#dlt-event-btn').css('display','none');
              $('#modal-update-btn').css('display','none');

              /* 연차관련없는 요소 disabled */
              $('.apv-hidden').css('display','none');

            }
          }
        })
      }
  });
  calendar.render();
})

request.fail(function() {
  alert( "Request failed");
});
}

//=======================================

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
      editable: false,
      eventLimit: false, // allow "more" link when too many events
      events: data
    });
   
    calendarMin.render();
  })

request.fail(function() {
  alert( "Request failed");
});
}

function eventList(category){
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

eventList(category);
miniCalendar();


 })


 /* 캘린더 내부 메모 insert/update */
 $('.input-memo').focusout(function(){
    $.ajax({
      type: 'POST',
      url: path+"/calendar/addMemo",
      data: {memo: $('.input-memo').val()},
      success: function(result){
        console.log("addMemo결과값 : " + result);
        
      },error: function(){
        console.log("ajax addMemo 에러");
      }
    })

 })

