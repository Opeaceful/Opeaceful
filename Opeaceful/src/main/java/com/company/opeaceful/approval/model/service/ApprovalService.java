package com.company.opeaceful.approval.model.service;

import java.util.List;

import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.approval.model.vo.ApprovalLine;

//(승은)
public interface ApprovalService {
	

//-----------------select ---------------------------------------
	int selectFormListCount(int type);
	
	List<ApprovalForm> selectFormListPage(int currentPage, int type);
	
	List<ApprovalForm> selectFormList( int type);
	
	List<ApprovalForm> selectFormListAll();

	ApprovalForm selectForm(int formNo);
	
	List<ApprovalFile> selectFileList(String refType, int refNo, String usage);
	
	List<ApprovalFavor> selectFavorList(int userNo);
	
	List<ApprovalLine> selectLineList(String type, int no);

//----------------- insert ---------------------------------------
	
	int insertForm(ApprovalForm form, List<ApprovalFile> fileList );

	int insertFile(List<ApprovalFile> fileList, String refType, int refNo);
	
	int insertFavor(ApprovalFavor favor, List<ApprovalLine> lines);
	
//----------------- update ---------------------------------------

	int updateForm(ApprovalForm form, List<ApprovalFile> fileList);
	
//----------------- delete ---------------------------------------
	
	int deleteForm(int formNo, String deleteFolderPath);
	
	int deleteFileList(List<ApprovalFile> fileList);
	
	int deleteFavor(int favorNo);
}
