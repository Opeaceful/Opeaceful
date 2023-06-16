package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.vo.Chat;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;

public interface ChatService {
	
	public abstract ArrayList<Member> adminAll();
	
	public abstract ArrayList<OnlineStatus> onlineStatusList();
	
	public abstract ArrayList<Board> noticeList();
	
	
	List<ChatRoom> selectChatRoomList();
	
	int openChatRoom(ChatRoom cr);
	
	List<Chat> joinChatRoom(ChatParticipant cp);
	
	// 아 강의.....
	
	int insertMessage(Chat cm);
	
	int exitChatRoom(ChatParticipant crj);
	
	// 웹소켓 수정
	
	List<ChatParticipant> chatRoomList(Member loginUser);
	
	
	// 룸번호 받아서 해당 룸에 참여중인 유저 조회
	List<ChatParticipant> getParticipantsInRoom(int chatRoomNo);
	
	
	
}
