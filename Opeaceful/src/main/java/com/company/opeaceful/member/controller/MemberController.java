package com.company.opeaceful.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@RequestMapping("/member") // localhost:8081/spring/member 이하의 url요청을 처리하는 컨트롤러
@SessionAttributes({"loginUser"})
public class MemberController {
	
	private MemberService memberService;
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	public MemberController(MemberService memberService,  BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		
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
			UserDepatment ud,
			HttpSession session) {
		
		//암호화 작업
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		
		//암호화된 pwd를 m의 userPwd 다시 대입
		m.setUserPwd(encPwd);
		
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { //성공적으로 추가시
			//부서추가
			int result2 = memberService.insertUserDept(ud);
			
			if(result2>0) { 
				int userEno = memberService.selectENO();
				session.setAttribute("userEno", userEno);
				
			}else{
				session.setAttribute("alertMsg", "사용자 부서 생성 오류발생. 담당자에게 문의하세요");
			}
		}else {
			session.setAttribute("alertMsg", "사용자 생성 오류발생. 담당자에게 문의하세요");
		}
		
	
		return "member/member-create";
		
	}
	
	
}
