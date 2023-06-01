/*
 * 작성자 윤지영
 * member 테이블 ajax
*/

import {path} from './common/common.js';

//함수에 사용할 변수 세팅
let pagination;

//퇴사자 체크 변수 세팅
let Sselect;



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
    }else{
        Sselect = 'Y'
    }


$.ajax({
    url:`${path}/member/selectAll`,
    dataType : "JSON",
    method: 'post',
    data: {
        Dselect : Dselect,
        Pselect : Pselect,
        Sselect : Sselect,
        cpage : cpage,
    },
    success: function(result){

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
                <td></td>
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
    if (selectBtn) {
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
    const tableTr = document.querySelectorAll("tbody>tr"); // tr태그 이벤트 추가

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
    
   let memberModalFrom = document.getElementById("member-update-form")

    $.ajax({
        url:`${path}/member/selectMemberOne`,
        dataType : "JSON",
        method: 'post',
        data: {
          id : id,
        },
        success: function(result){
            console.log(result);

            let html = ""
    
           
            html +=
            
            `
            <div class="row mb-3">
                <label for="inputUserName" class="col-sm-2 col-form-label">이름</label>
                <div class="col-sm-9">
                <input type="text" class="form-control" value="${result.m.userName}">
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputemail" class="col-sm-2 col-form-label">이메일</label>
                <div class="col-sm-9">
                <input type="email" class="form-control" value="${result.m.email}">
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputextension" class="col-sm-2 col-form-label">내선번호</label>
                <div class="col-sm-9">
                <input type="tel" class="form-control" value="${result.m.extension}">
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputphone" class="col-sm-2 col-form-label">연락처</label>
                <div class="col-sm-9">
                <input type="tel" class="form-control" value="${result.m.phone}">
                </div>
            </div>  
            <div class="row mb-3">
            <label for="inputdName" class="col-sm-2 col-form-label">부서</label>
                <div class="col-sm-9">
                    <select class="form-select member-form-select form-select-sm" >
                    <option selected>${result.m.dName}</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
            <label for="inputpName" class="col-sm-2 col-form-label">직급</label>
                <div class="col-sm-9">
                    <select class="form-select member-form-select  form-select-sm">
                    <option selected>${result.m.pName}</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputhireDate" class="col-sm-2 col-form-label">입사일</label>
                <div class="col-sm-3">
                    <input type="date" id="join-date" class="form-control" value="${result.m.ShireDate}">
                </div>
                <label for="inputresignedDate" id="leave-date-lable" class="col-sm-2 col-form-label">퇴사일</label>
                <div class="col-sm-3">
                    <input type="date" id="leave-date"class="form-control">
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputannualLeaveCount" class="col-sm-2 col-form-label">연차</label>
                <div class="col-sm-9">
                    <input type="number" class="form-control" value="${result.m.annualLeaveCount}">
                </div>
            </div>
            <div class="row mb-3">
                <label for="inputAddress" class="col-sm-2 col-form-label">주소</label>
                <div class="col-sm-9">
                    <input type="email" class="form-control" alue="${result.m.address}">
                </div>
            </div>
            `

        memberModalFrom.innerHTML = html;
        
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }

       
    })


}
    

