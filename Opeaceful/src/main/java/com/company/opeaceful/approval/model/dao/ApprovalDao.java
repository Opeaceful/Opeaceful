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
import com.company.opeaceful.approval.model.vo.ApprovalMemo;
import com.company.opeaceful.calendar.model.vo.Calendar;
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
	    params.put("usage", usage); // 본문용 content, 첨부용 attachment, 전체 all
		
	    return sqlSession.selectList( "aprMapper.selectFileList", params);
	}
	
	// [지의] 해당 유저 연차 조회
	public List<Approval> selectUserApproval(int userNo) {
		return sqlSession.selectList("aprMapper.selectUserApproval", userNo);
	}
	
	// 유저 연차 조회(진행중, 완결 모두 다) 
	public List<Approval> selectUserApprovalAll(int userNo) {
		return sqlSession.selectList("aprMapper.selectUserApprovalAll", userNo);
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
	
//	// 결재 문서리스트 조회용(terms -> 유저번호, 연도, 타입, 상태, 페이지번호 들어있음 한페이지당 10개 표시 예정)
//	public List<Approval> selectApprovalList( Map<String, Integer> terms) {
//		return sqlSession.selectList("aprMapper.selectApprovalList", terms);
//	}
//
//	// 결재 문서리스트 총개수 반환용(위의 함수와 같은 term을 받아 쓰지만 총개수용이라 페이지는 안쓰임 )
//	public int selectApprovalCount( Map<String, Integer> terms) {
//		return sqlSession.selectOne("aprMapper.selectApprovalCount",terms);
//	}
	
	
	// 개별 결재문서 조회용
	public Approval selectApproval(int approvalNo) {
		return sqlSession.selectOne("aprMapper.selectApproval", approvalNo);
	}

	// 결재문서 리스트 조회(isAdmin값이 false면 내가 기안한용  그외 전체유저조회용)
	public List<Approval> selectApprovalList(int userNo, Integer status, int type, int year, int page, boolean isAdmin) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("type", type);
		map.put("year", year);
		map.put("page", (page-1) * 10);
		map.put("isAdmin", isAdmin);
		
		return sqlSession.selectList("aprMapper.selectApprovalList" , map);
	}

	// 결재문서 리스트 총개수 조회(isAdmin값이 false면 내가 기안한용  그외 전체유저조회용)
	public int selectApprovalListCount(int userNo, Integer status, int type, int year, boolean isAdmin) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("type", type);
		map.put("year", year);
		map.put("isAdmin", isAdmin);
		return sqlSession.selectOne("aprMapper.selectApprovalListCount" , map);
	}

	// 승인대기/결재 메뉴용 리스트 조회
	public List<Approval> selectApprovalListforAuthorize(int userNo, String menu, Integer status, int type, int year, int page) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("menu", menu);
		map.put("type", type);
		map.put("year", year);
		map.put("page", (page-1) * 10);
		
		return sqlSession.selectList("aprMapper.selectApprovalListforAuthorize" , map);
	}

	// 승인대기/결재 메뉴용 리스트 총개수 조회
	public int selectApprovalListforAuthorizeCount(int userNo, String menu, Integer status, int type, int year , boolean isNotCheck) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("menu", menu);
		map.put("type", type);
		map.put("year", year);
		map.put("isNotCheck", isNotCheck);

		return sqlSession.selectOne( "aprMapper.selectApprovalListforAuthorizeCount" , map);
	}

	// 참조인용 결재문서 리스트 조회
	public List<Approval> selectApprovalListforRefer(int userNo, Integer status, int year, int page, int type) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("year", year);
		map.put("page", (page-1)* 10);
		map.put("type", type);
		return sqlSession.selectList("aprMapper.selectApprovalListforRefer" , map);
	}

	// 참조인용 결재문서 리스트 총개수 조회
	public int selectApprovalListforReferCount(int userNo, Integer status, int year, int type , boolean isNotCheck) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("status", status);
		map.put("year", year);
		map.put("type", type);
		map.put("isNotCheck", isNotCheck);
		
		return sqlSession.selectOne("aprMapper.selectApprovalListforReferCount" , map);
	}
	
	
	// 메모 리스트 조회용
	public List<ApprovalMemo> selectMemoList(int approvalNo) {
		return sqlSession.selectList("aprMapper.selectMemoList" , approvalNo);
	}

	// 메모 디테일 조회용
	public ApprovalMemo selectMemo(int memoNo) {
		return sqlSession.selectOne("aprMapper.selectMemo" , memoNo);
	}
	
	
	// 서명 이미지 조회용
	public String selectSignImg(int userNo) {
		return sqlSession.selectOne("aprMapper.selectSignImg" , userNo);
	}
	
	// 결재문서 서치 리스트 조회용 (관리권한가진 유저용임)
	public List<Approval> searchApprovalList(int userNo, int year, Integer status, int type, String keyword, int page ){
		Map<String, Object> params = new HashMap<>();
		params.put("userNo", userNo);
		params.put("year", year);
		params.put("status", status);
		params.put("type", type);
		params.put("page",(page-1) * 10);
		
		if(keyword==null || keyword.isBlank()) {
			params.put("keyword", null);
		}else {
			// like문에 들어갈 문자열 혹시 모를 _ 와 % escape 처리 
			keyword = keyword.replaceAll("%", "^%");
			keyword = keyword.replaceAll("_", "^_");

			String keyword1 = keyword+"%";
			String keyword2 = "%"+keyword;
			String keyword3 = "%"+keyword+"%";
			
			params.put("keyword", keyword);
			params.put("keyword1", keyword1);
			params.put("keyword2", keyword2);
			params.put("keyword3", keyword3);
		}
		
		
		return sqlSession.selectList("aprMapper.searchApprovalList" , params);
	}
	
	
	// 결재문서 서치 리스트 총개수 조회용 (관리권한가진 유저용임)
	public int searchApprovalListCount(int userNo, int year, Integer status, int type, String keyword ){
		Map<String, Object> params = new HashMap<>();
		params.put("userNo", userNo);
		params.put("year", year);
		params.put("status", status);
		params.put("type", type);
		
		if(keyword==null ||keyword.isBlank()) {
			params.put("keyword", null);
		}else {
			// like문에 들어갈 문자열 혹시 모를 _ 와 % escape 처리 
			keyword = keyword.replaceAll("%", "^%");
			keyword = keyword.replaceAll("_", "^_");
			keyword = "%"+keyword+"%";
			params.put("keyword", keyword);
		}
		
		return sqlSession.selectOne("aprMapper.searchApprovalListCount" , params);
	}


	
	
	/* [혜린 - 캘린더용 연차 일정 조회] */
	public Approval selectAddEvent(int approvalNo) {
		return sqlSession.selectOne("aprMapper.selectAddEvent", approvalNo);
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
			int approvalNo = approval.getApprovalNo();
			Map<String, Object> params = new HashMap<>();
			params.put("approvalNo", approvalNo);
			params.put("lines", lines);

			result = sqlSession.insert("aprMapper.insertApprovalLine", params);
			
			if(result > 0 ) {
				// 만약 라인들 저장도 성공하면 리턴값에 현재 등록된 결재문서 no 값 넣어 반환
				result = approvalNo;
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
	
	// 메모 추가
	public int insertMemo(ApprovalMemo memo, List<ApprovalFile> fileList) {
		int result = sqlSession.insert("aprMapper.insertMemo", memo);
		if (result > 0 ) {
			result = memo.getMemoNo();
		}
		
	    return result;
	}

	
	// 서명 이미지 추가용
	public int insertSignImg(int userNo, String changeName) {
		Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("changeName", changeName);
		
		return sqlSession.insert("aprMapper.insertSignImg" , params);
	}
	
	/* [혜린 - 캘린더 연차 일정 추가] */
	public int insertEvent(Calendar calendar) {
		return sqlSession.insert("calendarMapper.insertEvent", calendar);
	}
	
	
//	-------------------------------- update 구간 ----------------------------------------
	
	// 폼 업데이트
	public int updateForm(ApprovalForm form) {
		return sqlSession.update("aprMapper.updateForm", form);
	};
	
	// 결재문서 업데이트
	public int updateApproval(Approval approval, List<ApprovalLine> lines) {
		// 기존 라인 삭제
		int result = deleteApprovalLine(approval.getApprovalNo());

		if(result > 0) {
			Map<String, Object> params = new HashMap<>();
		    params.put("approvalNo", approval.getApprovalNo());
		    params.put("lines", lines);
		    
		    // 신규 결재라인 추가
			result =  sqlSession.insert("aprMapper.insertApprovalLine", params);
			if(result > 0 ) {
				// 위의 모든것이 성공하면 결재문서 업데이트
				result = sqlSession.update("aprMapper.updateApproval", approval);
			}
	    }
		
	    return result;
	};
	
	// 결재문서 완결처리
	public int updateApprovalStateEnd(Approval approval) {
		int result = sqlSession.update("aprMapper.updateApprovalStateEnd", approval);
		
	    return result;
	};
	
	
	// 결재문서 상태값 업데이트
	public int updateApprovalStatus(int approvalNo, int status) {
		Map<String, Object> params = new HashMap<>();
	    params.put("approvalNo", approvalNo);
	    params.put("status", status);
		
	    return sqlSession.update("aprMapper.updateApprovalStatus",params);
	}
	
	
	// 결재자가 결재 후 다음 결재라인들 상태 변경 (다음결재자 상태1 , 다음결재자 전단계의 참조자들 상태3) 
	public int updateNextLinesStatus(int approvalNo, int nextAuthorizeLevel, int myLevel) {
		Map<String, Object> params = new HashMap<>();
	    params.put("approvalNo", approvalNo);
	    params.put("nextAuthorizeLevel", nextAuthorizeLevel);
	    params.put("myLevel", myLevel);
		
	    return sqlSession.update("aprMapper.updateNextLinesStatus",params);
	}
	
	// 결재자가 반려처리 했을경우 본인 결재라인 상태 -1로 변경 
	public int updateLineStatusReturn(int approvalNo, int userNo) {
		Map<String, Object> params = new HashMap<>();
	    params.put("approvalNo", approvalNo);
	    params.put("userNo", userNo);
		return sqlSession.update("aprMapper.updateLineStatusReturn",params);
	}
	
	
	// 결재라인 상태값 읽음으로 업데이트
	public int updateApprovalLineReadStatus(int approvalNo, int userNo) {
		Map<String, Object> params = new HashMap<>();
	    params.put("approvalNo", approvalNo);
	    params.put("userNo", userNo);
		
	    return sqlSession.update("aprMapper.updateApprovalLineReadStatus",params);
	}
	

	
	// 메모 업데이트
	public int updateMemo(ApprovalMemo memo) {
		return sqlSession.update("aprMapper.updateMemo",memo);
	}
	
	
	// 서명 이미지 업데이트
	public int updateSignImg(int userNo, String changeName) {
		Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("changeName", changeName);
		
		return sqlSession.update("aprMapper.updateSignImg" , params);
	}
	
	
	
	
	
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
	
	
	//  결재문서 삭제 (실제 결재라인, 메모 모두 같이 삭제) + 실제 저장된 파일들 삭제 
	public int deleteApproval(int approvalNo,  String deleteFolderPath) {
		
		// 결재라인은 fk로 연결되어있어서 결재문서 삭제되면 알아서 다 날아감
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
	

	// 결재라인 삭제 (결재번호 받아서 해당 결재번호에 등록되어있던 결재라인 모두삭제)  
	public int deleteApprovalLine(int approvalNo) {
		return sqlSession.delete("aprMapper.deleteApprovalLine", approvalNo);
	}

	
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


	// 메모 삭제
	public int deleteMemo(int memoNo) {
		return sqlSession.delete("aprMapper.deleteMemo", memoNo);
	}
	
	/* [혜린 - 캘린더 취소 연차 일정 삭제] */
	public int deleteApvEvent(Calendar calendar) {
		return sqlSession.delete("calendarMapper.deleteApvEvent", calendar);
	}










}
