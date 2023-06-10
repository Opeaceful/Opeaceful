/**
 * 
 */
 import {path} from '../common/common.js';
 
   $(document).ready(function() {
    // 다이얼로그 초기화
    $("#dialog").dialog({
      autoOpen: false,
      modal: false,
      focus: false,
      resizable: true,
      title: "Opeaceful",     
      width: 500, // 다이얼로그의 너비 설정
      height: 800, // 다이얼로그의 높이 설정
    });
    
    $('.ui-dialog-titlebar-close').remove();
    
    $(document).on("click", "#dialog_close", function() {
    $("#dialog").dialog("close");
    });
  

    // 다이얼로그 열기
    $("#openDialogButton").click(function() {
          // 로컬 스토리지에 다이얼로그 상태를 저장
          localStorage.setItem('dialogVisible', 'true');
            if ($("#dialog").dialog("isOpen")) {
      // 다이얼로그가 이미 열려있는 경우
      $("#dialog").dialog("close");
    } else {
      // 다이얼로그가 닫혀있는 경우
      $("#dialog").dialog("open");
    }
    });

    // 로컬 스토리지에서 다이얼로그 상태를 가져옴
    const dialogVisible = localStorage.getItem('dialogVisible');

    if (dialogVisible === 'true') {
      // 다이얼로그 상태가 true로 저장되어 있으면 다이얼로그를 열기
      $("#dialog").dialog("open");
    }

    // 다이얼로그 닫기 시 로컬 스토리지에서 상태를 제거
    $("#dialog").on("dialogclose", function(event, ui) {
      localStorage.removeItem('dialogVisible');
    });
    
    
    
 /*   $(document).on('click', '#chatRoom_dialog', function () {
    const chatRoomUrl = path + '/chatRoom';

    // chatRoom.jsp 페이지를 다이얼로그 내에서 열기
    $("#dialog").load(chatRoomUrl, function () {
      // chatRoom.jsp 페이지 로딩 완료 후 실행될 코드 작성
      // 예: chatRoom.jsp 내의 요소에 이벤트 리스너 등록 등
    });
  });  */
  
  
  /* $(document).on('click', '#chat_dialog', function () {
    const chatUrl = path + '/chat';
  // chat.jsp 페이지를 다이얼로그 내에서 열기
  $("#dialog").load(chatUrl, function () {  
    adminAll();
    });   
  }); */
    
     
 });
 

 function adminAll() {
    $.ajax({
        url: path +"/chat",
        dataType: "json",
        success: function(response) {
            const adminList = document.getElementById("adminList");
            adminList.innerHTML = ""; // 기존 내용 초기화
            
            const loginUser = response.loginUser;
            const list = response.memberList;
            const onlineStatus = response.onlineStatus;
            const notice = response.notice;                               
            
            const parentElement = document.getElementById("boardNotice");
            parentElement.innerHTML = "";
				
			const p4 = document.createElement("p");
			p4.textContent = "사내 공지";
			parentElement.appendChild(p4);
			

			for (let board of notice) {
			  if (board.boardNo == 6) {
			    const p5 = document.createElement("p");
			    const a1 = document.createElement("a");
			    a1.href = path+"/board/list/N" // 여기에 이동할 링크를 입력하고, boardNo를 쿼리 파라미터로 추가합니다
			    a1.textContent = board.boardTitle;
			    p5.appendChild(a1);
			    parentElement.appendChild(p5);
			  }			  	
			}
			
			         
            // list를 순회하면서 <li> 요소를 생성하여 멤버 정보 추가
            for (let item of list) {
            
                const li = document.createElement("li");
                li.classList.add("chat_main_li");
                const img = document.createElement("img");
                if(item.profileImg){
                img.src = item.profileImg; // 프로필 이미지 속성에 따라 변경
                }else{
                img.src = path+ "/resources/image/chat/default.png"
                }
                img.alt = item.userName;
          
                const div = document.createElement("div");
                div.classList.add("chat_profile");
                const p1 = document.createElement("p");
                p1.innerText = item.userName;
                
                const p2 = document.createElement("p");
			    const p3 = document.createElement("p");
			    p3.classList.add("profile_box");
                const matchingStatus = onlineStatus.find(status => status.statusType === item.statusType);
			    if (matchingStatus) {
			        p2.innerText = matchingStatus.statusName;		        
					p3.innerHTML = `<img src="${path}/resources/image/status/${matchingStatus.statusImg}" alt="Status Image" class="profile_status_img">`;
	//				console.log(matchingStatus.statusImg);					
			    } else {
			       console.log("에러코드")
			    }
			    img.classList.add("profile_img");
                
                div.appendChild(p1);
                div.appendChild(p2);
                
                li.appendChild(img);
                li.appendChild(div);
                li.appendChild(p3);
                
                adminList.appendChild(li);
            }
        },
        error: function(request) {
            console.log("에러발생");
            console.log("에러코드, " + request.status);
        }
    });
}


