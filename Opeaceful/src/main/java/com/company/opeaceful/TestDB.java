package com.company.opeaceful;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestDB {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public void selectTest(){
		int num = sqlSession.selectOne("test.testselect");
		System.out.println(num);
		
	};
}
