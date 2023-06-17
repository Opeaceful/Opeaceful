//작성자 : 윤지영, 노지의
//주소 API JS + tel 셋팅

//<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 위에 붙여주기 : API 스크립트!

//클릭시 팝업이 뜰 버튼에 : id="seach-address"
//주소가 들어갈 input에 : id="user-address"
//상세 주소 input에 : id="user-address-dtail"


window.onload = function(){

    // console.log("들어옴!")
    document.getElementById("seach-address").addEventListener("click", function(){ //아이콘 클릭시
        //카카오 지도 발생
        DaumAddressAPI();
    });

    document.getElementById("user-address").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        DaumAddressAPI();
    });
}

function DaumAddressAPI(){
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            document.getElementById("user-address").value = data.address; // 주소 넣기
            
            const detailAddress = document.getElementById("user-address-dtail");
            detailAddress.value = data.buildingName; // 빌딩이름 있으면 넣어주고
            detailAddress.focus(); //포커스해주기
        }
    }).open();

}



//전화번호 입력 자동 입력  
function autoHypenTel(str) {
    str = str.replace(/[^0-9]/g, '');
    var tmp = '';

    if (str.substring(0, 2) == 02) {
        // 서울 전화번호일 경우 10자리까지만 나타나고 그 이상의 자리수는 자동삭제
        if (str.length < 3) {
            return str;
        } else if (str.length < 6) {
            tmp += str.substr(0, 2);
            tmp += '-';
            tmp += str.substr(2);
            return tmp;
        } else if (str.length < 10) {
            tmp += str.substr(0, 2);
            tmp += '-';
            tmp += str.substr(2, 3);
            tmp += '-';
            tmp += str.substr(5);
            return tmp;
        } else {
            tmp += str.substr(0, 2);
            tmp += '-';
            tmp += str.substr(2, 4);
            tmp += '-';
            tmp += str.substr(6, 4);
            return tmp;
        }
    } else {
        // 핸드폰 및 다른 지역 전화번호 일 경우
        if (str.length < 4) {
            return str;
        } else if (str.length < 7) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3);
            return tmp;
        } else if (str.length < 11) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 3);
            tmp += '-';
            tmp += str.substr(6);
        return tmp;
        } else {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 4);
            tmp += '-';
            tmp += str.substr(7);
            return tmp;
        }
    }

    return str;
}

