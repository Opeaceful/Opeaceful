package com.company.opeaceful.orgChart.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class OrgChart {

	private int deptCode;
	private String deptName;
	private int topDeptCode;
	
	private int pCode;
	private String pName;
	
	private int userNo;
	private String userName;
	
	private int presonnelCode;
	private String status;
	private String topDeptName;
	private Date personnelDate;
	private String pBefore;
	private String pPersonnel;
	private String dBefor;
	private String dPersonner;
}
