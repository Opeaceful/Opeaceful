package com.company.opeaceful.member.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.company.opeaceful.attendance.model.service.AttendanceService;
import com.company.opeaceful.attendance.model.vo.Attendance;
import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@SessionAttributes({"loginUser"})
public class LoginController {
	
	private MemberService memberService;
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	private BoardService boardService;
	private AttendanceService attendanceService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	public LoginController( MemberService memberService,
							BCryptPasswordEncoder bcryptPasswordEncoder, 
							BoardService boardService,
							AttendanceService attendanceService) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		this.boardService = boardService;
		this.attendanceService = attendanceService;
		
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public LoginController() {}
	
	@GetMapping("/login")
	public String loginForward() {
		return "member/login";
	}
	
	
	@PostMapping("/login")
	public String loginMember(Member m,
							  Model model,
							  HttpSession session,
							  RedirectAttributes ra,
							  HttpServletResponse resp,
							  HttpServletRequest req,
							  @RequestParam(value="saveId", required=false) String saveId) {
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			model.addAttribute("loginUser", loginUser);
			
			// 로그인 성공시 아이디값을 저장하고 있는 쿠키 생성(유효시간 1년)
			Cookie cookie = new Cookie("saveId",String.valueOf(loginUser.getEno()));
			if(saveId != null) { // 아이디 저장이 체크되었을 때
				cookie.setMaxAge(60 * 60 * 24); // 초단위 지정(1년) - 60 * 60 * 24 * 365
			}else { // 아이디저장 체크하지 않을때
				cookie.setMaxAge(0);
			}
			// 쿠키에 아이디값 저장
			cookie.setPath(req.getContextPath());
			// 쿠키를 응답시 클라이언트에 전달
			resp.addCookie(cookie);
			
			return "redirect:/main";
		}else {
			session.setAttribute("alertMsg", "사원번호 및 비밀번호가 일치하지 않습니다.");
			return "redirect:/";
		}
	}
	@GetMapping("/main")
	public String MainMember(Model model, @ModelAttribute("loginUser") Member loginUser) {

		if(loginUser != null) {
			loginUser = memberService.loginMember(loginUser);
			Department topDept = memberService.selecTopDept(loginUser);
			List<Board> mainNoticeList = boardService.mainSelectNoticeList();
			int userNo = loginUser.getUserNo();
			Attendance ad = attendanceService.selectWorkOn(userNo);
			logger.info("출근 조회 로거 "+ad.getWorkOn());
			System.out.println("출근 조회 sys "+ad.getWorkOn());
	        // 현재 날짜/시간 출력
	        // 포맷팅 정의
//	        SimpleDateFormat formatter = new SimpleDateFormat("HH : mm : ss");
////	        // 포맷팅 적용
//	        String formatedNow = formatter.format(ad.getWorkOn());
////	        // 포맷팅 현재 날짜/시간 출력
//	        System.out.println(formatedNow); // 2022년 05월 03일 14시 43분 32초
			

			model.addAttribute("topDept",topDept);
			model.addAttribute("mainNoticeList", mainNoticeList);
			
			return "main";
		}else {
			return "login";
		}
	}
	
}