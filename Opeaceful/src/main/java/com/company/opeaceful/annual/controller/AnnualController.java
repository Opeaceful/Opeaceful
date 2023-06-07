package com.company.opeaceful.annual.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.annual.model.service.AnnualService;
import com.company.opeaceful.annual.model.vo.Annual;
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
@RequestMapping("/annual")
public class AnnualController {

	private AnnualService annualService;
	private MemberService memberService;
	
	@Autowired
	public AnnualController(AnnualService annualService,
							MemberService memberService) {
		this.annualService = annualService;
		this.memberService = memberService;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// [지의] 총 연차테이블 조회
	@GetMapping("/setting")
	public String selectAnnualAll(Model model){
		
		List<Annual> list = annualService.selectAnnualAll();
		
		logger.info("get : "+list);
		
		model.addAttribute("annual", list);
		
		return "annual/annual";
	}
	
	// [지의] 총 연차 수정
	@PostMapping("/setting")
	public String updateAnnual(Annual a,Model model) {
		
		//logger.info(" "+year);
		logger.info("post : "+a);
		int result = annualService.updateAnnual(a);
		
		if(result > 0) {
			List<Annual> list = annualService.selectAnnualAll();
			model.addAttribute("annual", list);
		}
		
		return "annual/annual";
	}
	
	// [지의] 유저 연차 조회 
	@GetMapping("/list")
	public String listAnnaul(){
		
		return "annual/annual-user";
	}
	
	
}
