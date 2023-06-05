package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.member.model.vo.Member;

public interface BoardService {

	List<Board> mainSelectNoticeList();

	public ArrayList<BoardType> selectBoardTypeList();
	
	public void selectBoardList(Map<String, Object> map);
	
	public void selectSearchBoardList(Map<String, Object> map);

	int selectNoticeRoll(String userNo);

	public Board selectBoardDetail(int boardNo);

	
	
}
