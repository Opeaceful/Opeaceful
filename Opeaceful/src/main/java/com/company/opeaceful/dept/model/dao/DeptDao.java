package com.company.opeaceful.dept.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;

@Repository
public class DeptDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Department> selectDeptList() {
		return sqlSession.selectList("deptMapper.selectDeptList");
	}

	public List<Position> selectPosition() {
		return sqlSession.selectList("deptMapper.selectPosition");
	}

}
