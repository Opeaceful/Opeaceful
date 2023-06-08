package com.company.opeaceful.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@SessionAttributes({"loginUser", "chatRoomNo"})
public class ChattingController {
	
	@Autowired
	private ChatService service;
	
	// 채팅방 목록 조회
	@GetMapping("/chatRoom")
	public String selectChatRoomList(Model model) {
		
		List<ChatRoom> crList = service.selectChatRoomList();
		
		model.addAttribute("chatRoomList", crList);
		
		return "chatRoom";
	}
	
	
	// 채팅방 만들기
	@PostMapping("/chatRoom/openChatRoom")
	public String openChatRoom(@ModelAttribute("loginUser") Member loginUser,
								Model model,
								ChatRoom room,
								RedirectAttributes ra){
		
		room.setUserNo(loginUser.getUserNo());
		
		int chatRoomNo = service.openChatRoom(room); // 생성된 채팅방 번호
			
		String path = "redirect:/"; //
		if(chatRoomNo > 0) { //제대로 생성됨
			
			ra.addAttribute("alertMsg","채팅방 생성 성공");
			path += "chatRoom";
			
			// path += "room/"+ chatRoomNo;  // 상세화면 구현후 변경예정
		}else {
			ra.addFlashAttribute("alertMsg", "채팅방 생성 실패");
			path += "chatRoom";
		}
		
		return path;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
