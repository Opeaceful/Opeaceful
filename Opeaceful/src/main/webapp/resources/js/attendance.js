/**
 * 
 */

import {path} from './common/common.js';
import {checkMemberNo} from './common/memberSelect.js';

setDateBox1();
setDateBox2();

let selectButton = false;

function redirectToAttendanceCheck() {

  let year1 = $("#year1").val(); 
  let year2 = $("#year2").val(); 

  let month1 = $("#month1").val();
  let month2 = $("#month2").val();

  let day1 = $("#day1").val();
  let day2 = $("#day2").val();

  let startDate = new Date(`${year1}-${month1}-${day1}`);
  let endDate = new Date(`${year2}-${month2}-${day2}`);


  let diff = Math.abs(startDate.getTime() - endDate.getTime());
  diff = Math.ceil(diff / (1000 * 60 * 60 * 24));

  if (diff < 365) {
          location.href = `${path}/attendance/check?userNo=${userNo}&year1=${year1}&month1=${month1}&day1=${day1}&year2=${year2}&month2=${month2}&day2=${day2}`;
  } else {
   swal('최대 일년까지 조회 가능합니다.',{buttons: {cancel :'확인'}});
  }

}

$("#year1, #year2, #month1, #month2, #day1, #day2").change(function() {
  let selectBtn = document.getElementById('ad-btn');
  selectBtn.addEventListener('click', redirectToAttendanceCheck);
});

let selectBtn = document.getElementById('ad-btn');
selectBtn.addEventListener('click', redirectToAttendanceCheck);

$("#all-member-modal-button").click(function(){

  let year1 = $("#year1").val(); 
  let year2 = $("#year2").val(); 

  let month1 = $("#month1").val();
  let month2 = $("#month2").val();

  let day1 = $("#day1").val();
  let day2 = $("#day2").val();

  let startDate = new Date(`${year1}-${month1}-${day1}`);
  let endDate = new Date(`${year2}-${month2}-${day2}`);


  let diff = Math.abs(startDate.getTime() - endDate.getTime());
  diff = Math.ceil(diff / (1000 * 60 * 60 * 24));

  if (diff < 365) {
    if(!selectButton){
  
        if(checkMemberNo.length > 0){
          location.href = `${path}/attendance/allCheck?no=${checkMemberNo}&year1=${year1}&month1=${month1}&day1=${day1}&year2=${year2}&month2=${month2}&day2=${day2}`;
        }
        // let total =  document.querySelector(".total");
        // console.log(total);
        // $(".total").css("display", "none");

      } 
  } else {
   swal('최대 일년까지 조회 가능합니다.',{buttons: {cancel :'확인'}});
  }
});
      
// select box 연도 , 월 표시
function setDateBox1() {
  let dt = new Date();
  let year = dt.getFullYear();
  let month = dt.getMonth()+1;
  let day = dt.getDate();
      
  // 발행 뿌려주기
  $("#year1").append("<option value=''>년도</option>");
        
  // 올해 기준으로 -50년부터 +1년을 보여준다.
  for (let y = (year); y >=(year-15); y--) {
    if(year == y) {
      $("#year1").append("<option selected value='"+ y +"'>"+ y + "년" +"</option>");
    }else{
    $("#year1").append("<option value='"+ y +"'>"+ y + "년" +"</option>");
    }
  }
      
  // 월 뿌려주기(1월부터 12월)
  $("#month1").append("<option value=''>월</option>");

  for (let i = 1; i <= 12; i++) {
    if(month == i) {
      $("#month1").append("<option selected value='"+ i +"'>"+ i + "월" +"</option>");
    }else{
      $("#month1").append("<option value='"+ i +"'>"+ i + "월" +"</option>");
    }
  }
      
  // 일 뿌려주기(1일부터 31일)
  $("#day1").append("<option value=''>일</option>");

  for (let i = 1; i <= 31; i++) {
    if(day == i) {
      $("#day1").append("<option selected value='"+ i +"'>"+ i + "일" +"</option>");
    }else{
      $("#day1").append("<option value='"+ i +"'>"+ i + "일" +"</option>");
    }
    }

  let urlParams = new URLSearchParams(window.location.search);
  let urlYear1 = urlParams.get('year1');
  let urlMonth1 = urlParams.get('month1');
  let urlDay1 = urlParams.get('day1');

  if(urlYear1){
    $("#year1").val(urlYear1)
  }
  if(urlMonth1){
    $("#month1").val(urlMonth1)
  }
  if(urlDay1){
    $("#day1").val(urlDay1)
  }
}

function setDateBox2() {
  let dt = new Date();
  let year = dt.getFullYear();
  let month = dt.getMonth()+1;
  let day = dt.getDate();
        
  // 발행 뿌려주기
  $("#year2").append("<option value=''>년도</option>");
        
  // 올해 기준으로 -50년부터 +1년을 보여준다.
  for (let y = (year); y >=(year-15); y--) {
    if(year == y) {
      $("#year2").append("<option selected value='"+ y +"'>"+ y + "년" +"</option>");
    }else{
      $("#year2").append("<option value='"+ y +"'>"+ y + "년" +"</option>");
    }
  }
        
  // 월 뿌려주기(1월부터 12월)
  $("#month2").append("<option value=''>월</option>");
  for (let i = 1; i <= 12; i++) {
    if(month == i) {
      $("#month2").append("<option selected value='"+ i +"'>"+ i + "월" +"</option>");
    }else{
      $("#month2").append("<option value='"+ i +"'>"+ i + "월" +"</option>");
    }
  }
        
  // 일 뿌려주기(1일부터 31일)
  $("#day2").append("<option value=''>일</option>");
  for (let i = 1; i <= 31; i++) {
    if(day == i) {
      $("#day2").append("<option selected value='"+ i +"'>"+ i + "일" +"</option>");
    }else{
      $("#day2").append("<option value='"+ i +"'>"+ i + "일" +"</option>");
    }
    }

  let urlParams = new URLSearchParams(window.location.search);
  let urlYear2 = urlParams.get('year2');
  let urlMonth2 = urlParams.get('month2');
  let urlDay2 = urlParams.get('day2');

  if(urlYear2){
    $("#year2").val(urlYear2)
  }
  if(urlMonth2){
    $("#month2").val(urlMonth2)
  }
  if(urlDay2){
    $("#day2").val(urlDay2)
  }
}

$(".attendance-table tr").click(function() {

  let str = "";
  let tdArr = new Array();

  // 현재 클릭된 tr
  let tr = $(this);
  let td = tr.children();

  td.each(function(i){
    tdArr.push(td.eq(i).text());
  });

  let userNo = td.eq(1).data('no');

})

        // function lastday(){ //년과 월에 따라 마지막 일 구하기 
        //   var year = $("#year option:selected").val();
        //   var month = $("#month option:selected").val();
        //   var lastDate = getLastDay(year, month);

        //   $("#day > option").remove(); // remove all items from list
        //   for(i=1; i<=lastDate; i++){
        //       $("#day").append("<option value='"+ i +"'>"+ i +"</option>");
        //   }
        // }