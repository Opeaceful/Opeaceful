package com.company.opeaceful.approval.model.vo;

import java.sql.Timestamp;
import java.sql.Date;

import com.company.opeaceful.attendance.model.vo.Attendance;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Approval {
	private int approvalNo;				//	APPROVAL_NO
	private int userNo;					//	USER_NO
	private int type;					//	TYPE 일반0, 휴가1, 오전반차2, 오후반차3
	private String title;				//	TITLE
	private String content;				//	CONTENT
	private Timestamp draftDate;		//	DRAFT_DATE
	private int status;					//	STATUS 결재 상태(진행중0,반려-1,완료1, 임시저장2)
	private Date startDate;				//	START_DATE
	private Date endDate;				//	END_DATE
	private String userName;			//	USER_NAME
	private String approvalLineImg;		//	APPROVAL_LINE_IMG
	
	private double approvalCount;		// APPROVAL_COUNT : 연차갯수

}
