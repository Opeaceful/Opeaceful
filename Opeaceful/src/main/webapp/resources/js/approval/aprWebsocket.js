// (승은) 전자결재 알림용
import { path } from '../common/common.js';

const aprSock = new SockJS(path + '/approval/webSocket');
const aprAlam = document.getElementById('div-apr-info-wrap');
const aprAlamText = document.getElementById('div-apr-info-text');

export default function sendAprMessage(status, userNo) {
  let msg = { status: Number(status), userNo: Number(userNo) };
  aprSock.send(JSON.stringify(msg));
}

// 웹소켓 핸들러에서 sendMesage라는 함수가 호출되었을 때를 캐치하는 이벤트 핸들러
aprSock.onmessage = function (e) {
  aprAlam.style.display = 'none';
  const message = JSON.parse(e.data); // json -> js Object

  let status = message.status;
  let html = '';
  switch (status) {
    case -1:
      html = `<div>요청하신 결재가 <b>반려</b>되었습니다.</div>`;
      break;
    case 1:
      html = `<div>요청하신 결재가 <b>완료</b>되었습니다.</div>`;
      break;
    case 0:
      html = `<div>승인 대기중인 <b>결재</b>요청건이 있습니다.</div>`;
      break;
  }

 
  aprAlamText.innerHTML = html;


  setTimeout(() => {
    aprAlam.style.display = 'flex';
  }, 100);
  
  sessionStorage.setItem('aprAlam', JSON.stringify(html));
};

document.getElementById('btn-apr-info-close').addEventListener('click', () => {
  aprAlam.style.display = 'none';
  sessionStorage.removeItem('aprAlam');
});

aprAlamText.addEventListener("click", ()=>{
  aprAlam.style.display = 'none';
  location.href = path + '/approval/myApproval';
  sessionStorage.removeItem('aprAlam');

})


function checkAlam(){
  const html = JSON.parse(sessionStorage.getItem('aprAlam'));
  if(html && html.length > 0){
    aprAlamText.innerHTML = html;
    aprAlam.style.display = 'flex';
  }
}

checkAlam();