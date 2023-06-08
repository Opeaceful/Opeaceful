package com.company.opeaceful.annual.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.annual.model.vo.Annual;

@Repository
public class AnnualDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Annual> selectAnnualAll() {
		return sqlSession.selectList("annualMapper.selectAnnualAll");
	}

	public int updateAnnual(Annual a) {
		return sqlSession.update("annualMapper.updateAnnual", a);
	}
}

