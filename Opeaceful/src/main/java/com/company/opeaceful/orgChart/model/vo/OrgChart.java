package com.company.opeaceful.orgChart.model.vo;

import lombok.Data;

@Data
public class OrgChart {

	private int deptCode;
	private String deptName;
	private int topDeptCode;
	
	private int pCode;
	private String pName;
	
	private int userNo;
}
