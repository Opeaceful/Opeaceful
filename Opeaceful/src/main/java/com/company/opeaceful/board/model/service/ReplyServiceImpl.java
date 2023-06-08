package com.company.opeaceful.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.dao.ReplyDao;
import com.company.opeaceful.board.model.vo.BoardReply;

@Repository
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public int insertReply(BoardReply reply) {
		return replyDao.insertReply(reply);
	}
	
	@Override
	public List<BoardReply> selectReplyList(int bno){
		return replyDao.selectReplyList(bno);
	}
	
	@Override
	public int deleteReply(int replyNo) {
		return replyDao.deleteReply(replyNo);
	}
}
