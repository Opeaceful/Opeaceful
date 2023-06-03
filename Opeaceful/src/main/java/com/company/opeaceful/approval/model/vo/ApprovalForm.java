package com.company.opeaceful.approval.model.vo;

import java.sql.Date;

import com.company.opeaceful.attendance.model.vo.Attendance;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
//(승은)
public class ApprovalForm {
	private int formNo;			//	FORM_NO
	private int type;			//	TYPE
	private String title;		//	TITLE
	private String content;		//	CONTENT


}
