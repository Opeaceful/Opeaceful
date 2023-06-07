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
	private String refType;			//	REF_TYPE : form / approval / memo
	private int refNo;				//	REF_NO
	private String originName;		//	ORIGIN_NAME
	private String changeName;		//	CHANGE_NAME
	
	
	
	public ApprovalFile(String changeName) {
		super();
		this.changeName = changeName;
	}

	
	
	
}
