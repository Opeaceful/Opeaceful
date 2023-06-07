package com.company.opeaceful.approval.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
//(승은)
public class ApprovalLine {
	private int level;				//	LEVEL
	private int approvalNo;			//	APPROVAL_NO
	private	int userNo;				//	USER_NO
	private String type;			//	TYPE
	private int status;				//	STATUS
	private String confirmStatus;	//	CONFIRM_STATUS
	private Timestamp date;			//	DATE

}
