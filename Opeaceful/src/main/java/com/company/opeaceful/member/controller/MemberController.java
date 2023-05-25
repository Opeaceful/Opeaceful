package com.company.opeaceful.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.member.model.service.MemberService;

@Controller
@RequestMapping("/member") // localhost:8081/spring/member 이하의 url요청을 처리하는 컨트롤러
@SessionAttributes({"loginUser"})
public class MemberController {
	
	private MemberService memberService;

	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public MemberController() {}
	
	@RequestMapping("/mypage")
	public String updateMember() {
		
		return "mypage";
	}
}
