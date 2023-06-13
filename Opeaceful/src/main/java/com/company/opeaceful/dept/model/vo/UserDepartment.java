package com.company.opeaceful.dept.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDepartment {
	
	private int userNo;
	private int pCode;
	private int deptCode;
	
	private String pName;
	private String deptName;
	
	
}
