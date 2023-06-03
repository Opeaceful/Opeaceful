package com.company.opeaceful.approval.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApprovalDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
}
