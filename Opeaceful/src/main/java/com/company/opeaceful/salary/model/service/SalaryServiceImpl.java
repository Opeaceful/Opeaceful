package com.company.opeaceful.salary.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.salary.model.dao.SalaryDao;
import com.company.opeaceful.salary.model.vo.Salary;

@Service
public class SalaryServiceImpl implements SalaryService{
	
	@Autowired
	private SalaryDao salaryDao;
	
	@Override
	public List<Salary> employeeSalary(Map<String, Object> selectYM){
		return salaryDao.employeeSalary(selectYM); 
	}
	
	@Override
	public Salary salaryOne(int id) {
		return salaryDao.salaryOne(id);
	}
	
	@Override
	public List<Salary> employeeAllSalary(Map<String, Object> selectYMT){
		return salaryDao.employeeAllSalary(selectYMT); 
	}

}
