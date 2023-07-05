package com.company.opeaceful.annual.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.annual.model.service.AnnualService;
import com.company.opeaceful.annual.model.vo.Annual;
import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.vo.UserRole;
import com.google.gson.Gson;

@Controller
@SessionAttributes({"loginUser","alertMsg"})
@RequestMapping("/annual")
public class AnnualController {

	private AnnualService annualService;
	private ApprovalService approvalService;

	
	@Autowired
	public AnnualController(AnnualService annualService,ApprovalService approvalService) {
		this.annualService = annualService;
		this.approvalService = approvalService;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// [지의] 총 연차테이블 조회
	@GetMapping("/setting")
	public String selectAnnualAll(Model model, @SessionAttribute("loginUserRole") List<UserRole> loginUserRole){
		
		List<Annual> list = annualService.selectAnnualAll();

		boolean roleCheck = false;
		for(UserRole role:loginUserRole) {
			if(role.getRoleCode().equals("Y01")) {
				roleCheck = true;
				break;
			}
		}
		if(roleCheck == true) {
			model.addAttribute("annual", list);
			return "annual/annual";
		}
		else {
			model.addAttribute("errorMsg", "권한이 없는 사용자입니다.");
			return "errorPage";
		}
	}
	
	// [지의] 총 연차 수정
	@PostMapping("/setting")
	public String updateAnnual(Annual a,Model model, HttpSession session) {
		
		int result = annualService.updateAnnual(a);
		if(result > 0) {
			List<Annual> list = annualService.selectAnnualAll();
			model.addAttribute("annual", list);
			
			int result2 = annualService.updateMemberAnnualCountByYear(a);
			if(result2 > 0) {
				model.addAttribute("alertMsg", "총 연차 수정 및 사원 연차 변경 완료되었습니다.");
			}
		}
		return "annual/annual";
	}
	
	// [지의] 유저 연차 조회 페이지 포워딩
	@GetMapping("/list")
	public String listAnnaul(Model model,@SessionAttribute("loginUserRole") List<UserRole> loginUserRole){
		boolean roleCheck = false;
		for(UserRole role:loginUserRole) {
			if(role.getRoleCode().equals("Y01")) {
				roleCheck = true;
				break;
			}
		}
		if(roleCheck == true) {
			return "annual/annual-user";
		}else {
			model.addAttribute("errorMsg", "권한이 없는 사용자입니다.");
			return "errorPage";
		}
	}
	
	// [지의] 유저 연차 조회
	@PostMapping("/list/{userNo}")
	public String selectUserAnnaul(@PathVariable("userNo") int userNo,
									@SessionAttribute("loginUserRole") List<UserRole> loginUserRole,
									Model model){

		Member m = annualService.selectUserAnnaul(userNo);
		List<Approval> apr = approvalService.selectUserApproval(userNo);

		model.addAttribute("m",m);
		model.addAttribute("apr", apr);
		
		return "annual/annual-user";
	}

	// [지의] 유저 연차 수정
	@ResponseBody
	@PostMapping("/updateUserAnnual")
	public String updateUserAnnual(@RequestParam("userNo") int userNo,
									@RequestParam("changeAnnual") int annualLeaveCount){
		
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("annualLeaveCount", annualLeaveCount);
		
		int result = annualService.updateUserAnnual(map);
		return new Gson().toJson(result);
	}
	
}
