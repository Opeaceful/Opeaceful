package com.company.opeaceful.commom.scheduling;

import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.member.model.service.MemberService;

@Component
public class Scheduling {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ApprovalService aprService;
	
	@Autowired
	private ServletContext servletContext;
	
	
	@Autowired
	public Scheduling(ApprovalService aprService, ServletContext servletContext,MemberService memberService) {
		this.aprService = aprService;
        this.servletContext = servletContext;
        this.memberService = memberService;
    }
	
	//[지영] 퇴사한지 3년 넘은 데이터들 삭제 (매달 1일에 체크)
	public void deleteMembers() {

		List<Integer> delist = memberService.resignedmemberList();
		
		if(delist.size()>0) {//삭제할 데이터가있다면
			
			//Approval 먼저 삭제! 
			 for (Integer uesrNo : delist) {
			       List<Integer> alist = memberService.resignedmemberApprovalList(uesrNo);
			       for (Integer appNo : alist) {
			    	   deleteMemberApproval(appNo);
			    	  
			       }
		      }
		
			 memberService.deleteMembers(delist);
			
			
				
		}

	}
		
	//Approval삭제용 메소드 
	public void deleteMemberApproval(Integer approvalNo) {
		// 파일 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = servletContext.getRealPath(webPath);
		
		
		// 결재문서 삭제 (실제 결재라인, 메모 모두 같이 삭제) + 실제 저장된 파일들 삭제 
		int result = aprService.deleteApproval(approvalNo, serverFolderPath);
		
		System.out.println(result+"======삭제된 문서 숫자======");
		
	}
	
	
	

}
