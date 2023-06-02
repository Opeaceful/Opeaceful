package com.company.opeaceful.attendance.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.attendance.model.dao.AttendanceDao;
import com.company.opeaceful.attendance.model.vo.Attendance;

@Service
public class AttendanceServiceImpl implements AttendanceService {

	@Autowired
	private AttendanceDao attendanceDao;
	
	@Override
	public int insertWorkOn(int userNo) {
		return attendanceDao.insertWorkOn(userNo);
	}
	
	@Override
	public Attendance selectWorkOn(int userNo) {
		return attendanceDao.selectWorkOn(userNo);
	}
}
