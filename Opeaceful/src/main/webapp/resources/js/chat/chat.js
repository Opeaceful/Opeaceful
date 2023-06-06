/**
 * 
 */
 import {path} from '../common/common.js';
 
   $(document).ready(function() {
    // 다이얼로그 초기화
    $("#dialog").dialog({
      autoOpen: false,
      modal: false,
      width: 600, // 다이얼로그의 너비 설정
      height: 400, // 다이얼로그의 높이 설정
    });

    // 다이얼로그 열기
    $("#openDialogButton").click(function() {
          // 로컬 스토리지에 다이얼로그 상태를 저장
          localStorage.setItem('dialogVisible', 'true');
           $("#dialog").dialog("open");
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

            console.log(loginUser);
            console.log(onlineStatus);
            console.log(list);
            console.log(onlineStatus[0].statusName);
            console.log(loginUser.statusType);         

            // list를 순회하면서 <li> 요소를 생성하여 멤버 정보 추가
            for (let item of list) {
            
                const li = document.createElement("li");
                const img = document.createElement("img");
                if(item.profileImg){
                img.src = item.profileImg; // 프로필 이미지 속성에 따라 변경
                }else{
                img.src = path+ "/resources/image/chat/default.png"
                }
                img.alt = item.userName;
          
                const div = document.createElement("div");
                div.classList.add("profile");
                const p1 = document.createElement("p");
                p1.innerText = item.userName;
                
                const p2 = document.createElement("p");
			    const p3 = document.createElement("p");
			    p3.classList.add("profile_box");
                const matchingStatus = onlineStatus.find(status => status.statusType === item.statusType);
			    if (matchingStatus) {
			        p2.innerText = matchingStatus.statusName;		        
					p3.innerHTML = `<img src="${path}/resources/image/status/${matchingStatus.statusImg}" alt="Status Image" class="profile_status_img">`;
					console.log(matchingStatus.statusImg);					
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


function changeStatus(status) {
    $.ajax({
        url: path+"/member/updateStatusType",  // 상태값을 업데이트할 서버의 엔드포인트
        type: 'POST',
        data: {status: status},
        success: function(response) {           
            console.log('상태값이 성공적으로 업데이트되었습니다.');
        },
        error: function(request) {
            console.error('상태값 업데이트 중 오류가 발생했습니다.');
        }
    });
}


adminAll(); // 페이지 로딩 시 멤버 정보 가져오기
//window.setInterval(adminAll, 10000); // 주기적으로 멤버 정보 갱신