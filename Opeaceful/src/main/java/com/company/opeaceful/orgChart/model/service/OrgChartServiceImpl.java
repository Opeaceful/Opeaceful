package com.company.opeaceful.orgChart.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.orgChart.model.dao.OrgChartDao;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Service
public class OrgChartServiceImpl implements OrgChartService {

	@Autowired
	private OrgChartDao orgChartDao;
	
	@Override
	public int insertDepartment(OrgChart orgChart) {
		return orgChartDao.insertDepartment(orgChart);
	}
	
	@Override
	public int updateDepartment(OrgChart orgChart) {
		return orgChartDao.updateDepartment(orgChart);
	}
}
