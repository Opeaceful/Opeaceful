package com.company.opeaceful.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.board.model.dao.BoardDao;
import com.company.opeaceful.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<Board> mainSelectNoticeList(){
		return boardDao.mainSelectNoticeList();
	}

}
