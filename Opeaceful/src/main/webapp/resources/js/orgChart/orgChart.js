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
           
            html = `
                            <div class="user-profileImg">
                                <img src="${path}/resources/file/mypage/${member.profileImg ? member.profileImg : "basic_profile.png"}">
                            </div>
                            <div>이름</div>
                            <div>${member.userName} ${member.pName}</div>
                            <div>조직</div>
                            <div></div>
                            <div>이메일</div>
                            <div></div>
                            <div>연락처</div>
                            <div></div>
                            <div>내선번호</div>
                            <div></div>
                            <table class="table card-table">
                                <tr>
                                    <td scope="row">이름</td>
                                    <td>${member.userName} ${member.pName}</td>
                                </tr>
                                <tr>
                                    <td scope="row">조직</td>
                                    <td>${member.topDeptName} ${member.deptName}</td>
                                </tr>
                                <tr>
                                    <td scope="row">이메일</td>
                                    <td>${member.email}</td>
                                </tr>
                                <tr>
                                    <td scope="row">연락처</td>
                                    <td>${member.phone}</td>
                                </tr>
                                <tr>
                                    <td scope="row">내선번호</td>
                                    <td>${member.extension}</td>
                                </tr>
                            </table>
                            
                        </div>
                    `;
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
