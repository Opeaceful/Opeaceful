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
import com.company.opeaceful.member.model.vo.Member;

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
	
	@Override
	public ArrayList<BoardType> selectBoardTypeList(){
		return boardDao.selectBoardTypeList();
	}
	// 게시글 목록 조회
	@Override
	public void selectBoardList( Map<String, Object> map){
		
		int listCount = boardDao.selectBoardListCount(map);
		int pageLimit = 10;
		int settingLimit = 14;
		PageInfo pi = pagination.getPageInfo(listCount, (int)(map.get("currentPage")), pageLimit, settingLimit);
		
		ArrayList<Board> list = (ArrayList) boardDao.selectBoardList(pi, map);
		
		map.put("pi", pi);
		map.put("list", list);
		
		System.out.println("map에 담긴 값 서비스 : " + map);
	}
	// 검색된 게시글 목록 조회
	@Override
	public void selectSearchBoardList(Map<String, Object> map){
		int listCount = boardDao.searchBoardListCount(map);
		int pageLimit = 10;
		int settingLimit = 14;
		PageInfo pi = pagination.getPageInfo(listCount, (int)(map.get("currentPage")), pageLimit, settingLimit);
		
		ArrayList<Board> list= boardDao.selectSearchBoardList(pi, map);
		
		map.put("pi", pi);
		map.put("list", list);
		
		System.out.println("map에 담긴 값 서비스 : " + map);
		
	}
	
	
	
	
	
	
}
