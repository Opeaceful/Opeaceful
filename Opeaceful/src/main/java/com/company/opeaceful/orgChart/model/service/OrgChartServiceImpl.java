package com.company.opeaceful.orgChart.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.orgChart.model.dao.OrgChartDao;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Service
public class OrgChartServiceImpl implements OrgChartService {

	@Autowired
	private OrgChartDao orgChartDao;
	
	// 상위부서 추가
	@Override
	public int insertTopDp(OrgChart orgChart) {
		return orgChartDao.insertTopDp(orgChart);
	}
	
	// 부서명 변경
	@Override
	public int updateTopDp(OrgChart orgChart) {
		return orgChartDao.updateTopDp(orgChart);
	}
	
	// 상위부서 삭제
	@Override
	public int deleteDeptCode(Map<String, Object> map) {
		return orgChartDao.deleteDeptCode(map);
	}
	
	// 하위부서 추가
	@Override
	public int insertDp(OrgChart orgChart) {
		return orgChartDao.insertDp(orgChart);
	}
	
	// 하위부서 사원 조회
	@Override
	public List<UserDepatment> selectMember(int deptCode) {
		return orgChartDao.selectMember(deptCode);
	}
	
	// 직급 추가
	@Override
	public int insertPname(OrgChart orgChart) {
		return orgChartDao.insertPname(orgChart);
	}
	
	// 직급명 변경
	@Override
	public int updatePname(OrgChart orgChart) {
		return orgChartDao.updatePname(orgChart);
	}
	
	// 부서조회
	@Override
	public int selectDept(OrgChart orgChart) {
		return orgChartDao.selectDept(orgChart);
	}
}
