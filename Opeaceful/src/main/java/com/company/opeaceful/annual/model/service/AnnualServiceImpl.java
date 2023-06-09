package com.company.opeaceful.annual.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.annual.model.dao.AnnualDao;
import com.company.opeaceful.annual.model.vo.Annual;
import com.company.opeaceful.member.model.vo.Member;

@Service
public class AnnualServiceImpl implements AnnualService {

	@Autowired
	private AnnualDao annualDao;
	
	@Override
	public List<Annual> selectAnnualAll(){
		return annualDao.selectAnnualAll();
	}
	
	@Override
	public int updateAnnual(Annual a) {
		return annualDao.updateAnnual(a);
	}
	
	@Override
	public Member selectUserAnnaul(int userNo) {
		return annualDao.selectUserAnnaul(userNo);
	}
	
	@Override
	public int updateUserAnnual(Map<String, Object> map) {
		return annualDao.updateUserAnnual(map);
	}
}
