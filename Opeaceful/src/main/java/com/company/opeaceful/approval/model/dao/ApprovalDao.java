package com.company.opeaceful.approval.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.commom.model.vo.PageInfo;

//(승은)
@Repository
public class ApprovalDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
//	-------------------------------- selelct 구간 ----------------------------------------
	

	
	// 폼 개수 조회
	public int selectFormListCount(int type) {
		return sqlSession.selectOne("aprMapper.selectFormListCount", type);
	}
	
	// 폼 리스트전체 조회
	public List<ApprovalForm> selectFormListAll(){
		return sqlSession.selectList("aprMapper.selectFormListAll");
	};
	
	
	// 폼 리스트 조회
	public List<ApprovalForm> selectFormList(PageInfo pi, int type){
		//폼은 최대개수가 별로 많이 늘어나지 않을 요소라 구현하기 편하지만 느린 RowBounds 사용해봄
		int offset  = (pi.getCurrentPage() -1) * pi.getSettingLimit();
		int limit = pi.getSettingLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("aprMapper.selectFormList", type, rowBounds);
	};
	
	// 개별 폼 조회
	public ApprovalForm selectForm(int formNo) {
		return sqlSession.selectOne("aprMapper.selectForm", formNo);
	};
	
	
	// 저장된 파일리스트 조회(본문용, 첨부용선택)
	public List<ApprovalFile> selectFileList(String refType, int refNo, String usage) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("refType", refType); // 테이블 타입 form , approval, memo
	    params.put("refNo", refNo); // 참조 문서 no
	    params.put("usage", usage); // 본문용 content, 첨부용 attachment
		
	    return sqlSession.selectList( "aprMapper.selectForm", params);
	}
	
	
//	-------------------------------- insert 구간 ----------------------------------------
	
	// 폼 등록
	public int insertForm(ApprovalForm form) {
		int result = sqlSession.insert("aprMapper.insertForm", form);
		if (result > 0 ) {
			result = form.getFormNo();
		}
		return result;
	};
	
	// 파일 등록
	public int insertFile(List<ApprovalFile> fileList, String refType, int refNo ) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("fileList", fileList);
	    params.put("refType", refType);
	    params.put("refNo", refNo);
		
	    return sqlSession.insert("aprMapper.insertFile", params);
	};

	
//	-------------------------------- update 구간 ----------------------------------------
	
	// 폼 업데이트
	public int updateForm(ApprovalForm form) {
		return sqlSession.update("aprMapper.updateForm", form);
	};
	
	
//	-------------------------------- delete 구간 ----------------------------------------

	// 폼 삭제
	public int deleteForm(int formNo) {
		int result = sqlSession.delete("aprMapper.deleteForm", formNo);
		if (result > 0) {
			List<ApprovalFile> fileList = selectFileList("form", formNo, "all");
			if (fileList.size() > 0) {
				result = deleteFile(fileList);
			}
		}

		return result;
	};

	// 파일들 삭제
	public int deleteFile( List<ApprovalFile> fileList) {
		return sqlSession.delete("aprMapper.deleteFile", fileList);
	}















}
