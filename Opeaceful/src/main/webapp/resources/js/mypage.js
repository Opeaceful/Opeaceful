/**
 * [지의] - 마이페이지js
 */
import {path} from './common/common.js';
/* 전화번호 이벤트 */
// toast 메세지 띄우는 메서드
let toast = function (text) {
	$("#toast").text(text);
	if ($(".toastShow").length > 0) return; // 토스트 메세지 show 중이면 다시 뜨지 않도록 처리
	$("#toast").addClass("toastShow"); // show라는 클래스를 추가해서 토스트 메시지를 띄우는 애니메이션을 발동시킴
	setTimeout(function () {
		// 2700ms 후에 show 클래스를 제거함
		$("#toast").removeClass("toastShow");
	}, 2500);
};
$('#mypage-phone,#mypage-call').keyup(function (event) {
	event = event || window.event;
	var _val = this.value.trim();
	this.value = autoHypenTel(_val);
});
 
/* 변경버튼 -> 사진첨부 */
document.getElementById("mypage-img-btn").addEventListener("click",()=> {
    document.getElementById("mypage-upfile").click();
});


function updatePwdF(originPwd, updatePwd){
	$.ajax({
		url : path+"/member/updatePwd",
		data : {
			originPwd : originPwd,
			updatePwd : updatePwd
		},
		type : 'POST',
		dataType : "json",
		success : function(result){
			console.log(result);
		},
		error : function(request){
			console.log("에러");
			console.log(request.status);
		}

	});
}

$(()=>{
	$("#mypage-update-btn").click(()=>{
	
		let originPwd = $("#origin-pwd").val();
		let updatePwd = $("#update-pwd").val();
		let updatePwdCk = $("#update-pwd-ck").val();

		let eng = /[a-z]/ig;
        let num = /[0-9]/g;
	
		if(originPwd.length <= 0 || updatePwd.length <=0 || updatePwdCk.length <= 0){
			toast("공백없이 입력해주세요.");
			return;
		}
		if(updatePwd != updatePwdCk){
			toast("새 비밀번호가 일치하지 않습니다.");
			$("#update-pwd").val("");
			$("#update-pwd-ck").val("");
			
			$("#update-pwd").focus();
			return;
		}

		if(updatePwd == updatePwdCk && eng.test(updatePwd) && num.test(updatePwd) && updatePwd.length >= 8 && updatePwd.length <= 16){
			updatePwdF(originPwd, updatePwd);
		}else{
			toast("영문 대소문자/숫자 2가지 조합, 8자~16자로 입력해주세요");
			$("#update-pwd").val("");
			$("#update-pwd-ck").val("");
			$("#update-pwd").focus();
			return;
		}
	});
})

