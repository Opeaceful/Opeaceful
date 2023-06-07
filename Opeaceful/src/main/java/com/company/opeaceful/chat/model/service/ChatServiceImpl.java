package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.dao.ChatDao;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public ArrayList<Member> adminAll(){
		return chatDao.adminAll();
	}
	
	@Override
	public ArrayList<OnlineStatus> onlineStatusList(){
		return chatDao.onlineStatusList();
	}
	
	@Override
	public ArrayList<Board> noticeList(){
		return chatDao.noticeList();
	}
	
	@Override
	public List<ChatParticipant> selectChatRoomList(){
		return chatDao.selectChatRoomList();
	}
	
	
	
}
