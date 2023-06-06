package com.company.opeaceful.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OnlineStatus {
	private int statusType;
	private String statusName;
	private String statusImg;
}
