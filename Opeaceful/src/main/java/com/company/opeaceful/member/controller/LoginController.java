package com.company.opeaceful.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@SessionAttributes({"loginUser"})
public class LoginController {
	
	private MemberService memberService;

	@Autowired
	public LoginController(MemberService memberService) {
		this.memberService = memberService;
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public LoginController() {}
	
//	@Autowired
//	private TestDB tb;

	@RequestMapping("/login")
	public String loginForward() {
		
		//DB 테스트용
		//tb.selectTest();
		
		return "member/login";
		
	}
	
	
	@PostMapping("/main")
	public String loginMember(Member m,
							  Model model,
							  HttpSession session) {
		
		Member loginUser = memberService.loginMember(m);
		System.out.println("로그인유저? "+loginUser);
		if(loginUser == null) {
			session.setAttribute("alertMsg", "사원번호 및 비밀번호 확인");
			
			return "redirect:/";
		}else {
			
			session.setAttribute("loginUser", loginUser);
			return "main";
			
		}

		
	}
	
}