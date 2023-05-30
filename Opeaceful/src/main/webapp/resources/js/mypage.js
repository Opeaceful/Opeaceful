/**
 * [지의] - 마이페이지js
 */
/* 전화번호 이벤트 */
$('#mypage-phone,#mypage-call').keyup(function (event) {
	event = event || window.event;
	var _val = this.value.trim();
	this.value = autoHypenTel(_val);
});
 
/* 변경버튼 -> 사진첨부 */
document.getElementById("mypage-img-btn").addEventListener("click",()=> {
    document.getElementById("mypage-upfile").click();
});


$("")