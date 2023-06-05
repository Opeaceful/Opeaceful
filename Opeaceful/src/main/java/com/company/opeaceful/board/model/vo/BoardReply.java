package com.company.opeaceful.board.model.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardReply {
	private int replyNo;
	private int boardNo;
	private int userNo;
	private String content;
	private String secret;
	private int topReplyNo;
	private Timestamp createDate;
	
	
}
