/**
 * 
 */
import {path} from '../common/common.js';

// 메인 다이얼로그 생성 
$(document).ready(function() { 
	$("#dialog").dialog({
		autoOpen: false,
		modal: false,
		focus: false,
		resizable: true,
		title: "Opeaceful",   
		width: 500,
		height: 800		
	});

	// 다이얼로그 타이틀바 삭제    
	$('.ui-dialog-titlebar-close').remove();
	
	// 다이얼로그 닫기 버튼    
	$(document).on("click", "#dialog_close, #dialog_chatting_close", function() {
	
		$("#dialog").dialog("close");
		
		localStorage.removeItem('dialogVisible');		
	});
	
	// 다이얼로그 열기
	$("#openDialogButton").click(function() {
		dialogElementStyle("dialog",'83px','125px','100');
		// 로컬 스토리지에 다이얼로그 상태를 저장
		localStorage.setItem('dialogVisible', 'true');
	
		//다이얼로그가 이미 열려있는 경우
		if ($("#dialog").dialog("isOpen")) {
	
			$("#dialog").dialog("close");
			
			localStorage.removeItem('dialogVisible');
			
	    } else {
	    
	      	// 다이얼로그가 닫혀있는 경우
	    	$("#dialog").dialog("open");
	    	dialogElementStyle("dialog",'83px','125px','100');
	    }    
	});
	
	// 페이지 이동 후 다이얼로그 상태가 true로 저장되어 있으면 다이얼로그를 열기
	const dialogVisible = localStorage.getItem('dialogVisible');
		
	if (dialogVisible === 'true') {
		      
		$("#dialog").dialog("open");
		dialogElementStyle("dialog",'83px','125px','100');	
	}         
});
 

function adminAll() {
    $.ajax({
        url: path + "/chat",
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
                    a1.href = path + "/board/list/N"
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
                if (item.profileImg) {
                    img.src = item.profileImg; // 프로필 이미지 속성에 따라 변경
                } else {
                    img.src = path + "/resources/image/chat/default.png"
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

                } else {
                    console.log("에러코드")
                }
                img.classList.add("profile_img");

                div.appendChild(p1);
                div.appendChild(p2);

                li.appendChild(img);
                li.appendChild(div);
                li.appendChild(p3);
                
                li.addEventListener("click", function() {
                    openMemberDialog(item); // 클릭한 멤버의 정보를 인자로 전달하여 다이얼로그 생성
                });

                adminList.appendChild(li);             
            }
        },
        error: function(request) {
            console.log("에러발생");
            console.log("에러코드, " + request.status);
        }
    });
}

/* 채팅메인에서 사원 명함 */
function openMemberDialog(member) {
console.log(member);
    // 다이얼로그 내용을 구성
    var memberDialogContent = `
        <div id="content-wrap">      
            <div class="container">
                <div class="card-container shadow p-3 mb-5 bg-body rounded">
                    <div class="adminUserPicture">
                    ${member.profileImg ? `<img src="${member.profileImg}">` : `<img src="${path}/resources/image/chat/default.png" alt="나의프로필사진">`}
                    </div>
                    <table class="adminInfoTable">
                        <tr class="adminInfo">
                            <td scope="row">이름</td>
                            <td>${member.userName}</td>
                        </tr>
                        <tr class="adminInfo">
                            <td scope="row">조직</td>
                            <td>${member.dName} ${member.pName}</td>
                        </tr>
                        <tr class="adminInfo">
                            <td scope="row">이메일</td>
                            <td>${member.email}</td>
                        </tr>
                        <tr class="adminInfo">
                            <td scope="row">연락처</td>
                            <td>${member.phone}</td>
                        </tr>
                        <tr class="adminInfo">
                            <td scope="row">입사일</td>
                            <td>${member.hireDate}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    `;

    // 다이얼로그(Dialog) 생성하기
    var memberDialog = $("<div>").attr("id", "memberDialog").attr("title", "멤버 정보").html(memberDialogContent);

    // 다이얼로그(Dialog)를 body 요소에 추가
    memberDialog.appendTo("body");

    // 다이얼로그(Dialog) 초기화 및 움직일 수 있도록 설정
    memberDialog.dialog({
        close: function() {
            // 다이얼로그 닫힐 때 요소 제거
            memberDialog.dialog("destroy").remove();
        },
        modal: true,
        height: 200,
        width: 480
    });
    dialogElementStyle("memberDialog",'83px','125px','120');	
} 












