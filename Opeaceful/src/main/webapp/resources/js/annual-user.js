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
    }

});
// 사원검색 input클릭시 모달 오픈
$(".annual-content #member-search-keyword").click(function () {
    $("#all-user-view").modal("show");
});

$(".annual-content").on("click", ".search-input2","search-btn2", function(){
    // [지의] 체크박스 하나만 클릭되도록 설정
    function onlyOneCheck(groupName){
        var chk = $('[data-group="'+groupName+'"]').find('input[type="checkbox"]');
        chk.click(function(){
            if($(this).is(':checked')){
              chk.not(this).prop('checked',false); // .not() : 선택한 요소 제외한 나머지 요소
            }
        })
    }
    onlyOneCheck("checkFail");
})



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
                swal($("#annual-user-name").html()+" 사원의 연차가 수정되었습니다.").then(function(){
                    location.reload();
                })
            }
        },
        error : function(e){
            console.log(e.target);
        }
    })
 });