/* 접속 상태 제어 */
function changeStatus(status) {
    $.ajax({
        url: path+"/member/updateStatusType",
        type: 'POST',
        data: {statusType: status},
        success: function(response) {           
            console.log('상태값이 성공적으로 업데이트되었습니다.');
        },
        error: function(request) {
            console.error('상태값 업데이트 중 오류가 발생했습니다.');
        }
    });
}

const statusList = document.getElementById('statusList');

statusList.addEventListener('change', function() {
    changeStatus(this.value);
});



/* 채팅방 목록 */
$.ajax({
  url: path+"/chat/chatRoom",
  method: "GET",
  dataType: "json",
  success: function(response) {

    const loginUser = response.loginUser;
    const chatRoomList = response.crList;
    
    console.log(chatRoomList);
    
   var chatRoomHtml = '';
    var hasChatRoom = false;
   
      chatRoomList.forEach(function(chatRoom) {
        if (chatRoom.eno === loginUser.eno) {
        hasChatRoom = true;
          chatRoomHtml += '<li class="chat_room_li"><a href="#">';
          
          if (chatRoom.profileImg) {
            chatRoomHtml += '<img src="' + chatRoom.profileImg + '" class="profile-img">';
          } else {
            chatRoomHtml += '<img src="' + path + '/resources/image/chat/default.png" class="profile-img" alt="나의프로필사진">';
          }
          
          chatRoomHtml += '<div class="chat_talk">';
          chatRoomHtml += '<p class="chat_admin_name">' + chatRoom.roomTitle + '</p>';
          chatRoomHtml += '<p class="chat_msg">' + chatRoom.userName + '</p>';
          chatRoomHtml += '</div>';
          
          chatRoomHtml += '<div class="chat_room_status">';
          chatRoomHtml += '<time class="chat_time" datetime="15:40:00+09:00">' + chatRoom.createdChat + '</time>';
          chatRoomHtml += '<span class="chat_balloon">' + chatRoom.eno + '</span>';
          chatRoomHtml += '</div>';
          
          chatRoomHtml += '</a></li>';
        }
      });     
     if (!hasChatRoom) {
      chatRoomHtml = '<li class="chat_room_li">';
      chatRoomHtml += '<div>존재하는 채팅방이 없습니다.</div>';
      chatRoomHtml += '</li>';
    } else {
    }
    
    $("ul.chat__room_ul").append(chatRoomHtml);
  }
});



/* 채팅방 생성 다이얼로그 */
 $(document).ready(function() {
  // 다이얼로그(Dialog) 생성하기

  // 버튼 클릭 시 새로운 다이얼로그 열기
  $("#open-dialog-button").on("click", function() {
    // 동적으로 id 생성
    var dialogId = "new-dialog" + Date.now();

    // 새로운 다이얼로그 요소 생성
    var newDialog = $("<div>").attr("id", dialogId).attr("title", "채팅방 만들기");
    newDialog.append(
    	      '<div>' +
    	      '<h5>채팅방 만들기</h5>' +
    	      '</div>' +
    	      '<form action="' + path + '/chat/openChatRoom" method="post">' +
    	      '<div>' +
    	      '<label for="title">제목</label>' +
    	      '<input type="text" placeholder="채팅방 제목" id="roomTitle" name="roomTitle">' +
    	      '</div>' +
    	      '<div>' +
    	      '<button type="submit" id="open-form" class="btn btn-primary">만들기</button>' +
    	      '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>' +
    	      '</div>' +
    	      '</form>'
    	    );

    // 다이얼로그(Dialog)를 body 요소에 추가
    newDialog.appendTo("body");

    // 다이얼로그(Dialog) 초기화 및 움직일 수 있도록 설정
    newDialog.dialog({
      close: function() {
        // 다이얼로그 닫힐 때 요소 제거
        newDialog.dialog("destroy").remove();
      }
    });

    // 다이얼로그(Dialog)를 드래그 가능하도록 설정
    newDialog.dialog("option", "draggable", true);
  });
});




 /* nav 메뉴 이동 */
   function toggleChatRoom() {

    var chatRoomContent = document.getElementById("chat_room_content");
    var chatContent = document.getElementById("chat_content");
    
    chatRoomContent.style.display = "grid";
    chatContent.style.display = "none";     
  }
  
  function toggleChat() {

	 var chatRoomContent = document.getElementById("chat_room_content");
	 var chatContent = document.getElementById("chat_content");    
	    
	 chatContent.style.display = "grid";
	 chatRoomContent.style.display = "none";	    
  }
 







adminAll(); // 페이지 로딩 시 멤버 정보 가져오기
//window.setInterval(adminAll, 10000); // 주기적으로 멤버 정보 갱신