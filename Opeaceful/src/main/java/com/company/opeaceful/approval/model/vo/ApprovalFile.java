package com.company.opeaceful.approval.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// (승은)
public class ApprovalFile {
	private int fileNo;				//	FILE_NO
	private int approvalNo;			//	APPROVAL_NO
	private int memoNo;				//	MEMO_NO
	private String originName;		//	ORIGIN_NAME
	private String changeName;		//	CHANGE_NAME

}
