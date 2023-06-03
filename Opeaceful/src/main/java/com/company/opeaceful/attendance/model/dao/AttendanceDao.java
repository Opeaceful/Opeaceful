package com.company.opeaceful.attendance.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;

@Repository
public class AttendanceDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertWorkOn(int userNo) {
		return sqlSession.insert("attendanceMapper.insertWorkOn", userNo);
	}
	
	
	public ArrayList<ApprovalForm> selectFormList(){
		return sqlSession.selectList("");
	};
	public ApprovalForm selectForm(int formNo) {
		
	};
	
	public int insertForm(ApprovalForm form) {
		
	};
	public int insertFile(ApprovalFile file) {
		
	};
	
	public int updateForm(ApprovalForm form) {
		
	};
	
}
