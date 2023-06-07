package com.company.opeaceful.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;
import com.google.gson.Gson;

@Controller
@SessionAttributes({ "loginUser" })
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
	    
	    System.out.println(list);
	    System.out.println(onlineStatus);
	    System.out.println(notice);
	    

	    response.put("loginUser", loginUser);
	    response.put("memberList", list);
	    response.put("onlineStatus", onlineStatus);
	    response.put("notice", notice);

	    return new Gson().toJson(response);

	}
	
	@GetMapping("/chatRoom")
	public String chatRoom() {
		
		return "chatRoom";
	}
	
	/*
	 * @GetMapping("/chatMemberStatus") public String MemberStatus(Model model) {
	 * 
	 * ArrayList<MemberStatus> ms = chatService.chatStatus();
	 * 
	 * model.addAttribute("chatStatus", ms);
	 * 
	 * return "chat";
	 * 
	 * }
	 */
	
	
	
	
	

}