package com.company.opeaceful.orgChart.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.UserDepartment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

public interface OrgChartService {

	// 전체부서 조회
	List<Department> selectAllDeptList();
	
	// 상위부서 추가
	int insertTopDp(OrgChart orgChart);
	
	// 부서명 변경
	int updateTopDp(Map<String, Object> map);
	
	// 부서 삭제
	int deleteTopDeptCode(int deptCode);
	
	// 하위부서 추가
	int insertDp(OrgChart orgChart);
	
	// 하위부서 사원 조회
	List<UserDepartment> selectMember(int deptCode);
	
	// 직급추가
	int insertPname(OrgChart orgChart);
	
	// 직급명 변경
	int updatePname(OrgChart orgChart);
	
	// 부서조회
	int selectDept(OrgChart orgChart);
	
	// 직급조회
	int selectPosition(OrgChart orgChart);
	
	// 직급삭제
	int deletePosition(int pCode);
	
	// 조직도 조회
	List<OrgChart> selectTopDeptList(int deptCode); // 상위부서 조회
	List<OrgChart> selectTopDeptUser(int deptCode); // 하위부서 조회
	
	// 조직도 명함
	List<Member> businessCard(int userNo);
	
	// 인사발령 사원 조회
	List<OrgChart> selectPersonnel(Map<String, Object> map);
	
	// 인사발령
	int updatePersonnel(Map<String, Object> paramMap);
}
