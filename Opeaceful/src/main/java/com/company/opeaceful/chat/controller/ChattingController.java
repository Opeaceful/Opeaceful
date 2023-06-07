package com.company.opeaceful.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;

@Controller
@SessionAttributes({"loginUser", "chatRoomNo"})
public class ChattingController {
	
	@Autowired
	private ChatService service;
	
	// 채팅방 목록 조회
	@GetMapping("/chatRoom")
	public String selectChatRoomList(Model model) {
		
		List<ChatParticipant> crList = service.selectChatRoomList();
		
		model.addAttribute("chatRoomList", crList);
		
		return "chatRoom";
	}
	
	
}
