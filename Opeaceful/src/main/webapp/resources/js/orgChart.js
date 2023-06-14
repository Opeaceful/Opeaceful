/**
 * 
 */

import {path} from './common/common.js';

// $(document).ready (function () {

//     let div = document.getElementById("tree");

//     $.ajax({
//         url:path+"/orgChart/selectDept",
//         type : "POST",
//         dataType : "JSON",
//         success: function(result){
  
//             let html = "";

//             for (let list of result) {
//                 html += `<div class="dp-name>${list.deptName}</div>`
//             };

//             div.innerHTML += html;

//         },
//         error : function(request){
//             console.log("에러발생");
//             console.log(request.status);
//         }
//     })
// });