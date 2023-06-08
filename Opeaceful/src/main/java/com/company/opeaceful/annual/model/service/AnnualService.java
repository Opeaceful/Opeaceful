package com.company.opeaceful.annual.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.annual.model.vo.Annual;
import com.company.opeaceful.member.model.vo.Member;

public interface AnnualService {

	List<Annual> selectAnnualAll();

	int updateAnnual(Annual a);

	Member selectUserAnnaul(int userNo);

	int updateUserAnnual(Map<String, Object> map);

}
