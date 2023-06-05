package com.company.opeaceful.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ResignedMember {
		
	private int userNo;
	private String resignedDate;
	private String deptName;
	private String pName;
	private String tName;
	
	private Date DresignedDate;

}
