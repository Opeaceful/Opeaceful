package com.company.opeaceful.member.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	
	private int userNo;
	private int eno;
	private String status;
	private String profileImg;
	private int statusType;
	private String userPwd;
	private String userName;
	private String phone;
	private String extension;
	private String email;
	private String address;
	private int annualLeaveCount;
	private Date hireDate;
	
}
