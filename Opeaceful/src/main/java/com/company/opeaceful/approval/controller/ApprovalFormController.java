package com.company.opeaceful.approval.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.approval.model.service.ApprovalServiceImpl;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.google.gson.Gson;

@Controller
@RequestMapping("/approval/approvalForm")
//(승은)
public class ApprovalFormController {

	private ApprovalServiceImpl aprService;

	@Autowired
	public ApprovalFormController(ApprovalServiceImpl aprService) {
		this.aprService = aprService;
	}

	@GetMapping("")
	public String approvalForm(Model model) {
		ArrayList<ApprovalForm> formList = aprService.selectFormList();

		model.addAttribute(formList);

		return "approval/approvalForm";
	}

	@PostMapping("/selectFormList")
	public String selectFormList() {
		ArrayList<ApprovalForm> formList = aprService.selectFormList();

		return new Gson().toJson(formList);
	}

	@PostMapping("/selectForm")
	public String selectForm(int formNo) {
		ApprovalForm form= aprService.selectForm(formNo);

		return new Gson().toJson(form);
	}

	@PostMapping("/insertForm")
	public int insertForm(ApprovalForm form, 
							@RequestParam(value="images", required = false) List<MultipartFile> imgList) {
		int result = aprService.insertForm(form);

		return result;
	}

	@PostMapping("/updateForm")
	public String updateForm(ApprovalForm form, @RequestParam(value="images", required = false) List<MultipartFile> imgList) {
		int result = aprService.updateForm(form);

		return new Gson().toJson(form);
	}
}
