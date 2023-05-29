package com.company.opeaceful.orgChart.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Repository
public class OrgChartDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertDepartment(OrgChart dName) {
		
		return sqlSession.insert("orgChartMapper.insertDepartment", dName);
	}
}
