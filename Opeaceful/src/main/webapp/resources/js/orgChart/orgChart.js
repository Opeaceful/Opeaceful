/**
 * 
 */

import {path} from '../common/common.js';

// // 팝오버 이벤트로 팝오버이 표시 된 후의 이벤트이다.
// $('.orgChartView-table button').on('shown.bs.popover', function () {

//     // 세번째로 실행되는 이벤트
//     console.log("팝업 뜬 후");  

// });

//       // 팝오버 이벤트로 팝오버이 표시 되기 전의 이벤트이다.
//       $(`[data-bs-toggle="popover"]`).on('show.bs.popover', function (e) {
//         // 첫번째로 실행되는 이벤트
//         console.log("팝업 뜨기 전");


//       });

$(".orgChartView-table button").click(function(e) {

    if(e.target.dataset.isCheck == 'true'){
        return;
    }

    let userNo = $(e.target).data('no');

    let html = "";

    $.ajax({
        url: path+"/orgChart/businessCard",
        data : {userNo : userNo},
        type : "POST",
        dataType : "JSON",
        success: function(result){
            console.log(result);

            let profile = result.profileImg;
           
            html = `<div class="container">
                        <div class="card-container shadow p-3 mb-5 bg-body rounded">
                            <div class="user-profileImg">
                                `<img src="${path}/resources/file/mypage/${member.profileImg}">`
                            </div>
                            <table class="table card-table">
                                <tr>
                                    <td scope="row">이름</td>
                                    <td>박가영 사원</td>
                                </tr>
                                <tr>
                                    <td scope="row">조직</td>
                                    <td>경영지원본부 인사팀</td>
                                </tr>
                                <tr>
                                    <td scope="row">이메일</td>
                                    <td>opeaceful@gamil.com</td>
                                </tr>
                                <tr>
                                    <td scope="row">연락처</td>
                                    <td>010-1234-5678</td>
                                </tr>
                                <tr>
                                    <td scope="row">내선번호</td>
                                    <td>02-123-456</td>
                                </tr>
                            </table>
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
