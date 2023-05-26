package com.company.opeaceful.orgChart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@GetMapping("/insert/topDname")
	public String insertDepartment(OrgChart orgChart) {
		
//		int result = orgchartService.insertDepartment(orgChart);
//		System.out.println(result);
		return "orgChartEnroll";
	}
	
	@RequestMapping("/orgChartView")
	public String selectOrgChart() {
		return "orgChart";
	}
}
