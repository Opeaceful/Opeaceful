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
import com.company.opeaceful.dept.model.vo.Department;
import com.mysql.cj.Session;

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
		int offset = (pi.getCurrentPage() -1) * pi.getSettingLimit();
		int limit  = pi.getSettingLimit();
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", map, rowBounds);
	}
	
	public ArrayList<Board> selectSearchBoardList(PageInfo pi, Map<String, Object> map){
		int offset = (pi.getCurrentPage() -1) * pi.getSettingLimit();
		int limit  = pi.getSettingLimit();
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.searchBoardList", map, rowBounds);
	}
	
	public int selectNoticeRoll(String userNo) {
		return sqlSession.selectOne("boardMapper.selectNoticeRoll", userNo);
	}
	
	public int selectFreeRoll(String userNo) {
		return sqlSession.selectOne("boardMapper.selectFreeRoll", userNo);
	}

	public Board selectBoardDetail(int boardNo) {
		return sqlSession.selectOne("boardMapper.selectBoardDetail" , boardNo);
	}

	public int updateAddCount(int boardNo) {
		return sqlSession.update("boardMapper.updateAddCount",boardNo);
	}
	
	public int boardDelete(int boardNo) {
		return sqlSession.delete("boardMapper.boardDelete", boardNo);
	}
	
	public ArrayList<Department> selectDeptList(){
		return (ArrayList)sqlSession.selectList("deptMapper.boardEnrollDeptList");
	}
	
}
