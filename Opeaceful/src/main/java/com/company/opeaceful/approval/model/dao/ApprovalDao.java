package com.company.opeaceful.approval.model.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
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
	
	// 타입별 폼 리스트 조회 
	public List<ApprovalForm> selectFormList(int type){
		return sqlSession.selectList("aprMapper.selectFormList", type);
	};
	
	
	// 폼 리스트 조회(페이지용)
	public List<ApprovalForm> selectFormListPage(PageInfo pi, int type){
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
	    params.put("refType", refType); // 테이블 타입 form , approval, memo, approval-memo
	    params.put("refNo", refNo); // 참조 문서 no
	    params.put("usage", usage); // 본문용 content, 첨부용 attachment
		
	    return sqlSession.selectList( "aprMapper.selectFileList", params);
	}
	
	// [지의] 해당 유저 연차 조회
	public List<Approval> selectUserApproval(int userNo) {
		return sqlSession.selectList("aprMapper.selectUserApproval", userNo);
	}
	
	
	// 즐겨찾기 리스트 조회용
	public List<ApprovalFavor> selectFavorList(int userNo) {
		return sqlSession.selectList("aprMapper.selectFavorList",userNo);
	}

	// 결재라인 조회용 (타입별로 즐겨찾기용 == "favor"  , 실제 결재문서용 조회해오기 == "approval")
	public List<ApprovalLine> selectLineList(String type, int no) {
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("no", no);
		return sqlSession.selectList("aprMapper.selectLineList", map);
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
	
	
	// 결재문서 등록
	public int insertApproval(Approval approval, List<ApprovalLine> lines) {
		int result = sqlSession.insert("aprMapper.insertApproval", approval);
		
		if (result > 0) {
			Map<String, Object> params = new HashMap<>();
			params.put("approvalNo", approval.getApprovalNo());
			params.put("lines", lines);

			result = sqlSession.insert("aprMapper.insertApprovalLine", params);
			
			if(result > 0 ) {
				result = approval.getApprovalNo();
			}
		}
		
	    return result;
	}
	
	// 파일 등록
	public int insertFile(List<ApprovalFile> fileList, String refType, int refNo ) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("fileList", fileList);
	    params.put("refType", refType);
	    params.put("refNo", refNo);
		
	    return sqlSession.insert("aprMapper.insertFile", params);
	};


	// 즐겨찾기 추가
	public int insertFavor(ApprovalFavor favor, List<ApprovalLine> lines) {
	    int result = sqlSession.insert("aprMapper.insertFavor", favor);
	    
	    if(result > 0) {
		    Map<String, Object> params = new HashMap<>();
		    params.put("favorNo", favor.getLineNo());
		    params.put("lines", lines);
		    
			result =  sqlSession.insert("aprMapper.insertFavorActualLine", params);
	    }
	    return result;
	}
	
//	-------------------------------- update 구간 ----------------------------------------
	
	// 폼 업데이트
	public int updateForm(ApprovalForm form) {
		return sqlSession.update("aprMapper.updateForm", form);
	};
	
	// 결재문서 업데이트
	public int updateApproval(Approval approval, List<ApprovalLine> lines) {
		int result = sqlSession.update("aprMapper.updateApproval", approval);
		int result2 = deleteApprovalLine(approval.getApprovalNo());
		
		if(result*result2 > 0) {
		    Map<String, Object> params = new HashMap<>();
		    params.put("approvalNo", approval.getApprovalNo());
		    params.put("lines", lines);
		    
			result =  sqlSession.insert("aprMapper.insertApprovalLine", params);
	    }
	    return result;
	};
	
//	-------------------------------- delete 구간 ----------------------------------------

	// 폼 + 실제 저장된 파일들 삭제
	public int deleteForm(int formNo,  String deleteFolderPath) {
		int result = sqlSession.delete("aprMapper.deleteForm", formNo);
		if (result > 0) {
			List<ApprovalFile> fileList = selectFileList("form", formNo, "all");
			if (fileList.size() > 0) {
				// 파일 리스트 실제 파일들 삭제
				for (ApprovalFile file : fileList) {
					File deleteFile = new File(deleteFolderPath + file.getChangeName());
					if (deleteFile.exists()) { // 파일이 존재하면
						deleteFile.delete();// 파일 삭제
					}
				}
				result = deleteFileList(fileList);
			}
		}

		return result;
	};
	
	
	// 결재문서 + 실제 저장된 파일들 삭제
	public int deleteApproval(int approvalNo,  String deleteFolderPath) {
		
		// todo! 나중에 결재문서 다시 조회해 와서 만약 결재라인 이미지 값 있으면 그것도 삭제해야함
		int result = sqlSession.delete("aprMapper.deleteApproval", approvalNo);
		if (result > 0) {
			List<ApprovalFile> fileList = selectFileList("approval-memo", approvalNo, "all");
			if (fileList.size() > 0) {
				// 파일 리스트 실제 파일들 삭제
				for (ApprovalFile file : fileList) {
					File deleteFile = new File(deleteFolderPath + file.getChangeName());
					if (deleteFile.exists()) { // 파일이 존재하면
						deleteFile.delete();// 파일 삭제
					}
				}
				result = deleteFileList(fileList);
			}
		}

		return result;
	};
	

	// 파일들 삭제
	public int deleteFileList( List<ApprovalFile> fileList) {
		return sqlSession.delete("aprMapper.deleteFileList", fileList);
	}


	// 즐겨찾기 삭제
	public int deleteFavor(int favorNo) {
		// 즐겨찾기 삭제 시 ON DELETE CASCADE설정 되어있기 때문에 
		// APPROVAL_ACTUAL_FAVORITE_LINE 쪽 데이터도 자동 삭제될것임
		return sqlSession.delete("aprMapper.deleteFavor", favorNo);
	}

	// 결재라인 삭제
	public int deleteApprovalLine(int approvalNo) {
		return sqlSession.delete("aprMapper.deleteApprovalLine", approvalNo);
	}











}
