/*
 * 작성자 윤지영
 * member 테이블 ajax
*/

import {path} from './common/common.js';

let cpage;


/*검색에 따라 member를 부여하는 불러오는 ajax */
$("#d-select,#p-select,#S-select").change( function(){memberSelctAjax()});
    
    
function memberSelctAjax(){

let memberTableBody = document.getElementById("member-table-body");
let Dselect= document.getElementById("d-select").value;
let Pselect = document.getElementById("p-select").value;
let Schecked = document.getElementById("S-select").checked;


//페이지네이션 
let memberPagination = document.getElementById("member-pagination");

let Sselect;

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

        console.log(result)
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
                <td>${m.hireDate}</td>
                <td></td>
                <td>${m.annualLeaveCount}</td>
                <td>${m.address}</td>
            </tr>
            `
        };
        memberTableBody.innerHTML = html;
        
        let phtml = ""

        console.log(result.pi.maxPage)

        phtml += `<li class="page-item">
        <a class="page-link" href="#">
          <span aria-hidden="true">&laquo;</span>
        </a>
      </li>`

        
        for (let i = 1; i <= Math.min(result.pi.pageLimit, result.pi.maxPage); i++) {
            phtml +=
           ` <li class="page-item"><a class="page-link" href='#' value='${i}'>${i}</a></li>`
        }
    //   <li class="page-item"><a class="page-link" href="member/selectAll">1</a></li>
    //   <li class="page-item"><a class="page-link" href="#">2</a></li>
    //   <li class="page-item"><a class="page-link" href="#">3</a></li>
    //   <li class="page-item">
    //<li class="page-item"><a class="page-link" href="#">1</a></li>

        phtml += `<li class="page-item">
                <a class="page-link" href="#">
                <span aria-hidden="true">&raquo;</span>
            </a>
            </li>`

         memberPagination.innerHTML = phtml;

         //페이지네이션에 이벤트 걸어주기
         pitem();   
    },
    error : function(request){
        console.log("에러발생");
        console.log(request.status);
    }
})

}




function pitem(){

    $(".page-item").on("click", function(e){
        e.preventDefault();
        console.log( (e.target).val());


    })
}

