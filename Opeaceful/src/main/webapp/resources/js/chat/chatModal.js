
/*
 * 작성자 윤지영 - 수정 김진기
 * 전체 member 선택용 모달창 js 
*/

import {path} from '../common/common.js';


//클릭후 값을 누르면 배열형태로 해당 직원 memberNO가 들어갑니다. 나머지는 자기 이벤트에 맞춰서 사용!!
//저같은 경우에는 ajax로 데이터 넘겨줄 꺼라 해당 페이지 js로 변수 가져가서 이벤트 처리했습니다. 
//이페이지에서 이벤트 처리할 경우 if() 자기페이지 걸어서 충돌나지 않게 조심 ***
export let checkMemberNo;

$("#all-user-view-int").keyup(function(key){
        modalAllMemberViewChat();
});

modalAllMemberViewChat();

function modalAllMemberViewChat(){

    let keyword =  document.getElementById("chat-all-user-view-int").value;
    console.log(keyword);

  
    $.ajax({
        url:`${path}/member/modalAllMemberView`,
        dataType : "JSON",
        method: 'POST',
        data: {
            keyword : keyword,
        },
        success: function(result){    
            let html = ""

            const deptMember = {};
            //팀별로 배열 나눠주기 
            for (let i = 0; i < result.length; i++) {
                const item = result[i];
                const deptCode = item.deptCode;
             
                if (!deptMember[deptCode]) { //해당팀이 없다면 팀 넣고, item 넣기
                    deptMember[deptCode] = [item];
                } else { //있다면 해당 팀에 item넣기
                    deptMember[deptCode].push(item);
                }
            }

            //만들어둔 object 반복문 돌리면서 table생성
            for(let deptm in deptMember){ 
                html += 
                `
                <tr>
                    <th rowspan="${deptMember[deptm].length}" class="t-v-middle"><input class="form-check-input" type="checkbox" data-chatkey="${deptMember[deptm][0].deptCode}" ></th>
                    <th rowspan="${deptMember[deptm].length}" class="t-v-middle">${deptMember[deptm][0].dName}</th>
                    <td><input class="form-check-input" type="checkbox" data-chatkey="${deptMember[deptm][0].deptCode}" value="${deptMember[deptm][0].userNo}"></td>
                    <td>${deptMember[deptm][0].userName} ${deptMember[deptm][0].pName}</td>
                </tr>
                `

                for(let i = 1; i < deptMember[deptm].length; i++){
                    html += 
                    `
                    <tr>
                        <td><input class="form-check-input" type="checkbox" data-chatkey="${deptMember[deptm][i].deptCode}" value="${deptMember[deptm][i].userNo}"></td>
                        <td>${deptMember[deptm][i].userName} ${deptMember[deptm][i].pName}</td>
                    </tr>
                    `
                } 
            }

            let allMemberTableBody = document.getElementById("chat-all-member-table-body");
            allMemberTableBody.innerHTML = html;

            //이벤트 설정
            checkboxEventListenersChat();


        },
        error : function(request){
            console.log("에러발생");
            console.log(request.status);
        }
    });

}

//조회 버튼 클릭시
$("#chat-all-member-view-button").click(function(){
   
    $('#chat-all-user-view').modal('show');
});

//체크박스에 cilck이벤트를 부여하는 함수
function checkboxEventListenersChat() {

    //팀 체크박스에 이벤트 부여
    const TeamCheckboxes = document.querySelectorAll('#chat-all-member-table tbody th input[type="checkbox"]');
    TeamCheckboxes.forEach(function(checkbox){
        checkbox.addEventListener('click', function(){
            checkedEventChat(this);
        })
    })

    //제목 체크박스에 전체선택 이벤트 부여
    const AllCheckboxes = document.getElementById('chat-all-tcode');
    AllCheckboxes.addEventListener('click', function(){
        const TeamCheckboxes = document.querySelectorAll('#chat-all-member-table tbody input[type="checkbox"]');
        TeamCheckboxes.forEach(function(TeamCheckboxes) {
            TeamCheckboxes.checked = AllCheckboxes.checked;
        });
    })

    //성명 체크박스에 이벤트 부여
    const UserCheckboxes = document.querySelectorAll('#chat-all-member-table tbody td input[type="checkbox"]');
    UserCheckboxes.forEach(function(checkbox){
        checkbox.addEventListener('click', function(){
            UsercheckedEventChat(this);
        })
    })

}

//팀 체크박스 클릭시 해당 팀원들 자동체크해주는 기능
function checkedEventChat(checkbox){
    const teamName = checkbox.dataset.chatkey  
    console.log(teamName);
    console.log(teamName);  
    const rowCheckboxes = document.querySelectorAll(`input[type="checkbox"][data-chatkey="${teamName}"]`)
    
    rowCheckboxes.forEach(function(uNameCheckbox) {
        uNameCheckbox.checked = checkbox.checked;
     });
}   

function UsercheckedEventChat(checkbox){

  
    //팀명이름
    const UserName = checkbox.dataset.chatkey;
    //팀명을 가진 모든 checkbox
    const UserNameCheckboxes = document.querySelectorAll(`input[type="checkbox"][data-chatkey="${UserName}"]`)
    //팀명을 가진 모든 checked 된 checkbox
    const checkedboxs = document.querySelectorAll(`input[type="checkbox"][data-chatkey="${UserName}"]:checked`); 

    //체크박스가 눌렸을때
    if(!checkbox.checked){
        UserNameCheckboxes[0].checked = false;
    }else{
        //팀명의 체크박스가 모두 눌린다면 팀명 box도 눌리기
        if(checkedboxs.length == UserNameCheckboxes.length - 1 ){
        UserNameCheckboxes[0].checked = true;
        }
    }

}

//확인 버튼 클릭시
$("#chat-all-member-modal-button").click(function(){
    checkMemberChat();
});


function checkMemberChat(){
    //체크된 체크박스 확인 
    const checkboxes = document.querySelectorAll('#chat-all-member-table td input[type="checkbox"]:checked');
    checkMemberNo = [];
    //해당 값 
    checkboxes.forEach(function(checkbox) {
        checkMemberNo.push(checkbox.value); 
    });

    //모달 닫기
    $('#chat-all-user-view').modal('hide');
 //   console.log(checkMemberNo);
}

//input창이 있을 경우 input창을 통한 검색
if(document.getElementById("chat-member-search-keyword")) {


    document.getElementById("chat-member-search-keyword").addEventListener("keydown", function(event) {
         if (event.key === "Enter") {
           event.preventDefault(); // 기본 엔터 동작 방지
                $.ajax({
                url:`${path}/member/modalAllMemberView`,
                dataType : "JSON",
                method: 'POST',
                data: {
                    keyword : event.target.value,
                },
                success: function(result){
                    checkMemberNo = [];
                    for(let m of result){
                        checkMemberNo.push(m.userNo); 
                    }

                    //값이 하나도 없을 경우
                   if(checkMemberNo.length < 1){
                        modalAllMemberViewChat();
                        //모달 열기
                        $('#chat-all-user-view').modal('show');
                   }
                },
                error : function(request){
                    console.log("에러발생");
                    console.log(request.status);
                }
            })
         }
   
    })
    
}