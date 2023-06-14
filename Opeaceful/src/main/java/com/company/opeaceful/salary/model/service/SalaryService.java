package com.company.opeaceful.salary.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.salary.model.vo.Salary;

public interface SalaryService {

	List<Salary> employeeSalary(Map<String, Object> selectYM);

	Salary salaryOne(int id);

	List<Salary> employeeAllSalary(int currentPage, Map<String, Object> selectYMT);

	List<String> salaryList();

	int salaryDelete(int num);

	int salaryUpdate(Salary salary);

	List<Member> selectSalayMember(int[] intArray);
	
	int insertSalary(List<Salary> userList);

	Salary selectUserCope(Map<String, Object> selectYMT);

	

}
