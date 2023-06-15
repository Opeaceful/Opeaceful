package com.company.opeaceful.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.board.model.dao.BoardDao;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardFile;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;
import com.company.opeaceful.dept.model.vo.Department;

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
		int settingLimit = 12;
		PageInfo pi = pagination.getPageInfo(listCount, (int)(map.get("currentPage")), pageLimit, settingLimit);
		
		ArrayList<Board> list = (ArrayList) boardDao.selectBoardList(pi, map);
		
		map.put("pi", pi);
		map.put("list", list);
		System.out.println("list 담긴 값 : " + map.get(list));
		System.out.println("map에 담긴 값 서비스 : " + map);
		
	}
	// 검색된 게시글 목록 조회
	@Override
	public void selectSearchBoardList(Map<String, Object> map){
		int listCount = boardDao.searchBoardListCount(map);
		int pageLimit = 10;
		int settingLimit = 12;
		PageInfo pi = pagination.getPageInfo(listCount, (int)(map.get("currentPage")), pageLimit, settingLimit);
		
		ArrayList<Board> list= boardDao.selectSearchBoardList(pi, map);
		
		map.put("pi", pi);
		map.put("list", list);
		
		System.out.println("map에 담긴 값 서비스 : " + map);
	}
	
	@Override
	public int selectNoticeRoll(String userNo) {
		return boardDao.selectNoticeRoll(userNo);
	}
	
	@Override
	public int selectFreeRoll(String userNo) {
		return boardDao.selectFreeRoll(userNo);
	}
	
	@Override
	public Board selectBoardDetail(Map<String, Object> map) {
		return boardDao.selectBoardDetail(map);
	}
	
	@Override
	public int updateAddCount(int boardNo) {
		return boardDao.updateAddCount(boardNo);
	}
	
	@Override
	public int boardDelete(int boardNo) {
		return boardDao.boardDelete(boardNo);
	}
	@Override
	public ArrayList<Department> selectDeptList(){
		return boardDao.selectDeptList();
	}
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int insertBoard(Board b, List<BoardFile> fileList) throws Exception{
		System.out.println("서비스 단 시작 전");
		int boardNo = boardDao.insertBoard(b);
		System.out.println("인서트 보드 결과 : " + boardNo);
		if(boardNo > 0 && fileList.size() > 0) {
					
			int result = insertUpFile(fileList, boardNo);
			
			System.out.println("인서트 업파일 결과 : " + result);
		}
			return boardNo; // 인서트 결과 반환 (1/0)
	}
			
	public int insertUpFile(List<BoardFile> fileList, int boardNo) {
		return boardDao.insertUpFile(fileList, boardNo);
	}
	
	
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int updateBoard(Board b, List<BoardFile> fileList) throws Exception{
		int result = boardDao.updateBoard(b);
		
		return result;
	}
	
	@Override
	public List<BoardFile> selectUpFileList(int boardNo){
		return boardDao.selectUpfileList(boardNo);
	}
	
	@Override
	public int deleteUpfile(int boardNo) {
		return boardDao.deleteUpfile(boardNo);
	}
	
	@Override
	public int selectDeptCode(int userNo) {
		return boardDao.selectDeptCode(userNo);
	}
	
}
