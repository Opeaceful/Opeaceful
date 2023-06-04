/*
 * 작성자 윤지영
 * member 테이블 ajax
*/

import {path} from './common/common.js';
import {checkMemberNo} from './common/memberSelect.js';

//함수에 사용할 변수 세팅
let pagination;

//퇴사자 체크 변수 세팅
let Sselect;

//퇴사일 이벤트 변수 세팅
let LeaveDate = document.getElementById("leave-date");

//DB상 퇴사일 세팅
let LeaveDateDay;

//검색용 변수 세팅
let JsoncheckMemberNo = "";

/*검색에 따라 member를 불러오는 이벤트 */
$("#d-select,#p-select,#S-select").change( function(){memberSelectAjax()});
    
//페이지 비동기로 불러오는 이벤트 내용+페이징처리   
function memberSelectAjax(){
//변수세팅
let memberTableBody = document.getElementById("member-table-body");
let Dselect= document.getElementById("d-select").value;
let Pselect = document.getElementById("p-select").value;
let Schecked = document.getElementById("S-select").checked;




//페이지네이션 
let memberPagination = document.getElementById("member-pagination");
//페이지네이션 변수 셋팅
const cpage = pagination !== undefined ? pagination.currentPage : null;

    //퇴사자 여부 체크
    if(Schecked){
        Sselect = 'N'
        inputReadonly();

    }else{
        Sselect = 'Y'
        inputChangeable();
    }

$.ajax({
    url:`${path}/member/selectAll`,
    dataType : "JSON",
    method: 'POST',
    data: {
        Dselect : Dselect,
        Pselect : Pselect,
        Sselect : Sselect,
        cpage : cpage,
        checkMemberNo : JsoncheckMemberNo,
    },
    success: function(result){

        console.log(result);

        let html = ""
    
        //받아온 데이터 테이블 생성시켜줌
        for(let m of result.m){
    
            html +=
            `
            <tr data-id=${m.userNo}>
                <th scope="row">${m.eno}</th>
                <td>${m.userName}</td>
                <td>${m.email}</td>
                <td>${m.extension}</td>
                <td>${m.phone}</td>
                <td>${m.dName}</td>
                <td>${m.pName}</td>
                <td>${m.ShireDate}</td>
                <td>${m.ResignedDate !== undefined ? m.ResignedDate:""}</td>
                <td>${m.annualLeaveCount}</td>
                <td>${m.address}</td>
            </tr>
            `
        };
        memberTableBody.innerHTML = html;
        
        //pagination에 결과값 넣어주기
        pagination = result.pi;

        //페이지 html
        let phtml = ""
    
        phtml += `<li class="page-item">
                    <button id="pre" class="PN-link">
                    <span aria-hidden="true">&laquo;</span>
                    </button>
                    </li>`
    
        //해당 페이지 번호  : 시작~ 끝까지 pi값을 통해 구현
        for (let i = pagination.startPage; i <= Math.min(pagination.endPage, pagination.maxPage); i++) {
            phtml +=
           ` <li class="page-item"><button class="page-link" data-page="${i}">${i}</button></li>`
        }

        phtml += `<li class="page-item" class="PN-link">
                <button id="next">
                <span aria-hidden="true">&raquo;</span>
            </button>
            </li>`

         memberPagination.innerHTML = phtml;

         //페이지네이션에 이벤트 걸어주기
         pitem();
         preNextbutton(); 
         tableEvent();

         //선택값 비워주기
         JsoncheckMemberNo = null;
           
    },
    error : function(request){
        console.log("에러발생");
        console.log(request.status);
    }
})

}



//페이징 클릭이벤트 
function pitem(){

    //숫자 페이징 이벤트
    $("button.page-link").on("click", function(e){
        pagination.currentPage =  e.target.dataset.page;
     
    //해당 페이지 재호출
    memberSelectAjax();    
    });

    const selectBtn = document.querySelector(`.page-link[data-page='${pagination.currentPage}']`);

    if(selectBtn){
        selectBtn.focus();
    }
    


}

