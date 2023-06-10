/**
 * 
 */
 
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
  
  