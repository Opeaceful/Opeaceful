/*
 * 작성자 윤지영
 * member 테이블 ajax
*/

import {path} from './common/common.js';







/*검색에 다라 member를 부여하는 불러오는 ajax */
function memberload() {

    let memberTableBody = document.getElementById("member-table-body")

    $.ajax({
        url:`${path}/member/selectAll`,
        dataType : "JSON",
        method: 'post',
        data : {

        },
        success: function(data){

            console.log(data)
  
            // for(let dept of result){
            //     if (dept.topDeptCode !== 0) {
            //     const option = document.createElement("option");
            //     option.value = dept.deptCode;
            //     option.text = dept.deptName;
            //     memberTableBody.appendChild();
            //     }
            // };
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    })
}

memberload()

// rl: path + '/list.skin',
// method: 'post',
// data: {
//   page: num,
// },
// success: function (data) {
//   console.log(data);
//   let basicSkinCount = getSessionStorage('basicSkinCount');
//   let str = `<tr>
//               <th>#</th>
//               <th>대표사진</th>
//               <th>폴더명</th>
//               <th>가격(코인)</th>
//               <th>보상</th>
//             </tr>`;
//   for (let i in data) {
//     let src = data[i].saveRoot;

//     let folder = data[i].saveRoot.substring(src.lastIndexOf('/') + 1);
//     console.log(folder);
//     str += `<tr class="skin-info-box">
//               <td>${basicSkinCount - i - (num - 1) * 10}</td>
//               <td>
//                 <img src="${path + src}/fs.png" />
//                 <img src="${path + src}/fd.png" />
//                 <img src="${path + src}/bs.png" />
//                 <img src="${path + src}/bd.png" />
//                 <img src="${path + src}/ls.png" />
//                 <img src="${path + src}/ld.png" />
//                 <img src="${path + src}/rs.png" />
//                 <img src="${path + src}/rd.png" />
//               </td>
//               <td class="save-folder">${folder}</td>
//               <td>${data[i].price}</td>
//               <td>${data[i].reward}</td>
//             </tr>`;
//   }

//   document.querySelector('.skin-table').innerHTML = str;
// },
