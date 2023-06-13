package com.company.opeaceful.calendar.model.service;

import java.util.ArrayList;

import com.company.opeaceful.calendar.model.vo.Calendar;

public interface CalendarService {

	public ArrayList<Calendar> selectMyCalendarList(int userNo);
	
	public ArrayList<Calendar> selectTeamCalendarList(int userNo);
	
	public ArrayList<Calendar> selectFullCalendarList(int userNo);
	
	
	
	
	
	
	
}
