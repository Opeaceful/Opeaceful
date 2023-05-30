/*
 * 작성자 윤지영
 * member 테이블 ajax
*/

import {path} from './common/common.js';







/*검색에 다라 member를 부여하는 불러오는 ajax */


$("#d-select").change(function() {

let memberTableBody = document.getElementById("member-table-body");
const Dselect= document.getElementById("d-select").value;
const Pselect = document.getElementById("p-select").value;

console.log(Dselect);
console.log(Pselect);


if(!Dselect){
    console.log("null맞음")
}

$.ajax({
    url:`${path}/member/selectAll`,
    dataType : "JSON",
    method: 'post',
    data: {
        Dselect : Dselect,
        Pselect : Pselect,
    },
    success: function(result){

        console.log(result)
        let html = ""
    
        for(let m of result){
            console.log(m.address)
            html +=
            `
            <tr data-id=${m.userNo}>
                <th scope="row">${m.eno}</th>
                <td>${m.userName}</td>
                <td>${m.email}</td>
                <td>${m.extension}</td>
                <td>${m.phone}</td>
                <td>${m.userPwd}</td>
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
        
    },
    error : function(request){
        console.log("에러발생");
        console.log(request.status);
    }
})

})
