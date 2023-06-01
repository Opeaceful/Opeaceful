package com.company.opeaceful.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.commom.model.vo.PageInfo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Board> mainSelectNoticeList() {
		return sqlSession.selectList("boardMapper.mainSelectNoticeList");
	}
	
	public ArrayList<BoardType> selectBoardTypeList(){
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardTypeList");
	}
	
	public int selectBoardListCount(String boardCode) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount", boardCode);
	}
	
	
	public ArrayList<Board> selectBoardList(String boardCode){
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", boardCode);
	}
	
//	public ArrayList<Board> selectBoardList(PageInfo pi, String boardCode){
//		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
//		int limit  = pi.getBoardLimit();
//		RowBounds rowBounds = new RowBounds(offset,limit);
//		
//		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", boardCode, rowBounds);
//	}
	
	
}
