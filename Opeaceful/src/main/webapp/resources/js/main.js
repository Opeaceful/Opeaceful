/**
 * [지의] - main.js
 */
import {path} from './common/common.js';
/* 현재 시간 표시 */
const today = document.getElementById('main-day');
const time = document.getElementById('main-time');

let d = new Date();

let year = d.getFullYear(); 	// 년도
let month = d.getMonth() + 1;	// 월
let date = d.getDate();  		// 날짜

let weekday = new Array(7);
weekday[0] = "일";
weekday[1] = "월";
weekday[2] = "화";
weekday[3] = "수";
weekday[4] = "목";
weekday[5] = "금";
weekday[6] = "토";

let day = weekday[d.getDay()];

if(month < 10){month = "0"+month;}
if(date < 10){date = "0"+date;}
today.innerHTML = year + "-" + month + "-" + date  + " (" + day  + ")";

function getTime() {
    let d = new Date();
    
    let hur = d.getHours();		// 시
    let min = d.getMinutes();	//분
    let sec = d.getSeconds();	//초
    if(d.getHours() < 10){hur = "0"+hur;}
    if(d.getMinutes() < 10){min = "0"+min;}
    if(d.getSeconds() < 10){sec = "0"+sec;}

    time.innerHTML = hur + " : " + min + " : " + sec;	// 형식 지정
    
    setTimeout(getTime, 1000);	//1000밀리초(1초) 마다 반복
}



/* 접속상태 표시 */
function onClickState(e) {
    const isActive = e.currentTarget.className.indexOf("active") !== -1;
    if (isActive) {
    e.currentTarget.className = "select";
    } else {
    e.currentTarget.className = "select active";
    }
}

document.querySelector("#state .select").addEventListener("click", onClickState);

function onClickStateOption(e) {
    const selectedValue = e.currentTarget.innerHTML;
    document.querySelector("#state .text").innerHTML = selectedValue;
}

var stateList = document.querySelectorAll("#state .option");
for (let i = 0; i < stateList.length; i++) {
    let state = stateList[i];
    state.addEventListener("click", onClickStateOption);
}


/* 칼라모드 표시 */
function onClickMode(e) {
    const isActive = e.currentTarget.className.indexOf("active") !== -1;
    if (isActive) {
        e.currentTarget.className = "mode-select";
    } else {
        e.currentTarget.className = "mode-select active";
    }
}

document.querySelector("#color-mode .mode-select").addEventListener("click", onClickMode);

function onClickModeOption(e) {
    const selectedValue = e.currentTarget.innerHTML;
    document.querySelector("#color-mode .mode-text").innerHTML = selectedValue;
}

let ModeList = document.querySelectorAll("#color-mode .mode");
for (var i = 0; i < ModeList.length; i++) {
    let mode = ModeList[i];
    mode.addEventListener("click", onClickModeOption);
}

$(function(){
    /* 입사날짜 구하기 */
    // mainHireDate : main.jsp에서 입사날짜 빼옴
    let hireDate = new Date(mainHireDate);
        
    let ms = d.getTime() - hireDate.getTime() ;
    let dDay = ms / (1000*60*60*24);
    
    document.getElementById("main-d-day").innerHTML = Math.floor(dDay);


})

/* 공지사항 제목부분 클릭시 공지사항 페이지로 */
$("#main-notice-title").on("click", function(){
    location.href = path+"/member/mypage"; // 일단 마이페이지로 넣어둠
})


getTime();