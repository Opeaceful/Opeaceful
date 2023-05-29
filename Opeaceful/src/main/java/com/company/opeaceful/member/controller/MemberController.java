package com.company.opeaceful.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

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
	
	// [지의] - 마이페이지
	@RequestMapping("/mypage")
	public String updateMember() {
		
		return "member/mypage";
	}
	
	//[지영]
	//member-create로 이동
	@RequestMapping("/create")
	public String createMember() {
		
		return "member/member-create";
	}
	
	//[지영]
	//사용자생성 
	@PostMapping("/insert")
	public String insertMember(Member m,
			int pCode, int deptCode) {
		
		System.out.println(pCode);
		System.out.println(deptCode);
		
		int result = memberService.insertMember(m);
		
		
		System.out.println(result);
		
		return "member/member-create";
		
	}
	
	
}
