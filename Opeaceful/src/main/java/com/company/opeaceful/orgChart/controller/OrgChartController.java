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
	
	@PostMapping("/insert/topDname")
	@ResponseBody
	public int insertDepartment(OrgChart orgChart) {
		
		int result = orgchartService.insertDepartment(orgChart);
		
		System.out.println(result);

		return result;
	}
	
	@PostMapping("/update/topDname")
	@ResponseBody
	public int updateDepartment(OrgChart orgChart) {
		
//		int result = orgchartService.insertDepartment(orgChart);
		
		System.out.println(orgChart);

		return 0;
	}
	
	@RequestMapping("/orgChartView")
	public String selectOrgChart() {
		return "orgChart";
	}
}
