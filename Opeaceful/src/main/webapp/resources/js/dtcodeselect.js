/**
 * 작성자 윤지영
 * 부서명과 직급을 불러오는 ajax
 */

import {path} from './common/common.js';




/*부서명을 불러오는 ajax */
function teamRoad() {

    let dSelect = document.getElementById("d-select")

    $.ajax({
        url:`${path}/dept/selectDept`,
        dataType : "JSON",
        success: function(result){
  
            for(let dept of result){
                if (dept.topDeptCode !== 0) {
                const option = document.createElement("option");
                option.value = dept.deptCode;
                option.text = dept.deptName;
                dSelect.appendChild(option);
                }
            };
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    })
}


/*직급을 불러오는 ajax */
function positionRoad() {

    let pSelect = document.getElementById("p-select")

    $.ajax({
        url:`${path}/dept/selectPosition`,
        dataType : "JSON",
        success: function(result){
  
            for(let dept of result){
                const option = document.createElement("option");
                option.value = dept.pCode;
                option.text = dept.pName;
                pSelect.appendChild(option);
            };
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    })
}

teamRoad();
positionRoad();