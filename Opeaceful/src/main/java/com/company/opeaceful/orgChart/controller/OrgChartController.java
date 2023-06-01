package com.company.opeaceful.orgChart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.orgChart.model.service.OrgChartService;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Controller
@RequestMapping("/orgChart")
@SessionAttributes({"loginUser"})
public class OrgChartController {

	private OrgChartService orgchartService;
	
	@Autowired
	public OrgChartController(OrgChartService orgchartService) {
		this.orgchartService = orgchartService;
	}
	
//	quartz 사용할 때를 위해 작성만 함
//	public OrgChartController() {
//		
//	}
	
	@GetMapping("/")
	public String orgChart() {
		return "orgChartEnroll";
	}
	
	// 상위부서 추가
	@PostMapping("/insert/topDname")
	@ResponseBody
	public int insertTopDp(OrgChart orgChart) {
		
		int result = orgchartService.insertTopDp(orgChart);
		
//		System.out.println("변경전 : "+result);

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
		
		int result = orgchartService.insertDp(orgChart);
		
		System.out.println("변경전 : "+orgChart);

		return result;
	}
	
	// 하부서 이름 변경
	@PostMapping("/update/Dname")
	@ResponseBody
	public int updateDp(OrgChart orgChart) {
			
		int result = orgchartService.updateDp(orgChart);
			
		System.out.println("변경후 : "+orgChart);

		return result;
	}
	
	@RequestMapping("/orgChartView")
	public String selectOrgChart() {
		return "orgChart";
	}
}
