package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.board.model.dao.BoardDao;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private Pagination pagination;
	
	@Override
	public List<Board> mainSelectNoticeList(){
		return boardDao.mainSelectNoticeList();
	}
	
	public ArrayList<BoardType> selectBoardTypeList(){
		return boardDao.selectBoardTypeList();
	}
	
//	public ArrayList<Board> selectBoardList(int currentPage, String boardCode){
//		
//		int listCount = boardDao.selectBoardListCount(boardCode);
//		int pageLimit = 10;
//		int boardLimit = 14;
//		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
//		
//		ArrayList<Board> list = boardDao.selectBoardList(pi, boardCode);
////		map.put("pi", pi);
////		map.put("list", list);
//	
//		return list;
//	}
	
	public ArrayList<Board> selectBoardList(String boardCode){
		
		int listCount = boardDao.selectBoardListCount(boardCode);
	
		
		ArrayList<Board> list = boardDao.selectBoardList( boardCode);

	
		return list;
	}
	
	
	
	
	
	
	
	
	
}
