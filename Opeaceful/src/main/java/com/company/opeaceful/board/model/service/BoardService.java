package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardFile;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.dept.model.vo.Department;

public interface BoardService {

	public List<Board> mainSelectNoticeList();

	public ArrayList<BoardType> selectBoardTypeList();
	
	public void selectBoardList(Map<String, Object> map);
	
	public void selectSearchBoardList(Map<String, Object> map);

	public String selectNoticeRoll(String userNo);
	
	public String selectFreeRoll(String userNo);

	public Board selectBoardDetail(Map<String, Object> map);

	public int updateAddCount(int boardNo);

	public int boardDelete(int board);
	
	public ArrayList<Department> selectDeptList();
	
	public int insertBoard(Board b, List<MultipartFile> upFileList, String serverFolderPath);
	
	public int updateBoard(Board b, List<String> hiddenfile, List<MultipartFile> upFileList, String serverFolderPath);
	
	public List<BoardFile> selectUpFileList(int boardNo);
	
	public int deleteUpfile(int boardNo, String serverFolderPath);
	
	public int selectDeptCode(int userNo);
	
	
	
	
	
	
	
	
	
	
}
