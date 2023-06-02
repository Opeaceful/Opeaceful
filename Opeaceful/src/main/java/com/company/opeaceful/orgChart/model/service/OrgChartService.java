package com.company.opeaceful.orgChart.model.service;

import com.company.opeaceful.orgChart.model.vo.OrgChart;

public interface OrgChartService {

	// 상위부서 추가
	int insertTopDp(OrgChart orgChart);
	
	// 상위부서명 변경
	int updateTopDp(OrgChart orgChart);
	
	// 하위부서 추가
	int insertDp(OrgChart orgChart);
	
	// 하위부서명 변경
	int updateDp(OrgChart orgChart);
	
	// 직급추가
	int insertPname(OrgChart orgChart);
}
