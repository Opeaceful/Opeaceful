package com.company.opeaceful.orgChart.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	// 상위부서명 변경
	@Override
	public int updateTopDp(OrgChart orgChart) {
		return orgChartDao.updateTopDp(orgChart);
	}
	
	// 하위부서 추가
	@Override
	public int insertDp(OrgChart orgChart) {
		return orgChartDao.insertDp(orgChart);
	}
	
	// 하위부서명 변경
	@Override
	public int updateDp(OrgChart orgChart) {
		return orgChartDao.updateDp(orgChart);
	}
	
	// 상위부서 추가
	@Override
	public int insertPname(OrgChart orgChart) {
		return orgChartDao.insertPname(orgChart);
	}
}
