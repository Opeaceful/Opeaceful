/**
 * 
 */

$(document).ready(function () {
          setDateBox1();
          // lastday();
          setDateBox2();
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