//좌우 이벤트
function preNextbutton(){
    //pre버튼에 이전으로 가는 이벤트 부여
    const preButton = document.getElementById("pre");
    preButton.addEventListener("click", function(){
        pagination.currentPage = pagination.startPage - 1
        memberSelectAjax(); 
    })

    //첫페이지에서는 비활성화
    if(pagination.currentPage <= pagination.pageLimit){
        preButton.disabled = true;
    }

    //next버튼에 다음페이지로 가는 이벤트 부여
    const NextButton = document.getElementById("next");
    NextButton.addEventListener("click", function(){
        pagination.currentPage =  pagination.endPage + 1
        memberSelectAjax();  
    })

    //마지막 페이지에서는 비활성화 
    if(pagination.endPage == pagination.maxPage){
        NextButton.disabled = true;
    }

}

function tableEvent(){


    //table 버튼 이벤트 추가
    const tableTr = document.querySelectorAll("#member-table-body>tr"); // tr태그 이벤트 추가

    // 각 페이지 버튼에 클릭 이벤트 리스너 추가
    tableTr.forEach(tr => {
        tr.addEventListener("click", function() {
            memberUpdaetajax(tr.dataset.id);
            $('#memberUpdateModal').modal('show');
        });
    });

}

//모달창 비동기 처리
function memberUpdaetajax(id){
    
    $.ajax({
        url:`${path}/member/selectMemberOne`,
        dataType : "JSON",
        method: 'post',
        data: {
          id : id,
        },
        success: function(result){
            console.log(result);

           //모달에 데이터 세팅
           document.querySelector("input[name=userName]").value  = result.m.userName;
           document.querySelector("input[name=email]").value  = result.m.email;
           document.querySelector("input[name=extension]").value  = result.m.extension;
           document.querySelector("input[name=phone]").value  = result.m.phone;
           document.getElementById("join-date").value = result.m.ShireDate;
           document.querySelector("input[name=annualLeaveCount]").value  = result.m.annualLeaveCount;
           LeaveDate.value = "";
           
           //주소지 세팅
           let addressList = result.m.address.split( ",");

           document.getElementById("user-address").value = addressList[0];
           document.getElementById("user-address-dtail").value = addressList[1];

           //두개 이상으로 나뉘었다면
           for(let i = 2; i < addressList.length; i++){
                document.getElementById("user-address-dtail").value += ","+addressList[i];
           }

           //selecte 선택
           let deptCodeSelect = document.getElementById("deptCodeSelect");
           selectedDept(result.m.deptCode, deptCodeSelect);
           selectedP(result.m.pCode);
           
           //hidden값 넣어주기
           hiddenFrom('userNo',id);
           hiddenFrom('pName',result.m.pName);
           hiddenFrom('dName',result.m.dName);
           hiddenFrom('eno',result.m.eno);

           if(result.rm != null){
                LeaveDate.value = result.rm.resignedDate;
                LeaveDateDay = result.rm.resignedDate;
           }

   
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }

       
    })


}
    
//DB에 따라 부서를 선택해주는 함수
function selectedDept(num, deptCodeSelect){

     for (let i = 0; i < deptCodeSelect.options.length; i++) {
       if(deptCodeSelect.options[i].value == num){
          deptCodeSelect.options[i].selected = true
       }
 
      }


}

//DB에 따라 직급을 선택해주는 함수
function selectedP(num){

     //select 선택 직급
     let pCodeSelect = document.getElementById("pCodeSelect");
     for (let i = 0; i < pCodeSelect.options.length; i++) {
         if(pCodeSelect.options[i].value == num){
             pCodeSelect.options[i].selected = true
         }

     }

}

