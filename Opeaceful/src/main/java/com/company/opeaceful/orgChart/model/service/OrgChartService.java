package com.company.opeaceful.orgChart.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

public interface OrgChartService {

	// 상위부서 추가
	int insertTopDp(OrgChart orgChart);
	
	// 부서명 변경
	int updateTopDp(OrgChart orgChart);
	
	// 상위부서 삭제
	int deleteDeptCode(Map<String, Object> map);
	
	// 하위부서 추가
	int insertDp(OrgChart orgChart);
	
	// 하위부서 사원 조회
	List<UserDepatment> selectMember(int deptCode);
	
	// 직급추가
	int insertPname(OrgChart orgChart);
	
	// 직급명 변경
	int updatePname(OrgChart orgChart);
	
	// 부서조회
	int selectDept(OrgChart orgChart);
}
