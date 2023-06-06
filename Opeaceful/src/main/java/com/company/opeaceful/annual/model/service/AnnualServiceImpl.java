package com.company.opeaceful.annual.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.annual.model.dao.AnnualDao;
import com.company.opeaceful.annual.model.vo.Annual;

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
}
