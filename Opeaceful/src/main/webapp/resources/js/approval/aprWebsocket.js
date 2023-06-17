let aprSock = new SockJS(path + '/approval/webSocket');

//chattingSock.send(JSON.stringify(chatMessage));

// 웹소켓 핸들러에서 sendMesage라는 함수가 호출되었을 때를 캐치하는 이벤트 핸들러
aprSock.onmessage = function (e) {
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

  

};

function formatStatusToMessage(status) {}
