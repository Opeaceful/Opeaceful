/*
 * 작성자 노지의
 * uesr 연자 조회 JS
 */

import {path} from './common/common.js';
import {checkMemberNo} from './common/memberSelect.js';

/* 유저 연차 조회 */
$("#all-member-modal-button").click(function(){
    if(checkMemberNo.length > 1){
        swal("한명만 선택해주세요");
    }else{
        if(`${checkMemberNo[0]}` != "undefined"){
            // 새로고침시 데이터 유지되어야함
            let post = document.createElement('form');
            post.setAttribute('method', 'post');
            post.setAttribute('action', `${path}/annual/list/${checkMemberNo[0]}`);
            document.body.appendChild(post);
            post.submit();
        }
        //location.href = `${path}/annual/list/${checkMemberNo[0]}`;

        // $.ajax({
        //     url : `${path}/annual/selectUserAnnaul`,
        //     data : {
        //         userNo : `${checkMemberNo[0]}`
        //     },
        //     method: 'post',
        //     dataType : 'json',
        //     success : function(m){
        //         console.log(m);
        //         $("#annual-user-name").html(m.userName);
        //         // $("#annual-dept").html(m.userName);
        //         $("#annual-team").html(m.dName);
        //         $("#annual-hire-text").html("입사일");
        //         $("#annual-hire-date").html(m.hireDate);
        //         $("#annual-count").val(m.annualLeaveCount);
        //     },
        //     error : function(e){
        //         console.log(e.target);
        //     }
        // });

    }

});

// 연차 총개수 원래 값 조회
let originAnnual = $("#annual-count").val();

// 수정 버튼 활성화
$("#annual-count").on("keyup", function(){
    // 연차 총개수 변경 값 조회
    let changeAnnual = $(this).val();
    //console.log("전 : "+ originAnnual + "   후 : "+ changeAnnual);
    
    // 전후값 비교해서 수정버튼 활성화/비활성화 처리
    if(originAnnual == changeAnnual) {
        $("#annual-user-btn").attr("disabled", true);
        return;
    }else{
        $("#annual-user-btn").attr("disabled", false);
    }
});
$("#annual-user-btn").click(function(){
    let no = document.getElementById('no');
    let changeAnnual = $("#annual-count").val();
    console.log(no.dataset.userno);
    console.log(changeAnnual);
    $.ajax({
        url : `${path}/annual/updateUserAnnual`,
        data : {
            userNo : no.dataset.userno,
            changeAnnual
        },
            method: 'post',
            dataType : 'json',
        success : function(result){
            if(result > 0){
                location.reload();
            }
        },
        error : function(e){
            console.log(e.target);
        }
    })
 });