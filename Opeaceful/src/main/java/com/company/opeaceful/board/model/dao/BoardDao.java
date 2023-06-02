package com.company.opeaceful.board.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	
	public int selectBoardListCount(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount", map);
	}
	
	public int searchBoardListCount(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.searchBoardListCount", map);
	}
	
	public ArrayList<Board> selectBoardList(PageInfo pi, Map<String, Object> map){
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit  = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", map, rowBounds);
	}
	
	public ArrayList<Board> selectSearchBoardList(PageInfo pi, Map<String, Object> map){
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit  = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.searchBoardList", map, rowBounds);
	}
	
	
	
}
