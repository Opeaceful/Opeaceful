package com.company.opeaceful.annual.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.company.opeaceful.annual.model.service.AnnualService;
import com.company.opeaceful.annual.model.vo.Annual;
import com.company.opeaceful.board.controller.BoardController;

@Controller
@RequestMapping("/annual")
public class AnnualController {

	@Autowired
	private AnnualService annualService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// [지의] 총 연차테이블 조회
	@GetMapping("/setting")
	public String selectAnnualAll(Model model){
		
		List<Annual> list = annualService.selectAnnualAll();
		
		logger.info(" "+list);
		
		model.addAttribute("annual", list);
		
		return "annual/annual";
	}
	
	// [지의] 총 연차 수정
	@PostMapping("/setting")
	public String updateAnnual(Annual a) {
		
		//logger.info(" "+year);
		logger.info(" "+a);
		int result = annualService.updateAnnual(a);
		
//		if(result > 0) {
//			annualService.selectAnnualAll();
//		}
		
		return "redirect:/annual/annual";
	}
	
	// [지의] 유저 연차 조회 
	@GetMapping("/list")
	public String listAnnaul(){
		return "annual/annual-user";
	}
	
	
}
