package com.company.opeaceful.approval.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.google.gson.Gson;

@Controller
@RequestMapping("/approval")

public class ApprovalController {
	
	
	private ApprovalService aprService;

	@Autowired
	public ApprovalController(ApprovalService aprService) {
		this.aprService = aprService;
	}
	

	@GetMapping("/allApproval")
	public String allApproval(){
		return "approval/allApproval";
	}
	
	@GetMapping("/myApproval")
	public String myApproval(){
		return "approval/myApproval";
	}
	
	// ajax용 즐겨찾기 리스트 조회
	@ResponseBody
	@PostMapping("/selectFavorList")
	public String selectFavorList() {
		
		List<ApprovalFavor> list = aprService.selectFavorList(1);

		return new Gson().toJson(list);
	}
	
	// ajax용 결재라인 조회 (타입별로 즐겨찾기용 == "favor"  , 실제 결재문서용 조회해오기 == "approval")
	@ResponseBody
	@PostMapping("/selectLineList")
	public String selectLineList(String type, Integer no) {
		
		List<ApprovalLine> list = aprService.selectLineList(type, no);

		return new Gson().toJson(list);
	}
	
	
	// ajax용 결재문서 저장
	@ResponseBody
	@PostMapping("/insertApproval")
	public int insertApproval(  @ModelAttribute	 Approval approval, 
								@RequestParam(value="images", required = false) MultipartFile[]  imgList,
								@RequestParam(value="files", required = false) MultipartFile[]  fileList,
								@RequestParam(value="userNoList") int[] userNoList,
								@RequestParam(value="levelList") int[] levelList,
								@RequestParam(value="typeList") String[] typeList,
								HttpSession session
							) {
		
		// 나중에 로그인한 유저 값으로 변경
		approval.setUserNo(1);
		
		//------------------------ 결재라인 저장 구역 --------------------------------
		// 결재라인 저장용
		List<ApprovalLine> lines = new ArrayList<>();
		
		// 첫번째 결재자 찾는 용도
		int firstA = 999;
		
		for(int i= 0; i< userNoList.length; i++) {
			ApprovalLine line = new ApprovalLine();
			line.setLevel(levelList[i]);
			line.setUserNo(userNoList[i]);
			line.setType(typeList[i]);
			
			int status = 0; // == 기본상태임
			if(typeList[i].equals("A")) {
				// 결재자면서 가장 첫번째인 사람 찾는용도
				if( levelList[i] < firstA ) {
					firstA = levelList[i];
				}
			}else {
				// 만약 참조자라면 기본적으로 상태 승인상태
				status= 2;
			}
			line.setStatus(status);

			lines.add(line);
		}
		
		if(firstA <= lines.size()) {			
			// 가장 첫번째 결재자 상태 대기상태로 변경
			lines.get(levelList[firstA]).setStatus(1);
			System.out.println(lines.get(levelList[firstA]).getStatus());
			
			// 결재자가 존재하는 문서이므로 임시저장용이 아니면 문서상태 진행중으로 저장
			if(approval.getStatus() != 2) {
				approval.setStatus(0);
			}
		}else {
			// 결재자 없이 참조자만있는 문서라는 뜻이므로 임시저장용이 아니면 문서상태 완료로 찍어야함
			if(approval.getStatus() != 2) {
				approval.setStatus(1);
				
				// todo! 결재문서 완료처리되면 자동으로 이름이랑 서명칸 이미지 저장시켜야함
				// 리턴값에 변화를 줘서 앞단에서 처리하는게 좋을 듯
			}
		}
		
		//------------------------ 본문 이미지 저장 구역 --------------------------------
		String content = approval.getContent();

		List<ApprovalFile> saveList = new ArrayList<>();
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		
		if(imgList != null && imgList.length > 0) {
			for(int i=0; i< imgList.length; i++) {
				String src = "src=\""+i+"\""; 
				String changeName;
				
				try {
					changeName = FileRenamePolicy.saveFile( imgList[i] , serverFolderPath);
					content = content.replace(src,"src=\""+changeName+"\"");
					
					saveList.add(new ApprovalFile( "approval" , null ,changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		approval.setContent(content);
		
		//------------------------ 첨부파일 저장구역 --------------------------------
		
		if(fileList != null && fileList.length > 0) {
			for(int i=0; i< fileList.length; i++) {
				try {
					String originName = fileList[i].getOriginalFilename();
					String changeName = FileRenamePolicy.saveFile( fileList[i] , serverFolderPath);
					
					saveList.add(new ApprovalFile("approval" , originName ,changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		
		// todo! 결재문서 저장되고 임시저장용이 아니라면 다음 상대한테 알림 날려야함!
		int result = aprService.insertApproval(approval, lines , saveList);
		
		return result;
	}
	
	
	
	// ajax용 즐겨찾기 저장
	@ResponseBody
	@PostMapping("/insertFavor")
	public int insertFavor( @RequestParam(value="userNoList", required = false) int[] userNoList,
							@RequestParam(value="levelList", required = false) int[] levelList,
							@RequestParam(value="typeList", required = false) String[] typeList,
							String title
							) {
		
		List<ApprovalLine> lines = new ArrayList<>();
		
		for(int i= 0; i< userNoList.length; i++) {
			ApprovalLine line = new ApprovalLine();
			line.setLevel(levelList[i]);
			line.setUserNo(userNoList[i]);
			line.setType(typeList[i]);
			
			lines.add(line);
		}
		
		ApprovalFavor favor = new ApprovalFavor();
		favor.setTitle(title);
		favor.setUserNo(1);
		
		int result = aprService.insertFavor(favor, lines);

		return result;
	}
	
	
	// 즐겨찾기 삭제
	@ResponseBody
	@PostMapping("/deleteFavor")
	public int deleteFavor(Integer favorNo) {
		
		int result = aprService.deleteFavor(favorNo);

		return result;
	}
	
	
	
}
