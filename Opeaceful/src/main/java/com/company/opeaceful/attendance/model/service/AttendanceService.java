package com.company.opeaceful.attendance.model.service;

import com.company.opeaceful.attendance.model.vo.Attendance;

public interface AttendanceService {

	int insertWorkOn(int userNo);

	Attendance selectWorkOn(int userNo);

	int updateWorkOff(int userNo);

	int updateOnlineStatus(int userNo);

	int updateOfflineStatus(int userNo);

}
