/*
    작성자 : 윤지영
    memeberCreate.jsp의 js 
*/


$('#user-call,#user-pnohe').keyup(function (event) {
    event = event || window.event;
    var _val = this.value.trim();
    this.value = autoHypenTel(_val);
});




