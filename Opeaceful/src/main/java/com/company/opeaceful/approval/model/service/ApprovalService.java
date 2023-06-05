package com.company.opeaceful.approval.model.service;

import java.util.List;

import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;

//(승은)
public interface ApprovalService {
	

	List<ApprovalForm> selectFormList(int currentPage, int type);
	
	List<ApprovalForm> selectFormListAll();

	ApprovalForm selectForm(int formNo);
	
	List<ApprovalFile> selectFileList(String refType, int refNo, String usage);

	int insertForm(ApprovalForm form, List<ApprovalFile> fileList );

	int insertFile(List<ApprovalFile> fileList, String refType, int refNo);

	int updateForm(ApprovalForm form, List<ApprovalFile> fileList);
	
	int deleteForm(int formNo);
	
	int deleteFile(List<ApprovalFile> fileList);
}
