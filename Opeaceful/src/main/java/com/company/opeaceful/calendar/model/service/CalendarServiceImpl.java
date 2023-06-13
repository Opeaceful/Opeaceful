package com.company.opeaceful.calendar.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.calendar.model.dao.CalendarDao;
import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.calendar.model.vo.CalendarMemo;

@Service
public class CalendarServiceImpl implements CalendarService{
	
	@Autowired
	private CalendarDao calendarDao;
	
	@Override
	public ArrayList<Calendar> selectMyCalendarList(int userNo){
		return calendarDao.selectMyCalendarList(userNo);
	}
	
	@Override
	public ArrayList<Calendar> selectTeamCalendarList(int userNo){
		return calendarDao.selectTeamCalendarList(userNo);
	}
	
	@Override
	public ArrayList<Calendar> selectFullCalendarList(int userNo){
		return calendarDao.selectFullCalendarList(userNo);
	}
	
	@Override
	public int selectDeptCode(int userNo) {
		return calendarDao.selectDeptCode(userNo);
	}
	
	@Override 
	public int insertEvent(Calendar calendar) {
		return calendarDao.insertEvent(calendar);
	}
	
	@Override 
	public int insertMemo(CalendarMemo calendarMemo) {
		return calendarDao.insertMemo(calendarMemo);
	}
	
	@Override 
	public int updateMemo(CalendarMemo calendarMemo) {
		return calendarDao.updateMemo(calendarMemo);
	}
	
	@Override 
	public CalendarMemo selectMemo(int userNo) {
		return calendarDao.selectMemo(userNo);
	}
}
