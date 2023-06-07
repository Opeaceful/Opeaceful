package com.company.opeaceful.chat.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatRoom {
	
	private int chatRoomNo;
	private int userNo;
	private int lastChat;
	private Date createdChat;

}
