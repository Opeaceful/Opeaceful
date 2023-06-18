package com.company.opeaceful.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardFile;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.dept.model.vo.Department;

@Repository
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	//private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
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
	// 공지사항 권한 조회
	public String selectNoticeRoll(String userNo) {
		return sqlSession.selectOne("boardMapper.selectNoticeRoll", userNo);
	}
	
	public String selectFreeRoll(String userNo) {
		return sqlSession.selectOne("boardMapper.selectFreeRoll", userNo);
	}

	public Board selectBoardDetail(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectBoardDetail" , map);
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
	
	public int insertBoard(Board b) {
		int result = sqlSession.insert("boardMapper.insertBoard", b);
		
		if(result > 0) { // 게시글 등록 성공 시 게시글 번호 반환
			result = b.getBoardNo();
		}
		return result;
	}
	
	public int lastPk() {
		//logger.info("dao lastPk 로거");
		try {
			Integer result = sqlSession.selectOne("boardMapper.lastPk");
			//System.out.println("디에이오 인티저 타입 : "+result.getClass().getName());
			//System.out.println("dao result : "+ result);
				return result;
			
		}catch(NullPointerException e){
			Integer result = Integer.valueOf(0);
			return result;
		}
		
	}
	
	public int insertUpFile(List<BoardFile> fileList) {
		return sqlSession.insert("boardMapper.insertUpFile", fileList);
	}
	
	public int updateBoard(Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	public List<BoardFile> selectUpfileList (int boardNo) {
		return sqlSession.selectList("boardMapper.selectUpfileList", boardNo);
	}
	
	public int deleteUpfile(int boardNo) {
		return sqlSession.delete("boardMapper.deleteUpfile", boardNo);
	}
	
	public int deleteFileList(List<BoardFile> dbList){
		return sqlSession.delete("boardMapper.deleteFileList", dbList);
	}
	
	public int selectDeptCode(int userNo) {
		return sqlSession.selectOne("deptMapper.calendarDeptCode", userNo);
	}
	
}
