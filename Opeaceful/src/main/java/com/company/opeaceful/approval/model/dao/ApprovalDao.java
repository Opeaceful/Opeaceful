package com.company.opeaceful.approval.model.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	    params.put("refType", refType); // 테이블 타입 form , approval, memo
	    params.put("refNo", refNo); // 참조 문서 no
	    params.put("usage", usage); // 본문용 content, 첨부용 attachment
		
	    return sqlSession.selectList( "aprMapper.selectFileList", params);
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
		    
			result =  sqlSession.insert("aprMapper.insertFavor", params);
	    }
	    return result;
	}
	
//	-------------------------------- update 구간 ----------------------------------------
	
	// 폼 업데이트
	public int updateForm(ApprovalForm form) {
		return sqlSession.update("aprMapper.updateForm", form);
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

	// 파일들 삭제
	public int deleteFileList( List<ApprovalFile> fileList) {
		return sqlSession.delete("aprMapper.deleteFileList", fileList);
	}


	// 즐겨찾기 삭제
	public int deleteFavor(int favorNo) {
		int result = sqlSession.delete("aprMapper.deleteFavor", favorNo);
		if(result > 0) {
			result =  sqlSession.delete("aprMapper.deleteActualFavor", favorNo);
		}
		return result;
	}













}
