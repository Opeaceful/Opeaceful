package com.company.opeaceful.orgChart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.dept.model.service.DeptService;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.orgChart.model.service.OrgChartService;
import com.company.opeaceful.orgChart.model.vo.OrgChart;
import com.google.gson.Gson;

@Controller
@RequestMapping("/orgChart")
@SessionAttributes({"loginUser"})
public class OrgChartController {

	private OrgChartService orgchartService;
	private DeptService deptService;
	
	@Autowired
	public OrgChartController(OrgChartService orgchartService, DeptService deptService) {
		this.orgchartService = orgchartService;
		this.deptService = deptService;
	}
	
//	quartz 사용할 때를 위해 작성만 함
//	public OrgChartController() {
//		
//	}
	
	@GetMapping("/")
	public String orgChart() {
		return "orgChartEnroll";
	}
	
	@GetMapping("/view")
	public String orgChartView() {
		return "orgChartView";
	}
	
	// 부서조회
	@PostMapping("/selectDept")
	@ResponseBody
	public String selectDept() {
		List<Department> dList = deptService.selectDeptList();
			
		System.out.println(dList);
		return new Gson().toJson(dList);
	}
	
	// 상위부서 추가
	@PostMapping("/insert/topDname")
	@ResponseBody
	public int insertTopDp(OrgChart orgChart) {
		
		int result = orgchartService.insertTopDp(orgChart);
		
//		System.out.println("생성 : "+result);

		return result;
	}
	
	// 상위부서 이름 변경
	@PostMapping("/update/topDname")
	@ResponseBody
	public int updateTopDp(OrgChart orgChart) {
		
		int result = orgchartService.updateTopDp(orgChart);
		
//		System.out.println("변경후 : "+result);

		return result;
	}
	
	// 하위부서 추가
	@PostMapping("/insert/Dname")
	@ResponseBody
	public int insertDp(OrgChart orgChart) {
//		System.out.println("첫생성 : "+orgChart);
		
		int result = orgchartService.insertDp(orgChart);
		
//		System.out.println("실행후생성 : "+result);

		return result;
	}
	
	// 하위부서 이름 변경
	@PostMapping("/update/Dname")
	@ResponseBody
	public int updateDp(OrgChart orgChart) {
			
		int result = orgchartService.updateDp(orgChart);
			
//		System.out.println("변경후 : "+orgChart);

		return result;
	}
	
	// 하위부서 사원 조회
	@PostMapping("/selectAll")
	@ResponseBody
	public String selectMember(int topDeptCode) {
		System.out.println(topDeptCode);
		List<UserDepatment> udList = orgchartService.selectMember(topDeptCode);
		
		System.out.println("udList : "+udList);
		return new Gson().toJson(udList);
		
	}
	
	// 직급 조회
	@ResponseBody
	@PostMapping("/selectPosition")
	public String selectPosition() {
			
		List<Position> dList = deptService.selectPosition();
			
		return new Gson().toJson(dList);
	}
	
	// 직급 추가
	@PostMapping("/insert/Pname")
	@ResponseBody
	public int insertPname(OrgChart orgChart) {
			
		int result = orgchartService.insertPname(orgChart);
			
		System.out.println("생성 : "+result+", "+orgChart);

		return result;
	}
	
	// 직급명 변경
	@PostMapping("/update/Pname")
	@ResponseBody
	public int updatePname(OrgChart orgChart) {
				
		int result = orgchartService.updatePname(orgChart);
				
		System.out.println("생성 : "+result+", "+orgChart);

		return result;
	}
	
	
//	@PostMapping("/orgChartView")
//	public String selectOrgChart() {
//		return "orgChartView";
//	}
}
