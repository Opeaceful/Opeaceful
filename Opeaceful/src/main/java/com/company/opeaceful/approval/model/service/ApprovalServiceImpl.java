package com.company.opeaceful.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.approval.model.dao.ApprovalDao;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
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
	public List<ApprovalForm> selectFormList(int currentPage, int type) {
		
		int listCount = aprDao.selectFormListCount(type);
		int pageLimit = 10;
		int itemLimit = 10; // 최대 10개 가져오기
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, itemLimit);
		
		return aprDao.selectFormList(pi, type);
	}

	@Override
	public ApprovalForm selectForm(int formNo) {
		return aprDao.selectForm(formNo);
	}
	
	
	@Override
	public List<ApprovalFile> selectFileList(String refType, int refNo, String usage) {
		return aprDao.selectFileList( refType,  refNo,  usage);
	}

	
//	-------------------------------- insert 구간 ----------------------------------------
	@Override
	public int insertForm(ApprovalForm form, List<ApprovalFile> fileList ) {
		
		int result = aprDao.insertForm(form);
		if(result > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "form", result);
		}
		
		return result;
	}

	@Override
	public int insertFile(List<ApprovalFile> fileList, String refType, int refNo )  {
		return aprDao.insertFile(fileList, refType, refNo);
	}

	
//	-------------------------------- update 구간 ----------------------------------------
	@Override
	public int updateForm(ApprovalForm form, List<ApprovalFile> fileList) {
		
		int result = aprDao.updateForm(form);
		if(result > 0 && fileList.size() > 0) {
			result = insertFile(fileList, "form", result);
		}
		
		return result;
	}
	
	
//	-------------------------------- delete 구간 ----------------------------------------

	@Override
	public int deleteForm(int formNo,  String deleteFolderPath) {
		return aprDao.deleteForm(formNo, deleteFolderPath);
	}

	@Override
	public int deleteFileList( List<ApprovalFile> fileList) {
		return aprDao.deleteFileList(fileList);
	}








}
