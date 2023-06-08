/**
 *  공통 사용되는 date ajax
 *  작성자 윤지영
 */


//년도 월 select박스세팅
$(document).ready(function(){
    setDateBox();
});


function setDateBox(){
    let dt = new Date();
    let year = dt.getFullYear();
    let month = dt.getMonth()+1;

    for(var y = (year); y >=(year-5); y--){
      if(year == y) {
        $("#salary-year").append("<option selected value='"+ y +"'>"+ y + "년" +"</option>");
      }else{
        $("#salary-year").append("<option value='"+ y +"'>"+ y + "년" +"</option>");
      }
    }
    for(var i = 1; i <= 12; i++){
      if(month == i) {
        $("#salary-month").append("<option selected value='"+ i +"'>"+ i + "월" +"</option>");
      }else{
        $("#salary-month").append("<option value='"+ i +"'>"+ i + "월" +"</option>");
      }
    }

    const urlParams = new URLSearchParams(window.location.search);
    const urlMonth = urlParams.get('month');
    const urlYear = urlParams.get('year');

    if(urlMonth){
        $("#salary-month").val(urlMonth)
    }

    if(urlYear){
        $("#salary-year").val(urlYear)
    }

}