package com.company.opeaceful.attendance.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.attendance.model.vo.Attendance;

@Repository
public class AttendanceDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertWorkOn(int userNo) {
		return sqlSession.insert("attendanceMapper.insertWorkOn", userNo);
	}

	public Attendance selectWorkOn(int userNo) {
		return sqlSession.selectOne("attendanceMapper.selectWorkOn", userNo);
	}

	public int updateWorkOff(int userNo) {
		return sqlSession.update("attendanceMapper.updateWorkOff", userNo);
	}

	public int updateOnlineStatus(int userNo) {
		return sqlSession.update("memberMapper.updateOnlineStatus", userNo);
	}

	public int updateOfflineStatus(int userNo) {
		return sqlSession.update("memberMapper.updateOfflineStatus", userNo);
	}
}
