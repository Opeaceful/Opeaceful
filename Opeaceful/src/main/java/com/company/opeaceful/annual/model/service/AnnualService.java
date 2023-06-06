package com.company.opeaceful.annual.model.service;

import java.util.List;

import com.company.opeaceful.annual.model.vo.Annual;

public interface AnnualService {

	List<Annual> selectAnnualAll();

	int updateAnnual(Annual a);

}
