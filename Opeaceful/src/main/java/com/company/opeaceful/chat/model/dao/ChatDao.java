package com.company.opeaceful.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;

@Repository
public class ChatDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Member> adminAll(){
		return (ArrayList)sqlSession.selectList("memberMapper.adminAll");
	}
	
	public ArrayList<OnlineStatus> onlineStatusList(){
		return (ArrayList)sqlSession.selectList("attendanceMapper.onlineStatusList");
	}
	
	public ArrayList<Board> noticeList(){
		return (ArrayList)sqlSession.selectList("boardMapper.mainSelectNoticeList");
	}

}
