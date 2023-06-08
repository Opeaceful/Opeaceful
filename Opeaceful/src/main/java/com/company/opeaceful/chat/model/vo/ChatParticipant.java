package com.company.opeaceful.chat.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatParticipant {
	
	private int chatRoomNo;
	private int userNo;
	private String roomName;
	private int notReadChat;
	private int lastReadChatNo;
	private Date createDate;
	private String bellSetting;
	
	private String userName;
	private String profileImg;
	private int eno;
	
	
	

}
