/**
 * 작성자 : 김혜린
 */

//import {path} from '../common/common.js';

//  let lockCheckObj = {
//     secretReply : 'N'
//  }




//  $(function(){
//  	//selectReplyList();
 
//     // ==== 자물쇠 버튼 ====
//     let lock = $(".lock-btn");
//     let unlock = $(".unlock-btn");
//     let lockSm = $(".sm-lock-btn");
//     let unlockSm = $(".sm-unlock-btn");

//     unlock.on('click', function(){
//          console.log("Locking...");
//         unlock.css('display', 'none');
//         lock.css('display', 'block');
//         lockCheckObj.secretReply = 'Y';
//         console.log("secret유무 (Y/N)" + lockCheckObj.secretReply);
//     })

//     lock.on('click', function(){
//          console.log("Unlocking...");
//         unlock.css('display', 'block');
//         lock.css('display', 'none');
//         lockCheckObj.secretReply = 'N';
//         console.log("secret유무 (Y/N)" + lockCheckObj.secretReply);
//     })

//     unlockSm.on('click', function(){
//         // console.log("Locking...");
//         unlockSm.css('display', 'none');
//         lockSm.css('display', 'block');
//     })

//     lockSm.on('click', function(){
//         // console.log("Unlocking...");
//         unlockSm.css('display', 'block');
//         lockSm.css('display', 'none');
//     })

//     // ==== 댓글창 on/off ====
//     $('.re-reply-btn').on('click', function(){
//         if($('.re-btn-text').text() == "답글달기"){
//             console.log("댓글창 열림")
//             $('.re-btn-text').text("답글취소");
//             $('.re-reply-input-area').css('display', 'flex');
//         }else{
//             console.log("댓글창 닫힘")
//             $('.re-btn-text').text("답글달기");
//             $('.re-reply-input-area').css('display', 'none');
//         }
//     })

    
// })

// function selectReplyList(){
//     $.ajax({
//         url : '${contextPath}/reply/selectReplyList',
//         data : {bno : '${b.boardNo}'},
//         dataType : 'json',
//         success: function(result){
//             console.log(result);
//             let html ="";
//             for(let reply of result){
//                 html += "<tr>";
//                 html += "<td>"+reply.replyWriter +"</td>";
//                 if(reply.userNo == '${loginUser.userNo}'){
//                     html += "<td><textarea id='replyContent"+reply.replyNo+"'>"+reply.replyContent +"</textarea></td>";
//                 }else{
//                     html += "<td>"+reply.replyContent +"</td>";
//                 }
//                 html += "<td>"+reply.createDate +"</td>";
//                 if(reply.userNo == '${loginUser.userNo}'){
//                     html += "<td><button onclick='updateReply("+reply.replyNo+");'>수정</button>"+
//                     "<button onclick='deleteReply("+reply.replyNo+")'>삭제</button>"
//                     +"</td>";
//                 }										   
//                 html += "</tr>";
//             }
//             $("#replyArea tbody").html(html);
//             $("#rcount").html(result.length);
//         },error : function(req,sts,err){
//             console.log(req);
//             console.log(sts);
//             console.log(err);
//         } 
//     })
// }

//$("#reply-insert-btn").on('click', insertReply());

// function insertReply(){
    
//     $.ajax({
//         url: path + "/reply/insert",
//         data : {
//             boardNo : '${b.boardNo}',
//             userNo: '${loginUser.userNo}',
//             replyContent : $(".reply-content").val(),
//             secret : lockCheckObj.secretReply							
//         },
//         type : 'POST',
//         success : function (result){
//             if(result == "1"){
//                 console.log("댓글 등록 성공");
//             }else{
//                 console.log("댓글 등록 실패");
//             }
//             //selectReplyList();
//         },
//         complete : function(){
//             $(".reply-content").val("");
//         }
        
//     })
    
// }

// function deleteReply(replyNo){
//     $.ajax({
//         url : "${contextPath}/reply/delete",
//         data : {replyNo},
//         success : function(result){
//             if(result == 1){
//                 alert("삭제에 성공했습니다.");
//             }else{
//                 alert("삭제에 실패했습니다");									
//             }
//             selectReplyList();
//         }
//     })
// }

// function updateReply(replyNo){
//     $.ajax({
//         url : "${contextPath}/reply/update",
//         data : {
//             replyNo,
//             replyContent : $("#replyContent"+replyNo).val()
//         },
//         type : 'POST',
//         success : function(result){
//             if(result == 1){
//                 alert("댓글수정 성공");
//             }else{
//                 alert("댓글수정 실패");
//             }
//             selectReplyList();
//         }
//     })
// }