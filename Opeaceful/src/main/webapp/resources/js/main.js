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
let hur = d.getHours();		// 시
let min = d.getMinutes();	//분
let sec = d.getSeconds();	//초

if(d.getHours() < 10){hur = "0"+hur;}
if(d.getMinutes() < 10){min = "0"+min;}
if(d.getSeconds() < 10){sec = "0"+sec;}

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
    location.href = path+"/board/list/N";
})
$(function(){
    $(".white-btn").attr("disabled", true);
    // input button으로 작업
})

$("#main-on").click(function(){
    swal(hur +":"+ min,"출근 처리 하시겠습니까?",{
        buttons: {confirm: "확인", cancel: "취소"}
    })
    .then(function(isConfirm){
        if(isConfirm){
            $.ajax({
                type : "POST",
                //url : "",
                url : path+"/attendance/workOn",
                dataType : "json",
                success : function(result) {
                    console.log(result);
                    $("#main-on").removeClass('navy-btn').addClass('white-btn').attr("disabled", true);

                    $("#main-off").removeClass('white-btn').addClass('navy-btn').attr("disabled", false);
                },
                error : function(e) {
                    swal("이미 출근처리 되었습니다.");
                }
            })
        }
    })
});

$("#main-off").click(function(){
    swal(hur +":"+ min,"퇴근 처리 하시겠습니까?",{
        buttons: {confirm: "확인", cancel: "취소"}
    })
    // .then(function(isConfirm){
    //     if(isConfirm){
    //         $.ajax({
    //             type : "POST",
    //             url : "",
    //             //url : path+"/attendance/workOn",
    //             dataType : "json",
    //             success : function(result) {
    //                 // console.log(result);
    //                 // $("#main-on").removeClass('navy-btn').addClass('white-btn').attr("disabled", true);

    //                 // $("#main-off").removeClass('white-btn').addClass('navy-btn').attr("disabled", false);
    //                 swal("일단 됨");
    //             },
    //             error : function(e) {
    //                 swal("????");
    //             }
    //         })
    //     }
    // })
});



// input radio로 작업
// $("#main-on").change(function(){
//     swal(hur +":"+ min,"출근 처리 하시겠습니까?",{
//         buttons: {confirm: "확인", cancel: "취소"}
//     })
//     .then(function(isConfirm){
//         if(isConfirm){
//             $.ajax({
//                 type : "POST",
//                 // url : "",
//                 url : path+"/attendance/workOn",
//                 dataType : "json",
//                 success : function(result) {
//                     swal("성공", "작업을 정상적으로 완료하였습니다.");
//                     console.log(result);
//                 },
//                 error : function(e) {
//                     swal("작업수행에 실패하였습니다.");
//                 }
//             })
//         }
//     })
// });
// $("#main-off").change(function(){
//     swal(hur +":"+ min,"퇴근 처리 하시겠습니까?",{
//         buttons: {confirm: "확인", cancel: "취소"}
//     })
//     .then(function(){
//         $.ajax({
//             type : "POST",
//             url : "",
//             data : "",
//             dataType : "json",
//             success : function(data) {
//                 swal("성공", "작업을 정상적으로 완료하였습니다.");
//                 console.log(data);
//             },
//             error : function(e) {
//                 swal("작업수행에 실패하였습니다.");
//             }
//         })
//     })
// });







// 시간표시 함수 실행
getTime();