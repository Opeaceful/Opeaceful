/*
    작성자: 윤지영
    로그인 유저의 급여를 보여주는 페이지 js 
*/

import {path} from '../common/common.js';

employleeSalaryTable();

//조회된 급여의 상세내역을 띄워주는 클릭이벤트
function employleeSalaryTable() {
    //만들어진 tr태그에 이벤트 부여
    const salaryTableTr = document.querySelectorAll('#em-salary-table tr[data-id]');
    console.log(salaryTableTr);
    salaryTableTr.forEach(function(tr){
        tr.addEventListener('click', function(e){
            const dataId = this.getAttribute('data-id');
            employleeSalaryData(dataId);
        })
    })
}



//모달에 데이터 셋팅
function employleeSalaryData(id){
    
    $.ajax({
        url:`${path}/salary/salaryOne`,
        dataType : "JSON",
        method: 'post',
        data: {
          id : id,
        },
        success: function(s){
            //모달 데이터 적용
            document.getElementById("payDay").innerHTML =  `<b>지급일 : </b> 2023-05-01`

            let payment = s.payments.split(',');
            let deduction = s.deduction.split(',');
            let phtml = ""
            let dhtml = ""

            for(let i = 0; i < payment.length;  i += 2){
                phtml += 
                `
                <tr>
                    <td>${payment[i]}</td>
                    <td name="pay">${payment[i+1]}</td>
                </tr>
                `
           }
       
           for(let i = 0; i < deduction.length;  i += 2){
            dhtml += 
            `
            <tr>
                <td>${deduction[i]}</td>
                <td name="pay">${deduction[i+1]}</td>
            </tr>
            `
            }

            if(payment.length > deduction.length){
               let count = (payment.length - deduction.length)/2;
               for(let i = 0; i < count;  i++){
                dhtml += 
                    `<tr>
                        <td class="t-height" colspan="2"></td>
                    </tr>`
                }
            }else{
                let count = (deduction.length - payment.length)/2;
                for(let i = 0; i < count;  i++){
                    phtml += 
                    `<tr>
                        <td class="t-height" colspan="2"></td>
                    </tr>`
                }

            }

            phtml += `<tr>
                        <td>지급액 계</td>
                        <td>${s.totalGrosspay}</td>
                      </tr>`
            dhtml += `<tr>
                        <td>지급액 계</td>
                        <td>${s.totalDeductions}</td>
                      </tr>` 



            document.getElementById("tbody-salary-payment").innerHTML = phtml;
            document.getElementById("tbody-salary-deduction").innerHTML = dhtml;
        
      

           document.getElementById("footer-salary-payment").innerHTML = 
            `
               <div class="row t-margin ">
                 <div class="col-md-12 t-flex"><b>실지급액 : </b>${s.netPay}</div>
               </div> 
            
            `

            payReplace();
   
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }

       
    })


    $('#salary-modal').modal('show');

}

//년도 월 select박스세팅
$(document).ready(function(){
    setDateBox1();
});

function setDateBox1(){
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


/*검색에 따라 데이터를 불러오는*/
$("#salary-year,#salary-month").change(function(){
    let year = $("#salary-year").val(); 
    let month = $("#salary-month").val();

    location.href=`${path}/salary/employee?year=${year}&month=${month}`;

});

//인쇄 
$("#print-button").click(function() {
    window.print(); 
});


//금액으로 만들어주기
function payReplace(){
    const pList = document.querySelectorAll('td[name="pay"]');
    pList.forEach(function(td) {
        td.textContent = td.textContent.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    });
}
    
