package com.company.opeaceful.salary.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.salary.model.vo.Salary;

public interface SalaryService {

	List<Salary> employeeSalary(Map<String, Object> selectYM);

	Salary salaryOne(int id);

	List<Salary> employeeAllSalary(Map<String, Object> selectYMT);

}
