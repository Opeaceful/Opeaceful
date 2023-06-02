package com.company.opeaceful.commom.model.vo;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
public class PageInfo {
	
	private int listCount;
	private int currentPage;
	private int pageLimit;
	
	private int settingLimit;

	private int maxPage;
	private int startPage;
	private int endPage;

	
}
