package com.company.opeaceful.commom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.member.model.service.MemberService;


@Controller
// 로그인, 회원가입기능 완료 후 실행될 코드
@SessionAttributes({"loginUser"})
public class MainController {
	
	private MemberService memberService;

	@Autowired
	public MainController(MemberService memberService) {
		this.memberService = memberService;
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public MainController() {}
	
	
//	public String loginMember(Member m, Model model) {
	@RequestMapping("/main")
	public String loginMember() { // 페이지만 넘기기위해서 임시로처리
		
		return "main";
	}
}
