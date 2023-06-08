package com.company.opeaceful.salary.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Salary {
		
	private int salaryNo;
	private int userNo;
	private int yearReported;
	private int monReported;
	private Date paymentDate;
	private String totalGrosspay;
	private String totalDeductions;
	private String netPay;
	private String payments;
	private String deduction;
	private String pName;
	private String deptName;
	
	//계산후 db저장용
	private int intTotalGrosspay;
	private int intTotalDeductions;
	private int intNetPay;

}

