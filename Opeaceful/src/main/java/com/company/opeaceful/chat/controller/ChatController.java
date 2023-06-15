package com.company.opeaceful.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.chat.model.vo.Chat;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;
import com.google.gson.Gson;

@Controller
@SessionAttributes({ "loginUser", "chatRoomList", "userNo" })
public class ChatController {

	@Autowired
	private ChatService chatService;

	@Autowired
	public ChatController(ChatService chatService) {
		this.chatService = chatService;
	}
	
	@GetMapping("/chat")
	@ResponseBody
	public String chatMain(@ModelAttribute("loginUser") Member loginUser) {
		
		Map<String, Object> response = new HashMap<>();
	    
	    ArrayList<Member> list = chatService.adminAll();
	    ArrayList<OnlineStatus> onlineStatus = chatService.onlineStatusList();
	    ArrayList<Board> notice = chatService.noticeList();
	    List<ChatRoom> crList = chatService.selectChatRoomList();
	    
	    response.put("loginUser", loginUser);
	    response.put("memberList", list);
	    response.put("onlineStatus", onlineStatus);
	    response.put("notice", notice);
	    response.put("crList", crList);

	    return new Gson().toJson(response);

	}
	
//	// 채팅방 목록 조회
//	@GetMapping("/chat/chatRoom")
//	@ResponseBody
//	public String selectChatRoomList(@ModelAttribute("loginUser") Member loginUser) {
//		
//		Map<String, Object> response = new HashMap<>();
//		
//		
//		
//		
//		response.put("loginUser", loginUser);
//			
//		return new Gson().toJson(response);
//	}
	
	
	// 채팅방 만들기
	@PostMapping("/chat/openChatRoom")
	@ResponseBody
	public String openChatRoom(@ModelAttribute("loginUser") Member loginUser,
								Model model,
								ChatRoom room,
								RedirectAttributes ra){
			
		room.setUserNo(loginUser.getUserNo());
			
		int chatRoomNo = chatService.openChatRoom(room); // 생성된 채팅방 번호
		
		
		if(chatRoomNo > 0) { //제대로 생성됨
				
			ra.addFlashAttribute("alertMsg","채팅방 생성 성공");
		//	path += "chat";				
		}else {
			ra.addFlashAttribute("alertMsg", "채팅방 생성 실패");
		}
			
			return new Gson().toJson(chatRoomNo);
		}
	
	
	@GetMapping("/chat/webSocket")
	@ResponseBody
	public String joinChatRoom(@ModelAttribute("loginUser") Member loginUser,								
								Model model,																
								ChatParticipant join,
								
								RedirectAttributes ra
								) {
		join.setUserNo(loginUser.getUserNo());
		
		List<ChatParticipant> chatRoomList = chatService.chatRoomList(loginUser);
		
		
		Map<String, Object> response = new HashMap<>();
		
		List<Chat> list = chatService.joinChatRoom(join);
			
		
		if(list != null) {
			
			model.addAttribute("list", list);
			model.addAttribute("chatRoomList", chatRoomList);
			model.addAttribute("userNo", loginUser.getUserNo());
			System.out.println(chatRoomList);
			
			response.put("loginUser", loginUser);
		    response.put("list", list);
		    response.put("join", join);
			
			return new Gson().toJson(response);
			
		}else {
			ra.addFlashAttribute("alertMsg", "채팅방이 존재하지 않습니다");
			return "redirect:../chat";
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}