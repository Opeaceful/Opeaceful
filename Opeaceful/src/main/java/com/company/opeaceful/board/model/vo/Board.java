package com.company.opeaceful.board.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
	private int boardNo;
	private String boardCd;
	private int deptCode;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private String createDate;
	private int count;
	private String fixed;
	private String secret;
	
	private String pName;
	private String userName;
	private int userNo;
	
	private int replyCount;
	
	private int befo;
	private int next;
	
}
