package com.company.opeaceful.approval.model.service;

import java.util.ArrayList;

import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;

//(승은)
public interface ApprovalService {

	ArrayList<ApprovalForm> selectFormList();
	ApprovalForm selectForm(int formNo);
	
	int insertForm(ApprovalForm form);
	int insertFile(ApprovalFile file);
	
	int updateForm(ApprovalForm form);
}
