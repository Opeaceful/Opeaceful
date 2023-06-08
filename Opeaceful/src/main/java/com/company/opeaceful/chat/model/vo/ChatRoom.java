package com.company.opeaceful.chat.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatRoom {
	
	private int chatRoomNo;
	private int userNo;
	private String roomTitle;
	private int lastChat;
	private Date createdChat;
	
	private String userName;
	private String profileImg;
	private int eno;

}
