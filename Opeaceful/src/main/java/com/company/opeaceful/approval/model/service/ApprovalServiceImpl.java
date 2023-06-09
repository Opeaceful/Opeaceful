package com.company.opeaceful.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.approval.model.dao.ApprovalDao;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
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
	public List<ApprovalFavor> selectFavorList(int userNo) {
		return aprDao.selectFavorList(userNo);
	}

	@Override
	public List<ApprovalLine> selectLineList(String type, int no) {
		return aprDao.selectLineList(type, no);
	}
	
//	-------------------------------- insert 구간 ----------------------------------------
	@Override
	public int insertForm(ApprovalForm form, List<ApprovalFile> fileList ) {
		int result = 0;
		int formNo = aprDao.insertForm(form);
		if(formNo > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "form", formNo);
		}
		
		return result;
	}
	
	@Override
	public int insertApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList) {
		int result = 0;
		int approvalNo = aprDao.insertApproval(approval, lineList);
		if(approvalNo > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "approval", approvalNo);
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

	
//	-------------------------------- update 구간 ----------------------------------------
	@Override
	public int updateForm(ApprovalForm form, List<ApprovalFile> fileList) {
		int result = 0;
		int formNo = aprDao.updateForm(form);
		if(formNo > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "form", formNo);
		}
		
		return result;
	}
	
	@Override
	public int updateApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList) {
		int result = 0;
		int approvalNo = aprDao.updateApproval(approval, lineList);
		if(approvalNo > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "approval", approvalNo);
		}
		return result;
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
















}
