package com.company.opeaceful.calendar.model.service;

import java.util.ArrayList;

import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.calendar.model.vo.CalendarMemo;

public interface CalendarService {

	public ArrayList<Calendar> selectMyCalendarList(int userNo);
	
	public ArrayList<Calendar> selectTeamCalendarList(int userNo);
	
	public ArrayList<Calendar> selectFullCalendarList(int userNo);
	
	public int selectDeptCode(int userNo);
	
	public int insertEvent(Calendar calendar);
	
	public int insertMemo(CalendarMemo calendarMemo);

	public int updateMemo(CalendarMemo calendarMemo);
	
	public CalendarMemo selectMemo(int userNo);
	
}
