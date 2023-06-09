package com.company.opeaceful.attendance.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.attendance.model.vo.Attendance;

public interface AttendanceService {

	int insertWorkOn(int userNo);

	Attendance selectWorkOn(int userNo);

	int updateWorkOff(int userNo);

	int updateOnlineStatus(int userNo);

	int updateOfflineStatus(int userNo);
	
	List<Attendance> selectUserAttendance(Map<String, Object> selectUser, int currentPage);

	List<Attendance> selectAllUserAttendance(Map<String, Object> selectAllUser, int currentPage);
	
}
