package com.company.opeaceful.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@SessionAttributes({"loginUser","dpName"})
public class LoginController {
	
	private MemberService memberService;
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	private BoardService boardService;

	@Autowired
	public LoginController(MemberService memberService,  BCryptPasswordEncoder bcryptPasswordEncoder, BoardService boardService) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		this.boardService = boardService;
		
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
		UserDepatment dpName = memberService.selectdpName(loginUser.getUserNo());
		List<Board> mainNoticeList = boardService.mainSelectNoticeList();
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("dpName",dpName);
			model.addAttribute("mainNoticeList", mainNoticeList);
			return "main";
		}else {
			session.setAttribute("alertMsg", "사원번호 및 비밀번호가 일치하지 않습니다.");
			return "redirect:/";
		}
	}
	@GetMapping("/main")
	public String MainMember() {
		


		return "main";
	}
	
}