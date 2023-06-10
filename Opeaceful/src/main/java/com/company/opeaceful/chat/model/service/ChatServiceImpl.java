package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.dao.ChatDao;
import com.company.opeaceful.chat.model.vo.ChatMessage;
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
	public List<ChatRoom> selectChatRoomList(){
		return chatDao.selectChatRoomList();
	}
	
	@Override
	public int openChatRoom(ChatRoom chatRoom) {
		return chatDao.openChatRoom(chatRoom);
	}
	
	@Override
	public List<ChatMessage> joinChatRoom(ChatParticipant join){
		
		// 현재 회원이 해당 채팅방에 참여하고 있는지 확인
		// CHAT_ROOM_JOIN에 현재 유저+채팅방 번호로 들어간 데이터가 있는지 확인
		int result = chatDao.joinCheck(join);

		if (result == 0 ) {
			// 미참여시 추가
			chatDao.joinChatRoom(join);
		}
				
		// 채팅 메세지 목록 조회
		return chatDao.selectChatMessage(join.getChatRoomNo());
	}
	
	
	
	
	
	
}