/* 접속 상태 제어 */
function changeStatus(status) {
    $.ajax({
        url: path + "/member/updateStatusType",
        type: 'POST',
        data: {
            statusType: status
        },
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
	if(document.getElementById("state")){
		$(`#state .option-list .option#${this.value}`).click();
        $('#state .select').removeClass("active");
	}else{
    	changeStatus(this.value);
	}
});

let chattingSock = {};
//var roomId;
/* 채팅방 목록 조회 */
function chatAll() {
    $.ajax({
        url: path + "/chat/chatRoom",
        method: "GET",
        dataType: "json",
        success: function(response) {

            const loginUser = response.loginUser;
            const chatRoomList = response.crList;

            //  console.log(chatRoomList);

            var chatRoomHtml = '';
            var hasChatRoom = false;

            chatRoomList.forEach(function(chatRoom) {
                if (chatRoom.eno === loginUser.eno) {
                    hasChatRoom = true;
                    chatRoomHtml += '<li class="chat_room_li"><a href="#" data-chat-room-id="' + chatRoom.chatRoomNo + '">';

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
            }

            $("ul.chat__room_ul").html(chatRoomHtml);


            /* 채팅방 클릭 이벤트 및 변수 넘겨주기 */
            $("ul.chat__room_ul a").on("click", function(e) {
                e.preventDefault();

                const roomId = $(this).data("chat-room-id");
                var clickedChatRoom = chatRoomList.find(function(chatRoom) {
                    return chatRoom.chatRoomNo === roomId;
                });

                
                if (!chattingSock[roomId]) {
                    console.log("채팅로그1 : "+roomId);	
                // roomId를 사용하여 다이얼로그 열기               
                
                openDialog(roomId, clickedChatRoom);
					 		
				// chattingSock[roomId] = new SockJS(path + "/chat/room/" + roomId);
				//  console.log("채팅로그2 : "+roomId);	
				 
                // // 웹소켓 핸들러에서 sendMesage라는 함수가 호출되었을 때를 캐치하는 이벤트 핸들러
                // chattingSock[roomId].onmessage = function(e) {
                //     // 매개변수 e : 발생한 이벤트에 대한 정보를 담고 있는객체
                //     // e.data : 전달된 메세지가 담겨있음(json객체) ==> message.getPayload()
				// 	console.log("채팅로그3 : "+roomId);	
                //     // 전달받은 메세지를 js객체로 변환

                //     const chatMessage = JSON.parse(e.data); // json -> js Object
                //     //	console.log(chatMessage);

                //     var message = chatMessage.message;
                //     var receivedDate = chatMessage.receivedDate;
                //     var isCurrentUser = chatMessage.userNo === loginUser.userNo;

                //     var chatContainer = document.getElementById("main_chatting_" + roomId);
                //     console.log(chatContainer);
	
					
                //     if (!isCurrentUser) {
                //         var friendChat = document.createElement("div");
                //         friendChat.classList.add("friend_chatting");

                //         var profileImg = document.createElement("img");
                //         profileImg.classList.add("chatting_profile_img");
                //         profileImg.src = chatMessage.profileImg ? chatMessage.profileImg : path + "/resources/image/chat/default.png";
                //         profileImg.alt = "프로필사진";

                //         var friendChatCol = document.createElement("div");
                //         friendChatCol.classList.add("friend_chatting_col");

                //         var profileName = document.createElement("span");
                //         profileName.classList.add("chatting_profile_name");
                //         profileName.textContent = chatMessage.userName;

                //         var chattingBalloon = document.createElement("span");
                //         chattingBalloon.classList.add("chatting_balloon");
                //         chattingBalloon.textContent = message;

                //         var chattingTime = document.createElement("time");
                //         chattingTime.classList.add("chatting_time");
                //         chattingTime.datetime = receivedDate;
                //         chattingTime.textContent = receivedDate;

                //         friendChatCol.appendChild(profileName);
                //         friendChatCol.appendChild(chattingBalloon);

                //         friendChat.appendChild(profileImg);
                //         friendChat.appendChild(friendChatCol);
                //         friendChat.appendChild(chattingTime);

                //         chatContainer.appendChild(friendChat);
                //     } else {
                //         var meChat = document.createElement("div");
                //         meChat.classList.add("me_chatting");

                //         var meChatCol = document.createElement("div");
                //         meChatCol.classList.add("me_chatting_col");

                //         var chattingBalloon = document.createElement("span");
                //         chattingBalloon.classList.add("chatting_balloon");
                //         chattingBalloon.textContent = message;

                //         var chattingTime = document.createElement("time");
                //         chattingTime.classList.add("chatting_time");
                //         chattingTime.datetime = receivedDate;
                //         chattingTime.textContent = receivedDate;

                //         meChatCol.appendChild(chattingBalloon);

                //         meChat.appendChild(meChatCol);
                //         meChat.appendChild(chattingTime);

                //         chatContainer.appendChild(meChat);
                //     }
                    

                //     chatContainer.scrollTop = chatContainer.scrollHeight;

                // };
                }
                
                  /* 메세지 전달 */
               $(document).on("click", "#chatting_send_" + roomId, sendMessage.bind(roomId));
                
                             

            });
            
            
            function sendMessage(roomId) {
                    const inputChatting = document.getElementById("chatting_textarea_" + this);

                    if (inputChatting.value.trim().length == 0) {
                        alert("입력이 되지 않았습니다");

                        inputChatting.value = "";
                        inputChatting.focus();

                    } else {

                        const chatMessage = {
                            "userNo": loginUser.userNo,
                            "chatRoomNo": this,
                            "userName": loginUser.userName,
                            "message": inputChatting.value
                        };
                    //    console.log("버튼이 눌렸다");
                    //    console.log(loginUser);
                    //   console.log(chatRoomList);
                       console.log(this);
                        chattingSock[this].send(JSON.stringify(chatMessage));
                        inputChatting.value = "";
                    }
                }
            
            
            
            // roomId를 사용하여 채팅방 데이터를 서버로부터 가져오는 Ajax 요청

            function openDialog(roomId, chatRoom) {
                $.ajax({
                    url: path + "/chat/room/" + roomId,
                    method: "GET",
                    data: {
                        chatRoomNo: roomId
                    },
                    dataType: "json",
                    success: function(response) {


                        const join = response.join;
                        const list = response.list;


                     //   console.log(chatRoom)
                     //  console.log(response);
                     //   console.log(join);
                     //   console.log(list);

                        // 가져온 채팅방 데이터를 기반으로 다이얼로그 내용을 구성
                        var dialogContent = '<div id="chatting_body">' +
                            '<div class="chatting_setting_bar">' +
                            '<i class="fa-regular fa-window-restore" alt="최대화버튼" title="최대화"></i>' +
                            '<i class="fa-solid fa-xmark" alt="닫기버튼" title="닫기"></i>' +
                            '</div>' +
                            '<div class="chatting_main_menu">' +
                            '<i class="icon-bell" title="알림"></i>' +
                            '<i class="icon-ellipsis" title="메뉴"></i>' +
                            '</div>' +
                            '<header id="chatting_header">' +
                            '<img class="chatting_profile_img" src="'+ path + '/resources/image/chat/default.png" alt="프로필사진">' +
                            '<div class="chatting_profile_col">' +
                            '<span class="chatting_profile_name">' + list.userName + '</span>' +
                            '<div class="chatting_sub_menu">' +
                            '<i class="icon-box" title="채팅방 서랍"></i>' +
                            '<i class="icon-search" title="검색"></i>' +
                            '</div>' +
                            '</div>' +
                            '</header>' +
                            '<main id="chatting_main">' +
                            '<div class="chatting_notice_bar">' +
                            '<i class="icon-bullhorn"></i>' +
                            '<span>공지 등록 하는곳</span>' +
                            '<i class="icon-down-open-big"></i>' +
                            '</div>' +
                            '<div class="chatting_content">' +
                            '<div class="chatting_date_line">' +
                            '<time datetime="2021-03-29">2021년 3월 29일 월요일</time>' +
                            '</div>' +
                            '<div id="main_chatting_' + roomId + '" class="main_chatting">';

                        /*	for (var i = 0; i < list.length; i++) {
                               var message = list[i]

                               if (message.userNo !== loginUser.userNo) {
                                 dialogContent +=
                                   '<div class="friend_chatting">' +
                                   '<img class="chatting_profile_img" src="'+ path + '/resources/image/chat/default.png" alt="프로필사진">' +
                                   '<div class="friend_chatting_col">' +
                                   '<span class="chatting_profile_name">' + message.userName + '</span>' +
                                   '<span class="chatting_balloon">' + message.message + '</span>' +
                                   '</div>' +
                                   '<time datetime="' + message.receivedDate + '" class="chatting_time">' + message.receivedDate + '</time>' +
                                   '</div>';
                               } else {
                                 dialogContent +=
                                   '<div class="me_chatting">' +
                                   '<div class="me_chatting_col">' +
                                   '<span class="chatting_balloon">' + message.message + '</span>' +
                                   '</div>' +
                                   '<time datetime="' + message.receivedDate + '" class="chatting_time">' + message.receivedDate + '</time>' +
                                   '</div>';
                               }
                             } */

                        dialogContent +=
                            '</div>' +
                            '</div>' +
                            '<div class="chatting_insert_content">' +
                            '<div class="chatform">' +
                            '<textarea id="chatting_textarea_' + roomId + '" class="chatting_send_textarea"></textarea>' +
                            '<input type="button" id="chatting_send_' + roomId + '" class="chatting_send_button" value="전송">' +
                            '</div>' +
                            '<div class="chatting_insert_menu">' +
                            '<i class="icon-smile"></i>' +
                            '<i class="icon-attach"></i>' +
                            '<i class="icon-phone"></i>' +
                            '<i class="icon-calendar-empty"></i>' +
                            '<i class="icon-camera"></i>' +
                            '</div>' +
                            '</div>' +
                            '</main>' +
                            '</div>';



                        // 다이얼로그(Dialog) 생성하기
                        var chattingDiglog = $("<div>").attr("id", "chatting_dialog_" + roomId).attr("title", chatRoom.roomTitle).html(dialogContent);						
						
                        // 다이얼로그(Dialog)를 body 요소에 추가
                        chattingDiglog.appendTo("body");

                        // 다이얼로그(Dialog) 초기화 및 움직일 수 있도록 설정
                        chattingDiglog.dialog({
                            close: function() {
                                // 다이얼로그 닫힐 때 요소 제거
                                chattingDiglog.dialog("destroy").remove();
                            },                            
                            modal: false,
                            height: 800,
                            width: 400                           
                        });
                        dialogElementStyle("chatting_dialog_" + roomId, '83px', '630px', '120');
                    },
                    error: function(xhr, status, error) {
                        console.error("Failed to fetch chat room data:", error);
                        // 에러 처리
                    },
                    complete : function(){
                        chattingSock[roomId] = new SockJS(path + "/chat/room/" + roomId);
                        console.log("채팅로그2 : "+roomId);	
                        
                        // 웹소켓 핸들러에서 sendMesage라는 함수가 호출되었을 때를 캐치하는 이벤트 핸들러
                        chattingSock[roomId].onmessage = function(e) {
                            // 매개변수 e : 발생한 이벤트에 대한 정보를 담고 있는객체
                            // e.data : 전달된 메세지가 담겨있음(json객체) ==> message.getPayload()
                            console.log("채팅로그3 : "+roomId);	
                            // 전달받은 메세지를 js객체로 변환

                            const chatMessage = JSON.parse(e.data); // json -> js Object
                            //	console.log(chatMessage);

                            var message = chatMessage.message;
                            var receivedDate = chatMessage.receivedDate;
                            var isCurrentUser = chatMessage.userNo === loginUser.userNo;

                            var chatContainer = document.getElementById("main_chatting_" + roomId);
                            console.log(chatContainer);
            
                            
                            if (!isCurrentUser) {
                                var friendChat = document.createElement("div");
                                friendChat.classList.add("friend_chatting");

                                var profileImg = document.createElement("img");
                                profileImg.classList.add("chatting_profile_img");
                                profileImg.src = chatMessage.profileImg ? chatMessage.profileImg : path + "/resources/image/chat/default.png";
                                profileImg.alt = "프로필사진";

                                var friendChatCol = document.createElement("div");
                                friendChatCol.classList.add("friend_chatting_col");

                                var profileName = document.createElement("span");
                                profileName.classList.add("chatting_profile_name");
                                profileName.textContent = chatMessage.userName;

                                var chattingBalloon = document.createElement("span");
                                chattingBalloon.classList.add("chatting_balloon");
                                chattingBalloon.textContent = message;

                                var chattingTime = document.createElement("time");
                                chattingTime.classList.add("chatting_time");
                                chattingTime.datetime = receivedDate;
                                chattingTime.textContent = receivedDate;

                                friendChatCol.appendChild(profileName);
                                friendChatCol.appendChild(chattingBalloon);

                                friendChat.appendChild(profileImg);
                                friendChat.appendChild(friendChatCol);
                                friendChat.appendChild(chattingTime);

                                chatContainer.appendChild(friendChat);
                            } else {
                                var meChat = document.createElement("div");
                                meChat.classList.add("me_chatting");

                                var meChatCol = document.createElement("div");
                                meChatCol.classList.add("me_chatting_col");

                                var chattingBalloon = document.createElement("span");
                                chattingBalloon.classList.add("chatting_balloon");
                                chattingBalloon.textContent = message;

                                var chattingTime = document.createElement("time");
                                chattingTime.classList.add("chatting_time");
                                chattingTime.datetime = receivedDate;
                                chattingTime.textContent = receivedDate;

                                meChatCol.appendChild(chattingBalloon);

                                meChat.appendChild(meChatCol);
                                meChat.appendChild(chattingTime);

                                chatContainer.appendChild(meChat);
                            }
                            

                            chatContainer.scrollTop = chatContainer.scrollHeight;

                        };
                    }
                    
                });
            }
        }
    });

};
chatAll();

/* 채팅방 생성 다이얼로그 */
$(document).ready(function() {
    // 다이얼로그(Dialog) 생성하기

    // 버튼 클릭 시 새로운 다이얼로그 열기
    $("#open-dialog-button").on("click", function() {
        // 동적으로 id 생성
        var dialogId = "new-dialog" + Date.now();       
	
        // 새로운 다이얼로그 요소 생성
        var newDialog = $("<div>").attr("id", dialogId).attr("title", "채팅방 만들기").addClass("chatting_made_dialog");
        newDialog.append(
            '<div>' +
            '<h5>채팅방 만들기</h5>' +
            '</div>' +
            '<div id="chatting_made_title">' +
            '<input type="text" placeholder="채팅방 제목" id="roomTitle" name="roomTitle">' +
            '</div>' +
            '<div id="chatting_made_button">' +
            '<button type="button" id="open-form" class="btn btn-primary">만들기</button>' +
            '<button type="button" class="btn btn-outline-primary">취소</button>' +
            '</div>'
        );

        // 만들기 버튼 클릭 이벤트 핸들러
        newDialog.on("click", "#open-form", function() {
            var roomTitle = $("#roomTitle").val();

            // AJAX 요청
            $.ajax({
                type: "POST",
                url: path + "/chat/openChatRoom",
                data: {
                    roomTitle: roomTitle
                },
                success: function(response) {
                    // 채팅방 생성 성공 시 동작
                    alert("채팅방 생성 성공");
                    // 추가로 수행할 작업이 있다면 여기에 작성
                    newDialog.dialog("close");
                    chatAll();
                },
                error: function(xhr, status, error) {
                    // 채팅방 생성 실패 시 동작
                    alert("채팅방 생성 실패");
                    // 추가로 수행할 작업이 있다면 여기에 작성
                }
            });
        });

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
        dialogElementStyle(dialogId,'83px','630px','130');
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

/* 다이얼로그들 위치 및 포지션 설정 */
function dialogElementStyle(Id, top, left, zIndex){
	document.getElementById(Id).parentNode.style.position='absolute'
	document.getElementById(Id).parentNode.style.top=top;
	document.getElementById(Id).parentNode.style.left=left;
	document.getElementById(Id).parentNode.style.zIndex=zIndex;
}


adminAll(); // 페이지 로딩 시 멤버 정보 가져오기
//window.setInterval(adminAll, 10000); // 주기적으로 멤버 정보 갱신