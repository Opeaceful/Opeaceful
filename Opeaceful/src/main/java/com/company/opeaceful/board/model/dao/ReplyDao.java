package com.company.opeaceful.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.vo.BoardReply;

@Repository
public class ReplyDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertReply(BoardReply reply) {
		return sqlSession.insert("replyMapper.insertReply",reply);
	}
	
	public List<BoardReply> selectReplyList(int bno){
		return sqlSession.selectList("replyMapper.selectReplyList",bno);
	}
	
	public int deleteReply(int replyNo) {
		return sqlSession.delete("replyMapper.deleteReply",replyNo);
	}
}
