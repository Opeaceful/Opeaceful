package com.company.opeaceful.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.chat.model.vo.OnlineStatus;
import com.company.opeaceful.member.model.vo.Member;

@Repository
public class ChatDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Member> adminAll(){
		return (ArrayList)sqlSession.selectList("chatMapper.adminAll");
	}
	
	public ArrayList<OnlineStatus> chatStatus(){
		return (ArrayList)sqlSession.selectList("chatMapper.chatStatus");
	}

}
