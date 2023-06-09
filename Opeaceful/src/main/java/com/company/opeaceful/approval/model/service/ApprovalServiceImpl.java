package com.company.opeaceful.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.company.opeaceful.approval.model.dao.ApprovalDao;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
import com.company.opeaceful.approval.model.vo.ApprovalMemo;
import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;

//(승은)
@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	private ApprovalDao aprDao;
	private Pagination pagination;
	
	

	@Autowired
	public ApprovalServiceImpl(ApprovalDao aprDao, Pagination pagination) {
		super();
		this.aprDao = aprDao;
		this.pagination = pagination;
	}

//	-------------------------------- selelct 구간 ----------------------------------------
	
	
	@Override
	public int selectFormListCount(int type) {
		return  aprDao.selectFormListCount(type);
	}
	
	@Override
	public List<ApprovalForm> selectFormListAll() {
		return aprDao.selectFormListAll();
	}
	
	@Override
	public List<ApprovalForm> selectFormList(int type) {
		return aprDao.selectFormList( type);
	}
	
	@Override
	public List<ApprovalForm> selectFormListPage(int currentPage, int type) {
		
		int listCount = aprDao.selectFormListCount(type);
		int pageLimit = 10;
		int itemLimit = 10; // 최대 10개 가져오기
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, itemLimit);
		
		return aprDao.selectFormListPage(pi, type);
	}

	@Override
	public ApprovalForm selectForm(int formNo) {
		return aprDao.selectForm(formNo);
	}
	
	
	@Override
	public List<ApprovalFile> selectFileList(String refType, int refNo, String usage) {
		return aprDao.selectFileList( refType,  refNo,  usage);
	}
	
	// [지의] 해당 유저 연차 조회
	@Override
	public List<Approval> selectUserApproval(int userNo) {
		return aprDao.selectUserApproval(userNo);
	}
	
	@Override
	public List<Approval> selectUserApprovalAll(int userNo) {
		return aprDao.selectUserApprovalAll(userNo);
	}

	
	@Override
	public List<ApprovalFavor> selectFavorList(int userNo) {
		return aprDao.selectFavorList(userNo);
	}

	@Override
	public List<ApprovalLine> selectLineList(String type, int no) {
		return aprDao.selectLineList(type, no);
	}
	
	
	@Override
	public Approval selectApproval(int approvalNo) {
		return aprDao.selectApproval( approvalNo);
	}

	@Override
	public List<Approval> selectApprovalList(int userNo, Integer status, int type, int year, int page, boolean isAdmin) {
		return aprDao.selectApprovalList( userNo,  status,  type,  year,  page, isAdmin);
	}
 
	@Override
	public int selectApprovalListCount(int userNo, Integer status, int type, int year, boolean isAdmin) {
		return aprDao.selectApprovalListCount( userNo,  status,  type,  year,  isAdmin);
	}

	@Override
	public List<Approval> selectApprovalListforAuthorize(int userNo, String menu, Integer status, int type, int year, int page) {
		return aprDao.selectApprovalListforAuthorize( userNo, menu,  status,  type,  year,  page);
	}

	@Override
	public int selectApprovalListforAuthorizeCount(int userNo, String menu, Integer status, int type, int year, boolean isNotCheck) {
		return aprDao.selectApprovalListforAuthorizeCount( userNo, menu,  status,  type,  year, isNotCheck);
	}

	@Override
	public List<Approval> selectApprovalListforRefer(int userNo, Integer status, int year, int page, int type) {
		return aprDao.selectApprovalListforRefer( userNo,  status,  year,  page, type);
	}

	@Override
	public int selectApprovalListforReferCount(int userNo, Integer status, int year, int type , boolean isNotCheck) {
		return aprDao.selectApprovalListforReferCount( userNo,  status,  year, type ,isNotCheck);
	}
	
	
	@Override
	public List<ApprovalMemo> selectMemoList(int approvalNo) {
		return aprDao.selectMemoList(approvalNo);
	}

	@Override
	public ApprovalMemo selectMemo(int memoNo) {
		return aprDao.selectMemo(memoNo);
	}
	
	
	@Override
	public String selectSignImg(int userNo) {
		return aprDao.selectSignImg(userNo);
	}
	
	
	@Override
	public List<Approval> searchApprovalList(int userNo, int year, Integer status, int type, String keyword, int page) {
		return aprDao.searchApprovalList( userNo,  year,  status,  type,  keyword, page);
	}

	@Override
	public int searchApprovalListCount(int userNo, int year, Integer status, int type, String keyword) {
		return aprDao.searchApprovalListCount( userNo,  year,  status,  type,  keyword);
	}
	
	
	
	/* [혜린 - 캘린더용 연차 일정 조회] */
	@Override
	public Approval selectAddEvent(int approvalNo) {
		return aprDao.selectAddEvent(approvalNo);
	}
	
