package com.company.opeaceful.attendance.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.attendance.model.vo.Attendance;
import com.company.opeaceful.commom.model.vo.PageInfo;

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
	
	public int selectAttendanceListCount(Map<String, Object> selectUser) {
		return sqlSession.selectOne("attendanceMapper.selectAttendanceListCount", selectUser);
	}
	
	public int selectAttendanceAllListCount(Map<String, Object> selectAllUser) {
		return sqlSession.selectOne("attendanceMapper.selectAttendanceAllListCount", selectAllUser);
	}
	
	public List<Attendance> selectUserAttendance(int listCount, Map<String, Object> selectUser) {
		
		return sqlSession.selectList("attendanceMapper.selectUserAttendance",selectUser);
	}
	
	public List<Attendance> selectAllUserAttendance(Map<String, Object> selectAllUser, int listCount) {
		
		return sqlSession.selectList("attendanceMapper.selectAllUserAttendance",selectAllUser);
	}
	
}
