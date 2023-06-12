package com.company.opeaceful.approval.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

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
	private int status;					//	STATUS 결재 상태(진행중0,확인안한 반려-1, 확인한 반려-2,완료1, 임시저장2)
	private Date startDate;				//	START_DATE
	private Date endDate;				//	END_DATE
	private String userName;			//	USER_NAME
	// private String approvalLineImg;	//	APPROVAL_LINE_IMG
	
	private String pName;				// 유저 직급 정보용
	private int eno;					// 유저 사원번호 정보용
	private double approvalCount;		// APPROVAL_COUNT : 연차갯수
	private String formatDraftDate;		//	DRAFT_DATE
	private String signatureImg;	// 서명 이미지 경로 + 이름 SIGNATURE_IMG
	

}
