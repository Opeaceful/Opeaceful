package com.company.opeaceful.dept.model.vo;

import java.sql.Date;

import com.company.opeaceful.board.model.vo.Board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Department {
	
	private int deptCode;
	private String deptName;
	private int topDeptCode;
	
	
}