//	-------------------------------- insert 구간 ----------------------------------------
	@Override
	public int insertForm(ApprovalForm form, List<ApprovalFile> fileList ) {
		int formNo = aprDao.insertForm(form);
		if(formNo > 0 && fileList.size() > 0) {
			formNo = insertFile(fileList, "form", formNo);
		}
		
		return formNo;
	}
	
	@Override
	//service, service내부의 코드 수행시점에서 에러 발생시 자동 rollback이 된다
	@Transactional(rollbackFor = {Exception.class}) // 모든 종류의 예외가 발생하면 rollback 시기켔다고 선언한것
	public int insertApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList) {
		int result = 0;
		int approvalNo = aprDao.insertApproval(approval, lineList);
		if(approvalNo > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "approval", approvalNo);
		}else {
			// 저장할 파일리스트 없을 경우 approvalNo 반환
			result = approvalNo;
		}
		return result;
	}

	@Override
	public int insertFile(List<ApprovalFile> fileList, String refType, int refNo )  {
		return aprDao.insertFile(fileList, refType, refNo);
	}


	@Override
	public int insertFavor(ApprovalFavor favor, List<ApprovalLine> lines) {
		return aprDao.insertFavor(favor, lines);
	}
	
	@Override
	public int insertMemo(ApprovalMemo memo, List<ApprovalFile> fileList) {
		int result = 0;
		int memoNo = aprDao.insertMemo(memo, fileList);
		
		if(memoNo > 0 ) {
			result = memoNo;
			if(fileList.size() > 0) {
				result = insertFile(fileList, "memo", memoNo);
			}
		}
		return result;
	}

	
	@Override
	public int insertSignImg(int userNo, String changeName) {
		return aprDao.insertSignImg(userNo, changeName);
	}
	
	/* [혜린 - 캘린더 연차 일정 추가] */
	@Override
	public int insertEvent(Calendar calendar) {
		return aprDao.insertEvent(calendar);
	}
	
//	-------------------------------- update 구간 ----------------------------------------
	@Override
	public int updateForm(ApprovalForm form, List<ApprovalFile> fileList) {
		int result = aprDao.updateForm(form);
		if(result > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "form", form.getFormNo());
		}
		
		return result;
	}
	
	@Override
	public int updateApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList) {
		int result = aprDao.updateApproval(approval, lineList);
		if(result > 0 && fileList.size() > 0) {
			// 결재문서 업데이트가 잘 끝난 후 파일들도 저장 시작하기
			result = insertFile(fileList, "approval", approval.getApprovalNo());
		}
		return result;
	}
	
	@Override
	public int updateApprovalStatus(int approvalNo, int status) {
		return aprDao.updateApprovalStatus(approvalNo, status);
	}
	
	@Override
	public int updateNextLinesStatus(int approvalNo, int nextAuthorizeLevel, int myLevel) {
		return aprDao.updateNextLinesStatus(approvalNo, nextAuthorizeLevel, myLevel);
	}
	
	@Override
	public int updateApprovalStateEnd(Approval approval) {
		return aprDao.updateApprovalStateEnd(approval);
	}
	
	@Override
	public int updateLineStatusReturn(int approvalNo, int userNo) {
		return aprDao.updateLineStatusReturn(approvalNo , userNo);
	}
	
	
	@Override
	public int updateApprovalLineReadStatus(int approvalNo, int userNo) {
		return aprDao.updateApprovalLineReadStatus(approvalNo, userNo);
	}
	
	@Override
	public int updateMemo(ApprovalMemo memo, List<ApprovalFile> fileList) {
		int result = aprDao.updateMemo(memo);
		if(result > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "memo", memo.getMemoNo());
		}
		
		return result;
	}
	
	
	@Override
	public int updateSignImg(int userNo, String changeName) {
		return aprDao.updateSignImg(userNo, changeName);
	}
	
//	-------------------------------- delete 구간 ----------------------------------------

	@Override
	public int deleteForm(int formNo,  String deleteFolderPath) {
		return aprDao.deleteForm(formNo, deleteFolderPath);
	}
	
	@Override
	public int deleteApproval(int approvalNo, String deleteFolderPath) {
		return aprDao.deleteApproval(approvalNo, deleteFolderPath);
	}

	@Override
	public int deleteFileList( List<ApprovalFile> fileList) {
		return aprDao.deleteFileList(fileList);
	}

	@Override
	public int deleteFavor(int favorNo) {
		return aprDao.deleteFavor(favorNo);
	}


	@Override
	public int deleteMemo(int memoNo) {
		return aprDao.deleteMemo(memoNo);
	}

	@Override
	public int deleteApprovalLine(int approvalNo) {
		return aprDao.deleteApprovalLine(approvalNo);
	}
	
	/* [혜린 - 캘린더 취소 연차 일정 삭제] */
	@Override
	public int deleteApvEvent(Calendar calendar) {
		return aprDao.deleteApvEvent(calendar);
	}



	





	
























}
