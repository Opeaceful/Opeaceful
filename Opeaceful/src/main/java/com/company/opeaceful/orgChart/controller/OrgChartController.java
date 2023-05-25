package com.company.opeaceful.orgChart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.orgChart.model.service.OrgChartService;

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
	
	@RequestMapping("/orgChartEnroll")
	public String insertOrgChart() {
		return "orgChartEnroll";
	}
}