//back에 필요한 데이터 셋팅
function hiddenFrom(date,id){
    let hiddenFrom = document.createElement('input');
    hiddenFrom.type = 'hidden';
    hiddenFrom.name = date;
    hiddenFrom.value = id;

    let form = document.getElementById('member-update-form');
    form.appendChild(hiddenFrom);
}

   
//보내기전 한번 확인
$("#form-sumit").click(function(){
    swal("정말 변경하시겠습니까?","",{
        buttons: {confirm: "확인", cancel: "취소"}
    })
    .then(function(isConfirm){
        if(isConfirm){

            //비활성화 되어있다면 select박스 활성화로 보내줘야 함
            let selects = document.querySelectorAll('#member-update-form select');
            selects.forEach(function(selects) {
                selects.removeAttribute('disabled');
            });

            document.getElementById('member-update-form').submit();
        }
    })
});

//퇴사일 변경 확인
LeaveDate.addEventListener('change', function() { 

    //내가 선택한 날짜
    let inputLeaveDate = this.value;
    

    console.log(inputLeaveDate);

    if(inputLeaveDate){ //없던 퇴사일을 넣어준다면
       
        swal(inputLeaveDate+" 퇴사일 설정","퇴사일 설정시 해당 직원은 변경할 수 없습니다.",{
            buttons: {confirm: "확인", cancel: "취소"}
        })
        .then(function(isConfirm){
            if (isConfirm){ // 확인선택시 퇴사자로 변경 : input박스 수정불가!
                LeaveDateDay = inputLeaveDate;
                inputReadonly();
              
            } else { //취소시 데이터 지워주고
                LeaveDate.value = "";

                if(LeaveDateDay){ //퇴사일이 있는 상태에서 날짜만 변경
                    LeaveDate.value = LeaveDateDay
                }
            }
        })
        
      } else { //있던 퇴사일을 삭제시킨다면 

        swal(LeaveDateDay+" 퇴사일 삭제","해당 직원은 재직자로 변경하시겠습니까?",{
            buttons: {confirm: "확인", cancel: "취소"}
        })
        .then(function(isConfirm){
            if (isConfirm){ 
                inputChangeable(); 
            } else { //취소시 데이터 다시 넣어주기
                inputReadonly();
                LeaveDate.value = LeaveDateDay; 
            }
        })
      }
   


  });


//수정하지 않고 종료했을 경우 realyonly 삭제!!
document.getElementById('member-btn-close').addEventListener('click', inputChangeable )

//수정할 수 있게 만들어주기 
function inputChangeable(){
    let inputs = document.querySelectorAll('#member-update-form input');

    inputs.forEach(function(input) {
        input.removeAttribute('readonly')
    });

    let selects = document.querySelectorAll('#member-update-form select');
    selects.forEach(function(selects) {
        selects.removeAttribute('disabled');
    });

}




//읽기전용으로 만들어주기 
function inputReadonly(){
    //주소지가 바뀌는건 어떻게하징... 고민 
    let inputs = document.querySelectorAll('#member-update-form input');

    inputs.forEach(function(input) {
        input.setAttribute('readonly', 'readonly');
    });

    // 퇴사일만 수정가능
    LeaveDate.removeAttribute('readonly');

    let selects = document.querySelectorAll('#member-update-form select');
    selects.forEach(function(selects) {
        selects.setAttribute('disabled', 'disabled');
    });

}

//보내기전 한번 확인
$("#password-reset-button").click(function(){
    swal("비밀번호를 초기화 하시겠습니까?","초기화 비번: 1234",{
        buttons: {confirm: "확인", cancel: "취소"}
    })
    .then(function(isConfirm){
        if(isConfirm){
            let eno = document.querySelector('input[name="eno"]').value;
            $.ajax({
                url:`${path}/member/passwordReset`,
                dataType : "JSON",
                method: 'post',
                data: {
                  eno : eno,
                },
                dataType : "json",
                success : function(result) {
                    swal("비밀번호가 초기화되었습니다.");
                   
                },
                error : function(e) {
                    swal("작업수행에 실패하였습니다.");
                }
            })
        }
    })
});


//확인 버튼 눌렀을때 allview에서 처리할 이벤트
$("#all-member-modal-button").click(function(){
    JsoncheckMemberNo = JSON.stringify(checkMemberNo);
    memberSelectAjax(); // ajax호출

});

