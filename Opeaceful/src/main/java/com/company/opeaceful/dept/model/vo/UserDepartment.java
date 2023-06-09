package com.company.opeaceful.dept.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDepartment {

	private int userNo;
	private int pCode;
	private int deptCode;

	private String pName;
	private String deptName;
	private String topDeptName;

	private int eno;
	private String userName;
	private int topDeptCode;

}
