package com.company.opeaceful.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/approval")
public class ApprovalMainController {

	@GetMapping("/approvalForm")
	public String approvalForm(){
		System.out.println("approvalForm");
		return "approval/approvalForm";
	}
	@GetMapping("/allApproval")
	public String allApproval(){
		System.out.println("allApproval");
		return "approval/allApproval";
	}
	@GetMapping("/myApproval")
	public String myApproval(){
		System.out.println("myApproval");
		return "approval/myApproval";
	}
	
}
