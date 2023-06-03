package com.company.opeaceful.chat.controller;

import java.util.ArrayList;

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
	public String chatMain(Model model, @ModelAttribute("loginUser") Member loginUser) {
		
		ArrayList<Member> list = chatService.adminAll();
	
	    model.addAttribute("memberList", list);
	    
	    System.out.println(model);
	    System.out.println(list);
		
		return "chat";

	}

	/*
	 * @GetMapping("/adminAll")
	 * 
	 * @ResponseBody public String adminAll() {
	 * 
	 * ArrayList<Member> list = chatService.adminAll();
	 * 
	 * return new Gson().toJson(list);
	 * 
	 * }
	 */
}
