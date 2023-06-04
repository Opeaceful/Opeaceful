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

import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.member.model.vo.Member;
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
	public Map<String, Object> chatMain(Model model, @ModelAttribute("loginUser") Member loginUser) {
		
		Map<String, Object> response = new HashMap<>();
	    
	    ArrayList<Member> list = chatService.adminAll();

	    response.put("loginUser", loginUser);
	    response.put("memberList", list);

	    return response;

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