package com.company.opeaceful.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.chat.model.vo.ChatMessage;
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
	
	public List<ChatRoom> selectChatRoomList(){
		return sqlSession.selectList("chatMapper.selectChatRoomList");
	}
	
	public int openChatRoom(ChatRoom chatRoom) {
		
		int result = sqlSession.insert("chatMapper.openChatRoom", chatRoom);
		
		if(result > 0) {
			return chatRoom.getChatRoomNo();
		}else {
			return result;
		}
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
	public List<ChatMessage> selectChatMessage(int chatRoomNo){
		return sqlSession.selectList("chatMapper.selectChatMessage", chatRoomNo);
	}

	
	
	
	
	
	
	
	
	
	
	

}
