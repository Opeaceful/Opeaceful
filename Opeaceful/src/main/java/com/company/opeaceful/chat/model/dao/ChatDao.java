package com.company.opeaceful.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.vo.Chat;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.chat.model.vo.ChatRoom;
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
	
	public List<ChatRoom> selectChatRoomList(Member loginUser){
		return sqlSession.selectList("chatMapper.selectChatRoomList", loginUser);
	}
	
	public int openChatRoom(ChatRoom chatRoom) {
		
		int result = sqlSession.insert("chatMapper.openChatRoom", chatRoom);
		
		if(result > 0) {
			return chatRoom.getChatRoomNo();
		}else {
			return result;
		}
	}
	
	public void addChatParticipant(int chatRoomNo, int userNo, String roomTitle) {
		 Map<String, Object> params = new HashMap<>();
	        params.put("chatRoomNo", chatRoomNo);
	        params.put("userNo", userNo);
	        params.put("roomTitle", roomTitle);
	        sqlSession.insert("addRoomParticipant", params);
	}
	
	
	//채팅방 참여여부 확인
	public int joinCheck(ChatParticipant join) {
		return sqlSession.selectOne("chatMapper.joinCheck", join);
	}
		
	// 채팅방 참여
	public void joinChatRoom(ChatParticipant join) {
		sqlSession.insert("chatMapper.joinChatRoom", join);
	}
		
	// 채팅방 메세지 목록 조회
	public List<Chat> selectChatMessage(int chatRoomNo){
		return sqlSession.selectList("chatMapper.selectChatMessage", chatRoomNo);
	}
	
	// 아.. 강의......
		// 채팅 메세지 삽입
		public int insertMessage(Chat chatMessage) {
			return sqlSession.insert("chatMapper.insertMessage", chatMessage);
		}
		
		
		// 채팅방 나가기
		public int exitChatRoom(ChatParticipant join) {
			return sqlSession.delete("chatMapper.exitChatRoom", join);
		}
		
		// 채팅방 인원수
		public int countChatRoomMemeber(int chatRoomNo) {
			return sqlSession.selectOne("chatMapper.countChatRoomMemeber", chatRoomNo);
		}
		
		
		// 채팅방 닫기
		public int closeChatRoom(int chatRoomNo) {
			return sqlSession.update("chatMapper.closeChatRoom", chatRoomNo);
		}
	

		// 웹소켓 수정
		
		public List<ChatParticipant> chatRoomList(Member loginUser){
			return sqlSession.selectList("chatMapper.chatRoomList", loginUser);
		}
		
		public List<ChatParticipant> getParticipantsInRoom(int chatRoomNo) {
		    return sqlSession.selectList("chatMapper.getParticipantsInRoom", chatRoomNo);	
		}    
	
		public List<Integer> chatRoomNoList(Member loginUser) {
			return sqlSession.selectList("chatMapper.chatRoomNoList", loginUser);
		}
		
		public List<Member> getChatRoomParticipants(int chatRoomNo){
			return sqlSession.selectList("memberMapper.getChatRoomParticipants", chatRoomNo);
		}
		
		public List<ChatParticipant> chatRoomListMemberList(int userNo){
			return sqlSession.selectList("chatMapper.chatRoomListMemberList", userNo);
		}
	
	
	
	

}
