package com.company.opeaceful.orgChart.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Repository
public class OrgChartDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 상위부서 추가
	public int insertTopDp(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertTopDp", orgChart);
		
		// 부서추가 성공 시 selectKey 태그를 이용해서 세팅한 DeptCode값을 orgChart 객체 안에 담아서 반환시켜줌
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		return result;
	}
	
	// 상위부서명 변경
	public int updateTopDp(OrgChart orgChart) {
		
		int result =  sqlSession.insert("orgChartMapper.updateTopDp", orgChart);
		
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		
		return result;
	}
	
	// 하위부서 추가
	public int insertDp(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertDp", orgChart);
		
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		return result;
	}
	
	// 하위부서명 변경
	public int updateDp(OrgChart orgChart) {
		
		int result =  sqlSession.insert("orgChartMapper.updateDp", orgChart);
		
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		
		return result;
	}
	
	// 직급추가
	public int insertPname(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertPname", orgChart);
		
		return result;
	}
}
