package com.company.opeaceful.approval.model.service;

import java.util.List;

import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
import com.company.opeaceful.approval.model.vo.ApprovalMemo;

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

		// [지의] 해당 유저 연차 조회
		List<Approval> selectUserApproval(int userNo);
		
	Approval selectApproval(int approvalNo);
		
	List<Approval> selectApprovalList(int userNo, Integer status, int type, int year, int page , boolean isAdmin);
	
	int selectApprovalListCount(int userNo, Integer status, int type, int year, boolean isAdmin );
	
	List<Approval> selectApprovalListforAuthorize(int userNo, String menu, Integer status, int type, int year, int page );

	int selectApprovalListforAuthorizeCount(int userNo, String menu, Integer status, int type, int year  , boolean isNotCheck);
	
	List<Approval> selectApprovalListforRefer(int userNo, Integer status, int year, int page );

	int selectApprovalListforReferCount(int userNo, Integer status, int year  , boolean isNotCheck);
	
	List<ApprovalMemo> selectMemoList(int approvalNo);
	
	ApprovalMemo selectMemo(int memoNo);
	
	String selectSignImg(int userNo);
	
//----------------- insert ---------------------------------------
	
	int insertForm(ApprovalForm form, List<ApprovalFile> fileList );

	int insertFile(List<ApprovalFile> fileList, String refType, int refNo);
	
	int insertApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList);
	
	int insertFavor(ApprovalFavor favor, List<ApprovalLine> lines);
	
	int insertMemo(ApprovalMemo memo , List<ApprovalFile> fileList);
	
	int insertSignImg(int userNo, String changeName);
	
//----------------- update ---------------------------------------

	int updateForm(ApprovalForm form, List<ApprovalFile> fileList);
	
	int updateApproval(Approval approval, List<ApprovalLine> lineList, List<ApprovalFile> fileList);
	
	int updateApprovalStatus(int approvalNo, int status);
	
	int updateMemo(ApprovalMemo memo, List<ApprovalFile> fileList);
	
	int updateSignImg(int userNo, String changeName);
	
//----------------- delete ---------------------------------------
	
	int deleteForm(int formNo, String deleteFolderPath);
	
	int deleteApproval(int approvalNo, String deleteFolderPath);

	int deleteFileList(List<ApprovalFile> fileList);
	
	int deleteFavor(int favorNo);
	
	int deleteMemo(int memoNo);
}
