package com.company.opeaceful.board.model.service;

import java.util.List;

import com.company.opeaceful.board.model.vo.BoardReply;

public interface ReplyService {
	
	int insertReply(BoardReply reply);
	
	List<BoardReply> selectReplyList(int bno);
	
	int deleteReply(int replyNo);

	int replyCount(int bno);

}
