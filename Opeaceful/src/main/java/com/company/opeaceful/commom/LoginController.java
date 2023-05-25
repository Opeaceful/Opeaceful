package com.company.opeaceful.commom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.TestDB;
import com.company.opeaceful.member.model.service.MemberService;

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

	@RequestMapping("/login") // login이라는 url요청이 들어오면  mainForward()함수가 실행됨
	public String loginForward() {
		
		//DB 테스트용
		//tb.selectTest();
		
		// index.jsp의 forward를 처리하는 함수가 mainForward
		// index.jsp에서 다시한번 main페이지로 포워딩시켜줌
		return "login";  // 단순 문자열 작성시 무조건 forward가 실행됨		(WEB-INF/views + main + .jsp) -> main 앞뒤로 자동으로 붙음
						// servlet-context.xml <beans:bean > 태그 참고 
		
	}
	
	
	@RequestMapping("/main")
//	public String loginMember(Member m, Model model) {
	public String loginMember() { // 페이지만 넘기기위해서 임시로처리
		
		return "main";
	}
	
}