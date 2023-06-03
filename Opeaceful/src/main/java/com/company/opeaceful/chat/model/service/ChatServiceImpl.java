package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.chat.model.dao.ChatDao;
import com.company.opeaceful.member.model.vo.Member;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public ArrayList<Member> adminAll(){
		return chatDao.adminAll();
	}
	
	
}
