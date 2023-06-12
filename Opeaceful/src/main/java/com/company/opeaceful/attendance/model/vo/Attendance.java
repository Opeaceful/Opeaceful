package com.company.opeaceful.attendance.model.vo;

import java.sql.Date;
import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attendance {
	
	private Date workDate;
	private int userNo;
	private Time workOn;
	private Time workOff;
	
	private int type;
	private String userName;
	private Time totalWorkTime;
	private Date date;
	private int approvalNo;
	private int status;
	private Date startDate;				//	START_DATE
	private Date endDate;
	private int count;
}
