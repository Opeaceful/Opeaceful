package com.company.opeaceful.chat.model.vo;

import java.sql.Date;

import com.company.opeaceful.board.model.vo.Board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OnlineStatus {
	
	private int statusType;
	private String statusName;
	private String statusImg;

}
