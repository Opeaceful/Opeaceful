package com.company.opeaceful.salary.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	public List<Salary> employeeAllSalary(Map<String, Object> selectYMT) {
		return sqlSession.selectList("salaryMapper.employeeAllSalary",selectYMT);
	}


}
