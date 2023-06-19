package com.company.opeaceful.annual.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.annual.model.vo.Annual;
import com.company.opeaceful.member.model.vo.Member;

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

	public Member selectUserAnnaul(int userNo) {
		return sqlSession.selectOne("memberMapper.selectUserAnnaul",userNo);
	}

	public int updateUserAnnual(Map<String, Object> map) {
		return sqlSession.update("memberMapper.updateUserAnnual",map);
	}

	public int updateMemberAnnualCountByYear(Annual a) {
		return sqlSession.update("memberMapper.updateMemberAnnualCountByYear",a);
	}
	
}

