package com.company.opeaceful.chat.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatMessage {
	
	private int chatNo;
	private int chatRoomNo;
	private int userNo;
	private String message;
	private int notReceived;
	private Date receivedDate;
	private int messageType;
	
	private String userName;

}
