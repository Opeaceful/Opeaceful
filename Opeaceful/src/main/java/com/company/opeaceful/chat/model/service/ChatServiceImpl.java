package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.dao.ChatDao;
import com.company.opeaceful.chat.model.vo.Chat;
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
	public List<ChatRoom> selectChatRoomList(Member loginUser){
		return chatDao.selectChatRoomList(loginUser);
	}
	
	@Override
	public int openChatRoom(ChatRoom chatRoom) {
		return chatDao.openChatRoom(chatRoom);
	}
	
	 @Override
	 public void addChatParticipant(int chatRoomNo, int userNo, String roomTitle) {
		 chatDao.addChatParticipant(chatRoomNo, userNo, roomTitle);
	 }
	
	@Override
	public List<Chat> joinChatRoom(ChatParticipant join){
		
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
	
	
	
	// 아 강의 .....
	@Override
	public int insertMessage(Chat chatMessage) {
		return chatDao.insertMessage(chatMessage);
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int exitChatRoom(ChatParticipant join) {
		
		// 채팅방 나가기
		int result = chatDao.exitChatRoom(join);
		
		// 채팅방 나가기 성공시
		if(result > 0 ) {
			// 현재 방에 남아있는 인원을 확인하고
			int cnt = chatDao.countChatRoomMemeber(join.getChatRoomNo());
		
			// 0명일 경우 방을 닫기
			if(cnt == 0 ) {
				result = chatDao.closeChatRoom(join.getChatRoomNo());
			}
			
		}
		
		return result;
	}
	
	// 웹소켓 수정
	@Override
	public List<ChatParticipant> chatRoomList(Member loginUser){
		return chatDao.chatRoomList(loginUser);
	}
	
	@Override
	public List<ChatParticipant> getParticipantsInRoom(int chatRoomNo) {
        return chatDao.getParticipantsInRoom(chatRoomNo);
	}

	@Override
	public List<Integer> chatRoomNoList(Member loginUser) {
		return chatDao.chatRoomNoList(loginUser);
	}

	@Override
	public List<Member> getChatRoomParticipants(int chatRoomNo) {
		return chatDao.getChatRoomParticipants(chatRoomNo);
	}

	@Override
	public List<ChatParticipant> chatRoomListMemberList(int userNo) {
		return chatDao.chatRoomListMemberList(userNo);
	}

	
	
	
	
}
