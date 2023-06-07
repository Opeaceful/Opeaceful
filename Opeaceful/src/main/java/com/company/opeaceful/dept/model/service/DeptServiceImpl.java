package com.company.opeaceful.dept.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.dept.model.dao.DeptDao;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;

@Service
public class DeptServiceImpl implements DeptService {

	@Autowired
	private DeptDao dao;
	
	@Override
	public List<Department> selectDeptList(){
		return dao.selectDeptList();
	}
	
	@Override
	public List<Position> selectPosition(){
		return dao.selectPosition();
	}
	
}
