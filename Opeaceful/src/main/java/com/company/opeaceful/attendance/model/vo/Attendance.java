package com.company.opeaceful.attendance.model.vo;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attendance {
	
	private String workDate;
	private int userNo;
//	private Date workOn;
//	private Date workOff;
//	private Timestamp workOn;
//	private Timestamp workOff;
	private Time workOn;
	private Time workOff;
//	private String workOn;
//	private String workOff;
}
