package com.company.opeaceful.attendance.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Attendance {
	
	private String date;
	private int userNo;
	private Date workOn;
	private Date workOff;
}
