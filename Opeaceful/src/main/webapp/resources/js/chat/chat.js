/**
 * 
 */
 
console.log("나다");
 function adminAll() {
 console.log("너다");
    $.ajax({
        url: "chat",
        dataType: "json",
        success: function(response) {
        console.log("여기야1")
            const adminList = document.getElementById("adminList");
            console.log("여기야2")
            adminList.innerHTML = ""; // 기존 내용 초기화
            console.log("여기야3")
            
            const loginUser = response.loginUser;
            console.log("여기야4")
            console.log("로그인 사용자 데이터:", loginUser);
            const list = response.list;
            console.log("여기야5")
            
            // list를 순회하면서 <li> 요소를 생성하여 멤버 정보 추가
            for (let item of list) {
            console.log("여기야6")
                const li = document.createElement("li");
                const img = document.createElement("img");
                img.src = item.profileImg; // 프로필 이미지 속성에 따라 변경
                img.alt = item.userName;
                
                const div = document.createElement("div");
                const p1 = document.createElement("p");
                p1.innerText = item.userName;
                
                const p2 = document.createElement("p");
                p2.innerText = item.userNo;
                
                div.appendChild(p1);
                div.appendChild(p2);
                
                li.appendChild(img);
                li.appendChild(div);
                
                adminList.appendChild(li);
            }
        },
        error: function(request) {
            console.log("에러발생");
            console.log("에러코드, " + request.status);
            console.log("여기야8")
        }
    });
}
adminAll(); // 페이지 로딩 시 멤버 정보 가져오기
window.setInterval(adminAll, 10000); // 주기적으로 멤버 정보 갱신