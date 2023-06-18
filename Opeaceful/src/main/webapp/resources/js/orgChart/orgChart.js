/**
 * 
 */

import {path} from '../common/common.js';

/* 사원 클릭 시 사원 정보 담긴 명함 띄우기 */
$(".orgChartView-table button").click(function(e) {

    if(e.target.dataset.isCheck == 'true'){
        return;
    }

    let userNo = $(e.target).data('no');

    let html = "";

    /* 사원 정보 조회하는 ajax */
    $.ajax({
        url: path+"/orgChart/businessCard",
        data : {userNo : userNo},
        type : "POST",
        dataType : "JSON",
        success: function(result){

            let member = result[0];
           
            html = `<div class="user-profileImg">
                        <img src="${path}/resources/file/mypage/${member.profileImg ? member.profileImg : "basic_profile.png"}">
                    </div>
                    <div>
                        <div class="user-name" id="user-card">
                            <div>이름</div>
                            <div class="user-name-right" id="right">${member.userName} ${member.pName}</div>
                        </div>
                        <div class="user-department" id="user-card">
                            <div>조직</div>
                            <div class="user-department-right" id="right">${member.topDeptName} ${member.dName}</div>
                        </div>
                        <div class="user-email" id="user-card">
                            <div>이메일</div>
                            <div class="user-email-right" id="right">${member.email}</div>
                        </div>
                        <div class="user-phone" id="user-card">
                            <div>연락처</div>
                            <div class="user-phone-right" id="right">${member.phone}</div>
                        </div>
                        <div class="user-extension" id="user-card">
                            <div>내선번호</div>
                            <divid="right">${member.extension}</divid=>
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
