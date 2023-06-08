package com.company.opeaceful.salary.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.salary.model.service.SalaryService;
import com.company.opeaceful.salary.model.vo.Salary;
import com.google.gson.Gson;

@Controller
@RequestMapping("/salary")
@SessionAttributes({"loginUser"})
public class SalaryController {
	
	private SalaryService salaryService;
	
	@Autowired
	public SalaryController(SalaryService salaryService) {
		this.salaryService = salaryService;
	}
	
	//[지영]
	//employeeSalary로 이동 + 데이터 검색으로 세팅해주기
	@GetMapping("/employee")
	public String employeeSalary(@ModelAttribute ("loginUser") Member loginUser, 
			Model model,
			@RequestParam(value= "month", required = false) Integer month,
			@RequestParam(value= "year",required = false) Integer year
			) {
		
		//검색 select용 map
		Map<String, Object> selectYM = new HashMap<>();	
		
		selectYM.put("month", month);
		selectYM.put("year", year);
		selectYM.put("userNo", loginUser.getUserNo());
		
		List<Salary> LSalry = salaryService.employeeSalary(selectYM);
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("LSalry",LSalry);
		
		return "salary/employeeSalary";
		
	}
	
	
	@ResponseBody
	@PostMapping("/salaryOne")
	public String salaryOne(@RequestParam(value="id", required = false) int id) {
		
		Salary S = salaryService.salaryOne(id);
			
		return new Gson().toJson(S);		
			
	}
	
	
	//[지영]
	//employeeAllSalary로 이동 + 데이터 검색으로 세팅해주기
	@GetMapping("/AllSalary")
	public String employeeAllSalary(
//	@ModelAttribute ("loginUser") Member loginUser, 
			Model model,
			@RequestParam(value= "month", required = false) Integer month,
			@RequestParam(value= "year",required = false) Integer year,
			@RequestParam(value= "team",required = false) String team,
			@RequestParam(value="cpage", required = false, defaultValue = "1") int currentPage
			) {
		
		//검색 select용 map
		Map<String, Object> selectYMT = new HashMap<>();	
		
		selectYMT.put("month", month);
		selectYMT.put("year", year);
		selectYMT.put("team", team);
		
		System.out.println(team+"여기!!!!!!!!!!!!!");
		
		List<Salary> LSalry = salaryService.employeeAllSalary(currentPage,selectYMT);
		List<String> dpNames = salaryService.salaryList();
	
		
		//model.addAttribute("loginUser", loginUser);
		model.addAttribute("LSalry",LSalry);
		model.addAttribute("dpNames",dpNames);
		model.addAttribute("map",selectYMT);
	
		
		return "salary/employeeAllSalary";
		
	}

	

}
