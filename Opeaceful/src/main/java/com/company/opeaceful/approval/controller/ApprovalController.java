package com.company.opeaceful.approval.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalLine;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	
	private ApprovalService aprService;

	@Autowired
	public ApprovalController(ApprovalService aprService) {
		this.aprService = aprService;
	}
	

	@GetMapping("/allApproval")
	public String allApproval(){
		return "approval/allApproval";
	}
	@GetMapping("/myApproval")
	public String myApproval(){
		return "approval/myApproval";
	}
	
	
	// ajax용 즐겨찾기 저장
	@ResponseBody
	@PostMapping("/insertFavor")
	public int insertFavor(@RequestParam(value = "lineList", required = false) List<ApprovalLine> lineList,
							String title
							) {
		
		System.out.println(lineList);
		
		System.out.println(title);
		
		ApprovalFavor favor = new ApprovalFavor();
		favor.setTitle(title);
		favor.setUserNo(1);
		
		int result = aprService.insertFavor(favor, lineList);

		return result;
	}
	
	
}
