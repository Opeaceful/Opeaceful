package com.company.opeaceful.chat.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import com.company.opeaceful.board.model.vo.Board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chat {
	
	private int chatNo;
	private int chatRoomNo;
	private int userNo;
	private String message;
	private int notReceived;
	private Timestamp receivedDate;
	private int messageType;
	
	private String userName;
	private String profileImg;
	private boolean roomNew;


public boolean roomNew() {
    return roomNew;
}

public void setNew(boolean roomNew) {
    this.roomNew = roomNew;
}

}