package com.company.opeaceful.orgChart.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Repository
public class OrgChartDao {

	private SqlSessionTemplate sqlSession;
	
	public int insertDepartment(OrgChart dName) {
		return sqlSession.insert("orgChart-mapper.insertDepartment", dName);
	}
}
