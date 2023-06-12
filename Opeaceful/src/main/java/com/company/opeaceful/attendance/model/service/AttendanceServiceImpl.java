package com.company.opeaceful.attendance.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.attendance.model.dao.AttendanceDao;
import com.company.opeaceful.attendance.model.vo.Attendance;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;

@Service
public class AttendanceServiceImpl implements AttendanceService {

	@Autowired
	private AttendanceDao attendanceDao;
	
	@Autowired
	private Pagination pagination;
	
	@Override
	public int insertWorkOn(int userNo) {
		return attendanceDao.insertWorkOn(userNo);
	}
	
	@Override
	public Attendance selectWorkOn(int userNo) {
		return attendanceDao.selectWorkOn(userNo);
	}
	
	@Override
	public int updateWorkOff(int userNo) {
		return attendanceDao.updateWorkOff(userNo);
	}
	
	@Override
	public int updateOnlineStatus(int userNo) {
		return attendanceDao.updateOnlineStatus(userNo);
	}
	
	@Override
	public int updateOfflineStatus(int userNo) {
		return attendanceDao.updateOfflineStatus(userNo);
	}
	
	@Override
	public void selectUserAttendance(Map<String, Object> selectUser){
		
		int listCount = attendanceDao.selectAttendanceListCount(selectUser);
		int pageLimit = 10;
		int settingLimit =10;
		
		PageInfo pi = pagination.getPageInfo(listCount, (int)(selectUser.get("currentPage")), pageLimit, settingLimit);
		
		List<Attendance> list = attendanceDao.selectUserAttendance(pi, selectUser); 
		
		selectUser.put("pi", pi);
		selectUser.put("list", list);
		
	}
}
