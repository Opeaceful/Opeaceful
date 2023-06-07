package com.company.opeaceful.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardFile {
	private int boardNo;
	private int fileNo;
	private String originFIle;
	private String changeFile;
}
