package com.company.opeaceful.approval.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
//(승은)
public class ApprovalMemo {
	private int memoNo;				//	MEMO_NO
	private int approvalNo;			//	APPROVAL_NO
	private int userNo;				//	USER_NO
	private String content;			//	CONTENT
	private Timestamp date;			//	DATE
	
	private String pName;			// 유저 직급 정보용
	private int eno;				// 유저 사원번호 정보용
	private String userName;		// 유저 이름 정보용

}
