/**
 * [혜린]
 */

import {path} from '../common/common.js';
/* dataSet */
let category = document.getElementById('calendar-wrap').dataset.category;
//let cno = document.getElementById('modal-submit-btn').dataset.submit;
  //=======================================  
/* 모달 input 변수들 */
let eventRadio = $('input:radio[name="event"]:checked').val();
let startDate = $('input[name=dateStart]').val();
let endDate = $('input[name=dateEnd]').val();
let eveTitle = $('#event-title').val();
let eveContent = $('.event-content').val();
let eveColorM = $('input:radio[name="color"]:checked').val();
let eveColorT = $('input:radio[name="t-color"]:checked').val();






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

if(category == 'M'){
  myCalendar();
}
if(category == 'T'){
  teamCalendar();
}
if(category == 'F'){
  fullCalendar();
}

miniCalendar();



// if($('.input-memo').focus()){
//     console.log(" 포커스 눌림");
//     $('.memo-wrap').css('background-color', 'rgba(197, 194, 194, 0.342)');
// }


 })
