package com.company.opeaceful.chat.model.vo;

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
public class ChatParticipant {
	
	private int chatRoomNo;
	private int userNo;
	private String roomTitle;
	private int notReadChat;
	private int lastReadChatNo;
	private Date createDate;
	private String bellSetting;
	
	private String profileImg;
	private String userName;
	

}
