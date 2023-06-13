package com.company.opeaceful.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.calendar.model.vo.Calendar;

@Repository
public class CalendarDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Calendar> selectMyCalendarList(int userNo){
		return (ArrayList)sqlSession.selectList("calendarMapper.myCalendarList" , userNo);
	}
	
	public ArrayList<Calendar> selectTeamCalendarList(int userNo){
		return (ArrayList)sqlSession.selectList("calendarMapper.teamCalendarList" , userNo);
	}
	
	public ArrayList<Calendar> selectFullCalendarList(int userNo){
		return (ArrayList)sqlSession.selectList("calendarMapper.fullCalendarList" , userNo);
	}
	
	
	
	
	
	
	
}
