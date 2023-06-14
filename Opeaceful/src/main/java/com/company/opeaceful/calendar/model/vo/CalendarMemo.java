package com.company.opeaceful.calendar.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarMemo {

	private int userNo;
	private String memo;
	
}
