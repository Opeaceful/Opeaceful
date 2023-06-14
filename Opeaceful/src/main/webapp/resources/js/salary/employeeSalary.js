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

            document.querySelector("#salaryModalTitle").innerHTML = s.yearReported+"-"+s.monReported+"월 급여명세서";
            document.getElementById("payDay").innerHTML =  `<b>지급일 : </b> ${s.sPaymentDate}`

            let payment = s.payments.split(',');
            let deduction = s.deduction.split(',');
            let phtml = ""
            let dhtml = ""

            if(payment.length > 1){

                for(let i = 0; i < payment.length;  i += 2){
                    phtml += 
                    `
                    <tr>
                        <td>${payment[i]}</td>
                        <td name="pay">${payment[i+1]}</td>
                    </tr>
                    `
               }
        
            }

            if(deduction.length > 1){

                for(let i = 0; i < deduction.length;  i += 2){
                    dhtml += 
                    `
                    <tr>
                        <td>${deduction[i]}</td>
                        <td name="pay">${deduction[i+1]}</td>
                    </tr>
                    `
                }
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


/*검색에 따라 데이터를 불러오는*/
$("#salary-year,#salary-month").change(function(){
    let year = $("#salary-year").val(); 
    let month = $("#salary-month").val();

    location.href=`${path}/salary/employee?year=${year}&month=${month}`;

});

//인쇄 
$("#print-button").click(function() {

    const sw = screen.width;
    const sh = screen.height;
    const w = 800;//팝업창 가로길이
    const h = 600;//세로길이
    let xpos=(sw-w)/2; //화면에 띄울 위치
    let ypos=(sh-h)/2; //중앙에 띄웁니다.

    const pHeader=`
    <html>
        <head>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
            <link rel="stylesheet" href="${path}/resources/css/common/common.css">
            <link rel="stylesheet" href="${path}/resources/css/salary/employeeSalary.css">
            <title></title>
        </head>
    <body>`
    const pgetContent = document.getElementById("salary-modal-body").innerHTML + "<br>";
    //이사이에 안넣고 싶은 div가 있다면 class print-none 추가해주면 됌

    const pFooter="</body></html>";
    let pContent= pHeader + pgetContent + pFooter;	
    
    let pWin = window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes");
    pWin.document.open(); //팝업창 오픈
    pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
    pWin.document.close(); //클로즈

    setTimeout(function() {
        pWin.print(); // 윈도우 인쇄 창
        pWin.close(); // 닫기
      }, 300);
   
});


//금액으로 만들어주기
function payReplace(){
    const pList = document.querySelectorAll('td[name="pay"]');
    pList.forEach(function(td) {
        td.textContent = td.textContent.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    });
}
    

//다운로그
$("#download-button").click(function() {

    location.href=`${path}/pdf/salary`;

    // const pHeader=`
    // <html>
    //     <head>
    //         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    //         <link rel="stylesheet" href="${path}/resources/css/common/common.css">
    //         <link rel="stylesheet" href="${path}/resources/css/salary/employeeSalary.css">
    //         <title></title>
    //     </head>
    // <body>`
    // const pgetContent = document.getElementById("salary-modal-body").innerHTML + "<br>";
    // //이사이에 안넣고 싶은 div가 있다면 class print-none 추가해주면 됌

    // const pFooter="</body></html>";
    // let pContent= pHeader + pgetContent + pFooter;	

    // $.ajax({
    //     url: `${path}/pdf/salary`, 
    //     method: "POST",
    //     data: {
    //         htmlContent : pContent,
    //       },
    //     success: function(response) {
    //         console.log(response);
    //     },
    //     error: function(error) {
    //       console.error(error);
    //     }
    //   });
    
});

