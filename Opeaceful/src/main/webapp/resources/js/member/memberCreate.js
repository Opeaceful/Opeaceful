/*
    작성자 : 윤지영
    memeberCreate.jsp의 js 
*/

//전화번호 패턴 체크해주는 함수
$('#user-call,#user-pnohe').keyup(function (event) {
    event = event || window.event;
    var _val = this.value.trim();
    this.value = autoHypenTel(_val);
});

//input 날짜에 현재날짜 입력해주는 함수
$(document).ready(function() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    const todayDate = year + '-' + month + '-' + day;
    $('#join-date').val(todayDate);

});



