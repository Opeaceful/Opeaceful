package com.company.opeaceful.salary.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.salary.model.vo.Salary;

@Repository
public class SalaryDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Salary> employeeSalary(Map<String, Object> selectYM) {
		return sqlSession.selectList("salaryMapper.employeeSalary",selectYM);
	}

	public Salary salaryOne(int id) {
		return sqlSession.selectOne("salaryMapper.salaryOne",id);
	}

	public List<Salary> employeeAllSalary(PageInfo pi,Map<String, Object> selectYMT) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getSettingLimit();
		int limit = pi.getSettingLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("salaryMapper.employeeAllSalary",selectYMT,rowBounds);
	}
	
	public int employeeAllSalaryCount(Map<String, Object> selectYMT) {
		return sqlSession.selectOne("salaryMapper.employeeAllSalaryCount",selectYMT);
	}

	public List<String> salaryList() {
		return sqlSession.selectList("salaryMapper.salaryList");
	}

	


}
