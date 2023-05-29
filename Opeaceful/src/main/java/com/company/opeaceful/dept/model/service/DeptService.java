package com.company.opeaceful.dept.model.service;

import java.util.List;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;

public interface DeptService {

	List<Department> selectDeptList();

	List<Position> selectPosition();

}
