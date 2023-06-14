package com.company.opeaceful.calendar.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.calendar.model.dao.CalendarDao;
import com.company.opeaceful.calendar.model.vo.Calendar;

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
	
}
