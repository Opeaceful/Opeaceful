package com.company.opeaceful.board.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardReply {
	private int replyNo;
	private int boardNo;
	private int userNo;
	private String content;
	private String secret;
	private int topReplyNo;
	private String createDate;
	
	private String pName;
	private String userName;
}
