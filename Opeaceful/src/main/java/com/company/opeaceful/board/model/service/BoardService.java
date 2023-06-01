package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardType;

public interface BoardService {

	List<Board> mainSelectNoticeList();

	public ArrayList<BoardType> selectBoardTypeList();
	
	public ArrayList<Board> selectBoardList(String boardCode);
//	public ArrayList<Board> selectBoardList(int currentPage, String boardCode);
}
