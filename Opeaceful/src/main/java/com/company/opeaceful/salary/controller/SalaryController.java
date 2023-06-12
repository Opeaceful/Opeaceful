package com.company.opeaceful.salary.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.company.opeaceful.role.model.vo.UserRole;
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
			@RequestParam(value="cpage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="no", required = false) int[] no
			) {
		
		//검색 select용 map
		Map<String, Object> selectYMT = new HashMap<>();	
	
		selectYMT.put("month", month);
		selectYMT.put("year", year);
		selectYMT.put("team", team);
		selectYMT.put("no", no);
		
	
		List<Salary> LSalry = salaryService.employeeAllSalary(currentPage,selectYMT);
		List<String> dpNames = salaryService.salaryList();
	
		
		//model.addAttribute("loginUser", loginUser);
		model.addAttribute("LSalry",LSalry);
		model.addAttribute("dpNames",dpNames);
		model.addAttribute("map",selectYMT);	
		
		return "salary/employeeAllSalary";
		
	}

	//[지영]
	// 급여 데이터 삭제
	@ResponseBody
	@PostMapping("/salaryDelete")
	public String salaryDelete(
			@RequestParam(value="num", required = false, defaultValue = "0") int num,
			HttpSession session
			){
	
		int result = 0;
		
		result = salaryService.salaryDelete(num);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "성공적으로 삭제되었습니다");
		}else {
			session.setAttribute("alertMsg", "실패하였습니다. 지속 오류시 담당자에게 문의하세요");
		}
		
		
		
		return new Gson().toJson(result);
			
	}
	
	//[지영]
	// 급여 업데이트
	@ResponseBody
	@PostMapping("/salaryUpdate")
	public String salaryUpdate(
			Salary salary,
			HttpSession session
			){
	
		int result = 0;
		
		result = salaryService.salaryUpdate(salary);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "성공적으로 수정되었습니다.");
		}else {
			session.setAttribute("alertMsg", "실패하였습니다. 지속 오류시 담당자에게 문의하세요");
		}
		
		return new Gson().toJson(result);
			
	}
	
	//[지영]
	// 급여 생성
	@ResponseBody
	@PostMapping("/insertSalary")
	public String insertSalary(
			@RequestParam(value= "year", required = false) Integer year,
			@RequestParam(value= "month", required = false) Integer month,
			@RequestParam(value="checkMemberNo", required = false) String checkMemberNo,
			@RequestParam(value="PaymentDate", required = false) String PaymentDate,
			@RequestParam(value="UserCope", required = false) Boolean UserCope,
			HttpSession session
			){
	
		int[] intArray = new Gson().fromJson(checkMemberNo, int[].class);
		int result = 0;
		
		
		//insert List
		List<Salary> userList = new ArrayList<>();
		
		if(intArray != null && intArray.length > 0) {
			List<Member> ml = salaryService.selectSalayMember(intArray);
			
		    for (Member m : ml) {
		    	
		    	Salary salary = new Salary();
		    	
		    	if(UserCope) { //전달 복사시
		    		
		    		Map<String, Object> selectYMT = new HashMap<>();	
		    		
		    		selectYMT.put("month", month);
		    		selectYMT.put("year", year);
		    		selectYMT.put("no", m.getUserNo());
		    		
		    		
		    		Salary ss = salaryService.selectUserCope(selectYMT);
		    		
		    		if(ss != null) {
		    			salary = ss;
		    		}
		    		 
		    		
		    	}
		    	
		        salary.setUserNo(m.getUserNo());
		        salary.setDeptName(m.getDName());
		        salary.setPName(m.getPName());
		        salary.setYearReported(year);
		        salary.setMonReported(month);
		        salary.setSPaymentDate(PaymentDate);

		        userList.add(salary);
		   }
			
		}
		
		result = salaryService.insertSalary(userList);
		
		if(result > 0) {
			session.setAttribute("alertMsg", result+"건의 급여가 성공적으로 추가되었습니다.");
		}else {
			session.setAttribute("alertMsg", "실패하였습니다. 지속 오류시 담당자에게 문의하세요");
		}
		
		return new Gson().toJson(result);
			
	}

}
