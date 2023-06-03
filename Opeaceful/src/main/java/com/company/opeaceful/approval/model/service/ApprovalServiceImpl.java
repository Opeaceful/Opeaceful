package com.company.opeaceful.approval.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.approval.model.dao.ApprovalDao;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;

@Service
//(승은)
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private ApprovalDao aprDao;

	@Override
	public ArrayList<ApprovalForm> selectFormList() {
		return aprDao.selectFormList();
	}

	@Override
	public ApprovalForm selectForm(int formNo) {
		return aprDao.selectForm(formNo);
	}

	@Override
	public int insertForm(ApprovalForm form) {
		return aprDao.insertForm(form);
	}

	@Override
	public int insertFile(ApprovalFile file) {
		return aprDao.insertFile(file);
	}

	@Override
	public int updateForm(ApprovalForm form) {
		return aprDao.updateForm(form);
	}

}
