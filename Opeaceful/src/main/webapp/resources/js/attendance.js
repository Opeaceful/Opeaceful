/**
 * 
 */

import {path} from './common/common.js';

setDateBox1();
setDateBox2();

// 조회 버튼 클릭 시 근태 조회
// let selectBtn = document.getElementById('ad-btn');
// console.log(selectBtn);
// selectBtn.addEventListener('click', function(e){
//     location.href = `${path}/attendance/${userNo}`;
// }) 

/* 날짜 선택에 따라 근태 조회*/
$("#year1, #year2, #month1, #month2, #day1, #day2").change(function(){
  let year1 = $("#year1").val(); 
  let year2 = $("#year2").val(); 
  let month1 = $("#month1").val();
  let month2 = $("#month2").val();
  let day1 = $("#day1").val();
  let day2 = $("#day2").val();

  let selectBtn = document.getElementById('ad-btn');
  console.log(selectBtn);
  selectBtn.addEventListener('click', function(e){
    location.href=`${path}/attendance/check?cpage=1&userNo=${userNo}&year1=${year1}&month1=${month1}&day1=${day1}&year2=${year2}&month2=${month2}&day2=${day2}`;
  }) 


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
}

        // function lastday(){ //년과 월에 따라 마지막 일 구하기 
        //   var year = $("#year option:selected").val();
        //   var month = $("#month option:selected").val();
        //   var lastDate = getLastDay(year, month);

        //   $("#day > option").remove(); // remove all items from list
        //   for(i=1; i<=lastDate; i++){
        //       $("#day").append("<option value='"+ i +"'>"+ i +"</option>");
        //   }
        // }