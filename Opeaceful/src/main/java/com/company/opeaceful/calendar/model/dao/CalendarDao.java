package com.company.opeaceful.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.calendar.model.vo.CalendarMemo;

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
	
	public int selectDeptCode(int userNo) {
		return sqlSession.selectOne("deptMapper.calendarDeptCode", userNo);
	}
	
	public int insertEvent(Calendar calendar) {
		return sqlSession.insert("calendarMapper.insertEvent", calendar);
	}
	
	public Calendar selectEvent(int cno) {
		return sqlSession.selectOne("calendarMapper.selectEvent", cno);
	}
	
	public int updateEvent(Calendar calendar) {
		return sqlSession.update("calendarMapper.updateEvent", calendar);
	}
	
	public int deleteEvent(int cno) {
		return sqlSession.delete("calendarMapper.deleteEvent", cno);
	}
	
	public int insertMemo(CalendarMemo calendarMemo) {
		return sqlSession.insert("calendarMapper.insertMemo", calendarMemo);
	}
	
	public int updateMemo(CalendarMemo calendarMemo) {
		return sqlSession.update("calendarMapper.updateMemo", calendarMemo);
	}
	
	public CalendarMemo selectMemo(int userNo) {
		return sqlSession.selectOne("calendarMapper.selectMemo", userNo);
	}
	
	public ArrayList<Calendar> dDayList (int userNo){
		return (ArrayList)sqlSession.selectList("calendarMapper.dDayList", userNo);
	}
	
	public int dDayNone(int calendarNo) {
		return sqlSession.update("calendarMapper.dDayNone", calendarNo);
	}
	
}
