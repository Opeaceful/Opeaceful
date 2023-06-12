/**
 * 작성자 윤지영
 * 부서명과 직급을 불러오는 ajax
 */

import {path} from '../common/common.js';

//사용할때 
//부서가 들어갈 select박스에 name=deptCode  
//직급이 들어갈 select박스에 name=pCode
//설정해주면 알아서들어감! 



/*부서명을 불러오는 ajax */
function teamRoad() {

    let deptCode = document.querySelectorAll("[name=deptCode]");
    let topDeptCode = document.querySelectorAll("[name=topDeptCode]");


    $.ajax({
        url:`${path}/dept/selectDept`,
        dataType : "JSON",
        success: function(result){

            console.log('부서불러오는 세ㄹ렉트:',result);
  
            for(let i=0; i<deptCode.length; i++){

                for(let dept of result){
                    if (dept.topDeptCode !== 0) { // 하위 부서 셀렉트
                    const option = document.createElement("option");
                    option.value = dept.deptCode;
                    option.text = dept.deptName;
                    deptCode[i].appendChild(option);
                    }
                    if (dept.topDeptCode == 0) { //상위 부서 셀렉트
                        const option = document.createElement("option");
                        option.value = dept.deptCode;
                        option.text = dept.deptName;
                        topDeptCode[i].appendChild(option);
                        }
                };

            }

           
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    })
}


/*직급을 불러오는 ajax */
function positionRoad() {

    let pCode = document.querySelectorAll("[name=pCode]")

    $.ajax({
        url:`${path}/dept/selectPosition`,
        dataType : "JSON",
        success: function(result){
  
            for(let i=0; i<pCode.length; i++){
                for(let dept of result){
                    const option = document.createElement("option");
                    option.value = dept.pCode;
                    option.text = dept.pName;
                    pCode[i].appendChild(option);
                };
            }
            
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    })
}

teamRoad();
positionRoad();

export {teamRoad, positionRoad};