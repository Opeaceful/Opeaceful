package com.company.opeaceful.calendar.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.calendar.model.vo.CalendarMemo;

public interface CalendarService {

	public ArrayList<Calendar> selectMyCalendarList(int userNo);
	
	public ArrayList<Calendar> selectTeamCalendarList(int userNo);
	
	public ArrayList<Calendar> selectFullCalendarList(int userNo);
	
	public int selectDeptCode(int userNo);
	
	public int insertEvent(Calendar calendar);
	
	public Calendar selectEvent(int cno);
	
	public int updateEvent(Calendar calendar);
	
	public int deleteEvent(int cno);
	
	public int insertMemo(CalendarMemo calendarMemo);

	public int updateMemo(CalendarMemo calendarMemo);
	
	public CalendarMemo selectMemo(int userNo);

	public ArrayList<Calendar> dDayList (int userNo);
	
	public int dDayNone(int calendarNo);
	
}
