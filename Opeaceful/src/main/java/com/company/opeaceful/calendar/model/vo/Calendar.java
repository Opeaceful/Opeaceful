package com.company.opeaceful.calendar.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Calendar {
	
	private int calendarNo;
	private String category;
	private int userNo;
	private int deptCode;
	private String title;
	private String content;
	private String startDate;
	private String endDate;
	private String color;
	private String dDay;
	
	private int id;
	private String borderColor;
	private String start;
	private String end;
	private String backgroundColor;
	
	private String name;
	
}
