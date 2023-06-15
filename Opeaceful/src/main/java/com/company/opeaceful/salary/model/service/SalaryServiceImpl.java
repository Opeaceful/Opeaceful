package com.company.opeaceful.salary.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.salary.model.dao.SalaryDao;
import com.company.opeaceful.salary.model.vo.Salary;

@Service
public class SalaryServiceImpl implements SalaryService{
	
	@Autowired
	private SalaryDao salaryDao;
	
	@Autowired
	private Pagination pagination;
	
	@Override
	public List<Salary> employeeSalary(Map<String, Object> selectYM){
		return salaryDao.employeeSalary(selectYM); 
	}
	
	@Override
	public Salary salaryOne(int id) {
		return salaryDao.salaryOne(id);
	}
	
	@Override
	public List<Salary> employeeAllSalary(int currentPage, Map<String, Object> selectYMT){
		
		int listCount = salaryDao.employeeAllSalaryCount(selectYMT);
		int pageLimit = 5;
		int settingLimit = 10;
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, settingLimit);
		
		selectYMT.put("pi", pi);
		
		return salaryDao.employeeAllSalary(pi,selectYMT); 
	}
	
	@Override
	public List<String> salaryList() {
		return salaryDao.salaryList(); 
	}

	@Override
	public int salaryDelete(int num) {
		return salaryDao.salaryDelete(num);
	}
	
	@Override
	public int salaryUpdate(Salary salary) {
		return salaryDao.salaryUpdate(salary);
	}
	
	@Override
	public List<Member> selectSalayMember(int[] intArray){
		return salaryDao.selectSalayMember(intArray);
	}
	
	@Override
	public int insertSalary(List<Salary> userList){
		return salaryDao.insertSalary(userList);
	}
	
	@Override
	public Salary selectUserCope(Map<String, Object> selectYMT){
		return salaryDao.selectUserCope(selectYMT);
	}
	
	@Override
	public List<Integer> deleteSalayselect(){
		return salaryDao.deleteSalayselect();
	}
	
	@Override
	public int deleteSalay(List<Integer> dslist) {
		return salaryDao.deleteSalay(dslist);
	}
}
