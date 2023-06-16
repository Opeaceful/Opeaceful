package com.company.opeaceful.board.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.board.model.dao.BoardDao;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.board.model.vo.BoardFile;
import com.company.opeaceful.board.model.vo.BoardType;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;
import com.company.opeaceful.dept.model.vo.Department;

@Service
public class BoardServiceImpl implements BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
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
	}
	
	@Override
	public String selectNoticeRoll(String userNo) {
		return boardDao.selectNoticeRoll(userNo);
	}
	
	@Override
	public String selectFreeRoll(String userNo) {
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
	public int insertBoard(Board b, List<MultipartFile> upFileList, String serverFolderPath) {

		// logger.info("insert보드 서비스임플리먼츠로거");
		int boardNo = boardDao.insertBoard(b);

		int fileNo = boardDao.lastPk() + 1;

		if (upFileList != null) {
			if (boardNo > 0 && upFileList.size() > 0) {

				List<BoardFile> addList = new ArrayList();
				List<String> renamefileList = new ArrayList();

				for (int i = 0; i < upFileList.size(); i++) {

					if (upFileList.get(i).getSize() > 0) {

						String changeFile = "";
						String originFile = "";

						try {
							changeFile = FileRenamePolicy.saveFile(upFileList.get(i), serverFolderPath);

							renamefileList.add(changeFile);

							BoardFile file = new BoardFile();

							file.setOriginFile(upFileList.get(i).getOriginalFilename());
							file.setChangeFile(changeFile);
							file.setBoardNo(boardNo);
							file.setFileNo(fileNo);

							addList.add(file);

							fileNo += 1;

						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				} // for끝
				if (!addList.isEmpty()) {
					int result = boardDao.insertUpFile(addList);
				} else {
					// System.out.println("에러: "+ addList);
					System.out.println("인서트업파일 에러");
				}
			}
		}

		return boardNo; // 인서트 결과 반환 (1/0)

	}
			
	
	
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int updateBoard(Board b, List<String> hiddenfile, List<MultipartFile> upFileList, String serverFolderPath) {
		// logger.info("update보드 서비스임플리먼츠로거");

		// 히든파일이랑 해당 보드 넘겨서 조회해온 파일리스트랑 비교해서 없으면 삭제시키는 메서드로 넘기기

		List<BoardFile> dbList = boardDao.selectUpfileList(b.getBoardNo()); // db에서 꺼내온 기존 파일 리스트
		List<String> dbNoList = new ArrayList(); // db에서 꺼낸 파일넘버 리스트 담을 리스트

		if (dbList != null) { // 기존리스트가 널이 아닐 때 => 변경된 파일리스트와 비교해야함

			if (hiddenfile != null) { // 1)기존에 있던 파일에서 남겨둔 파일넘버리스트(히든리스트 담긴 파일번호들은 살려둬야함 , 없는 번호는 지워줘야함)

				for (int i = 0; i < dbList.size(); i++) {
					String dbFileNo = dbList.get(i).getFileNo() + "";

					for (int j = 0; j < hiddenfile.size(); j++) {
						if (dbFileNo.equals(hiddenfile.get(j))) {
							dbList.remove(i);
							i--;
							break;
						}
					}
				}
				boardDao.deleteFileList(dbList);

			} else { // 2)null이라는 건 기존에 있던 파일들 다 지운 것 => 해당하는 보드 넘버의 파일리스트 다 지워주기
				boardDao.deleteUpfile(b.getBoardNo());
			}

			/* 실제 폴더에 있는 파일 삭제 */
			for (BoardFile file : dbList) {
				File deleteFile = new File(serverFolderPath + file.getChangeFile());
				if (deleteFile.exists()) { // 파일이 존재하면
					deleteFile.delete();// 파일 삭제
				}
			}

		} // 기존리스트가 널이면 애초에 히든리스트가 없음 그러면 처리할 필요 없음 새로 추가만 하면 됨

		int resultU = boardDao.updateBoard(b);

		int fileNo = boardDao.lastPk() + 1;

		if (upFileList != null) {
			if (upFileList.size() > 0) {

				List<BoardFile> addList = new ArrayList();
				List<String> renamefileList = new ArrayList();

				for (int i = 0; i < upFileList.size(); i++) {

					if (upFileList.get(i).getSize() > 0) {

						String changeFile = "";
						String originFile = "";

						try {
							changeFile = FileRenamePolicy.saveFile(upFileList.get(i), serverFolderPath);

							renamefileList.add(changeFile);

							BoardFile file = new BoardFile();

							file.setOriginFile(upFileList.get(i).getOriginalFilename());
							file.setChangeFile(changeFile);
							file.setBoardNo(b.getBoardNo());
							file.setFileNo(fileNo);

							addList.add(file);

							fileNo += 1;
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				} // for끝
				if (!addList.isEmpty()) {
					int result = boardDao.insertUpFile(addList);

				} else {
					// System.out.println("에러: "+ addList);
					System.out.println("인서트업파일 에러");
				}
			}
		}

		return resultU;
	}
	
	@Override
	public List<BoardFile> selectUpFileList(int boardNo){
		return boardDao.selectUpfileList(boardNo);
	}
	
	@Override
	public int deleteUpfile(int boardNo, String serverFolderPath) {
		
		List<BoardFile> dbList = boardDao.selectUpfileList(boardNo); //db에서 꺼내온 기존 파일 리스트
		
		if(dbList != null) { 
			/* 실제 폴더에 있는 파일 삭제 */
			for(BoardFile file : dbList) {
				File deleteFile = new File(serverFolderPath + file.getChangeFile());
				if (deleteFile.exists()) { // 파일이 존재하면
					deleteFile.delete();// 파일 삭제
				}
			}
		}
		return boardDao.deleteUpfile(boardNo);
	}
	
	@Override
	public int selectDeptCode(int userNo) {
		return boardDao.selectDeptCode(userNo);
	}
	
}
