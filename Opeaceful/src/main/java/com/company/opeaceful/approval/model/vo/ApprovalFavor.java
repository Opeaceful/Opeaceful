package com.company.opeaceful.approval.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalFavor {
	
	private int lineNo;				//	LINE_NO
	private int userNo;				//	USER_NO
	private String title;				//	TITLE

}
