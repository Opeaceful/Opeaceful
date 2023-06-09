package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.dept.model.vo.Department;

public interface BoardService {

	public List<Board> mainSelectNoticeList();

	public ArrayList<BoardType> selectBoardTypeList();
	
	public void selectBoardList(Map<String, Object> map);
	
	public void selectSearchBoardList(Map<String, Object> map);

	public int selectNoticeRoll(String userNo);
	
	public int selectFreeRoll(String userNo);

	public Board selectBoardDetail(Map<String, Object> map);

	public int updateAddCount(int boardNo);

	public int boardDelete(int board);
	
	public ArrayList<Department> selectDeptList();
	
	public int insertBoard(Board b);
	
	public int updateBoard(Board b);
}
