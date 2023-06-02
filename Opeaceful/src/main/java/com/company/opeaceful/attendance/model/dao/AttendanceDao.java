package com.company.opeaceful.attendance.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AttendanceDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertWorkOn(int userNo) {
		return sqlSession.insert("attendanceMapper.insertWorkOn", userNo);
	}
}
