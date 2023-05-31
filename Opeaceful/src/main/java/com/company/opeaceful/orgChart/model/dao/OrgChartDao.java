package com.company.opeaceful.orgChart.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Repository
public class OrgChartDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertDepartment(OrgChart orgChart) {
		
		sqlSession.insert("orgChartMapper.insertDepartment", orgChart);
		
		return orgChart.getDeptCode();
	}
	
	public int updateDepartment(OrgChart orgChart) {
		
		sqlSession.insert("orgChartMapper.updateDepartment", orgChart);
		
		return orgChart.getDeptCode();
	}
}
