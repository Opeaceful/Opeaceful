package com.company.opeaceful.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
	private SqlSessionTemplate sqlSession; // root-context.xml에서 생성해둠
	// connection관리를 service에서 할필요 x -> 자동으로 관리해주기 때문
}
