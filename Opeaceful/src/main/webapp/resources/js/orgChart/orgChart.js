/**
 * 
 */

import {path} from '../common/common.js';

$(".orgChartView-table button").click(function(e) {

    if(e.target.dataset.isCheck == 'true'){
        return;
    }

    let userNo = $(e.target).data('no');
    console.log(userNo);

    let html = "";

    $.ajax({
        url: path+"/orgChart/businessCard",
        data : {userNo : userNo},
        type : "POST",
        dataType : "JSON",
        success: function(result){
            console.log(result);
            let member = result[0];
           
            html = `<div class="user-profileImg">
                        <img src="${path}/resources/file/mypage/${member.profileImg ? member.profileImg : "basic_profile.png"}">
                    </div>
                    <div>
                        <div>
                            <div>이름</div>
                            <div>${member.userName} ${member.pName}</div>
                        </div>
                        <div>
                            <div>조직</div>
                            <div>${member.topDeptName} ${member.deptName}</div>
                        </div>
                        <div>
                            <div>이메일</div>
                            <div>${member.email}</div>
                        </div>
                        <div>
                            <div>연락처</div>
                            <div>${member.phone}</div>
                        </div>
                        <div>
                            <div>내선번호</div>
                            <div>${member.extension}</div>
                        </div>
                    </div>`;
            $(e.target).popover({
                html :true,
                content :  html
            })

            e.target.dataset.isCheck = true;
            $(e.target).popover("toggle");
        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    });
})
