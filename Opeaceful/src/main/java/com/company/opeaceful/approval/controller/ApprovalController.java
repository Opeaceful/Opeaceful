package com.company.opeaceful.approval.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
import com.company.opeaceful.approval.model.vo.ApprovalMemo;
import com.company.opeaceful.calendar.controller.calendarController;
import com.company.opeaceful.calendar.model.service.CalendarService;
import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.vo.UserRole;
import com.google.gson.Gson;

@Controller
@RequestMapping("/approval")
@SessionAttributes({"loginUser", "loginUserRole"})
public class ApprovalController {
	
	
	private ApprovalService aprService;

	@Autowired
	public ApprovalController(ApprovalService aprService) {
		this.aprService = aprService;
	}
	

	@GetMapping("/allApproval")
	public String allApproval( @SessionAttribute("loginUserRole") List<UserRole> loginUserRole, Model model ){
		
		boolean roleCheck = false;
		for(UserRole role:loginUserRole) {
			if(role.getRoleCode().equals("T02")) {
				roleCheck = true;
				break;
			}
		}
		if(roleCheck == true) {
			int currentYear = Year.now().getValue();
			List<Approval> list = aprService.searchApprovalList(-1,currentYear, null, -1, null, 1 );
			int count  = aprService.searchApprovalListCount(-1, currentYear, null, -1, null);
			model.addAttribute("list", list);
			model.addAttribute("count", count);

			return "approval/allApproval";
		}else {
			model.addAttribute("errorMsg", "권한이 없는 사용자입니다.");
			return "errorPage";
		}
	}
	
	@GetMapping("/myApproval")
	public String myApproval(	@ModelAttribute("loginUser") Member loginUser,
								@RequestParam(name = "menu", required = false) String menu,
								Model model
								){
		int userNo= loginUser.getUserNo();
		int currentYear = Year.now().getValue();
		
		// todo! 반려건, 승인대기건 개수 조회해서 같이 넣어주기
		model.addAttribute("returnCount", aprService.selectApprovalListCount(userNo, -2 , -1, 0, false)  );
		model.addAttribute("waitCount", aprService.selectApprovalListforAuthorizeCount(userNo, "wait", 0 , -1, 0, true) );
		model.addAttribute( "referCount", aprService.selectApprovalListforReferCount(userNo, null, 0, -1,true));
		
		if(menu != null && menu.equals("wait")) {
			// 승인대기중인 메뉴로 선택
			model.addAttribute("menu", "wait");
			model.addAttribute("list", aprService.selectApprovalListforAuthorize(userNo, "wait", 0, -1, currentYear, 1));
			model.addAttribute("count", aprService.selectApprovalListforAuthorizeCount(userNo, "wait", 0 , -1, currentYear, false));
		}else {
			System.out.println("메뉴 null로 해서 들어옴");
			// 전체메뉴로 선택
			model.addAttribute("menu" , "all");
			model.addAttribute("list", aprService.selectApprovalList(userNo, null, -1, currentYear, 1, false));
			model.addAttribute("count", aprService.selectApprovalListCount(userNo, null, -1, currentYear, false));
		}
		return "approval/myApproval";
	}
	
	
	
	
	// ajax용 관리자 결재 리스트 서치용
	@ResponseBody
	@PostMapping("/searchApprovalList")
	public String searchApprovalList(	Integer userNo,
										Integer year,
										Integer type,
										Integer page,
										String status,
										String keyword
										) {
		Integer aprStatus = null;
		if (status != null && !status.equals("all")) {
			aprStatus = Integer.parseInt(status);
	    }
		
		if(userNo == null || userNo <= 0) {
			userNo = -1;
		}
		
		List<Approval> list = aprService.searchApprovalList(userNo,year, aprStatus, type, keyword, page );
		int count  = aprService.searchApprovalListCount(userNo, year, aprStatus, type, keyword);
		
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("count", count);

		return new Gson().toJson(result);
	}
	
	
	// ajax용 즐겨찾기 리스트 조회
	@ResponseBody
	@PostMapping("/selectFavorList")
	public String selectFavorList(@ModelAttribute("loginUser") Member loginUser) {
		
		List<ApprovalFavor> list = aprService.selectFavorList(loginUser.getUserNo());

		return new Gson().toJson(list);
	}
	
	// ajax용 결재라인 조회 (타입별로 즐겨찾기용 == "favor"  , 실제 결재문서용 조회해오기 == "approval")
	@ResponseBody
	@PostMapping("/selectLineList")
	public String selectLineList(String type, Integer no) {
		
		List<ApprovalLine> list = aprService.selectLineList(type, no);

		return new Gson().toJson(list);
	}
	
	
	// ajax용 로그인 유저 연차총개수 , 남은개수 조회 
	@ResponseBody
	@PostMapping("/selectUserAnnualInfo")
	public String selectUserAnnualInfo( @ModelAttribute("loginUser") Member loginUser) {
		Map<String, Double > map  = new HashMap<>();
		
		List<Approval> list = aprService.selectUserApprovalAll(loginUser.getUserNo());
		
		double usedAnnual = 0;
		for(Approval apr : list) {
			usedAnnual += apr.getApprovalCount();
		}
		 
		map.put("totalAnnual", (double)loginUser.getAnnualLeaveCount());
		map.put("leftAnnual", loginUser.getAnnualLeaveCount() - usedAnnual);

		return new Gson().toJson(map);
	}
	
	
	// ajax용 확인안한 반려건 수, 확인안한 승인대기건 수, 확인안한 참조문서건 수  반환
	@ResponseBody
	@PostMapping("/selectUnReadCount")
	public String selectUnReadCount( @ModelAttribute("loginUser") Member loginUser) {
		Map<String, Integer > map  = new HashMap<>();
		
		int userNo= loginUser.getUserNo();
		
		map.put( "returnCount" ,aprService.selectApprovalListCount(userNo, -2 , -1, 0, false));
		map.put("waitCount", aprService.selectApprovalListforAuthorizeCount(userNo, "wait", 0 , -1, 0, true) );
		map.put( "referCount", aprService.selectApprovalListforReferCount(userNo, null, 0, -1, true));
		return new Gson().toJson(map);
	}
	
	
	// ajax용 선택된 결재문서 세부 내용 반환 + 확인된 문서 체크
	@ResponseBody
	@PostMapping("/selectApproval")
	public String selectApproval( @ModelAttribute("loginUser") Member loginUser, Integer approvalNo, String isAdmin) {
		Map<String, Object > map  = new HashMap<>();
		
		int userNo= loginUser.getUserNo();
		
		Approval approval = aprService.selectApproval(approvalNo);
		
		List<ApprovalLine> lines = aprService.selectLineList("approval", approvalNo);
		List<ApprovalFile> files = aprService.selectFileList("approval", approvalNo, "attachment");
		
		if(userNo ==  approval.getUserNo() && approval.getStatus() == -1) {
			// 만약 로그인유저가 기안자면서 문서 상태가 확인안한 반려(-1) 이라면 확인한 반려(-2)로 상태 변경 날려주기
			int result = aprService.updateApprovalStatus( approvalNo, -2);
			if(result > 0) {
				// 상태 변경된걸로 다시 조회
				approval = aprService.selectApproval(approvalNo);
			}
		}
		
		map.put("approval", approval);
		map.put("lines", lines);
		map.put("files", files);
		map.put("userNo", userNo);
		
		if(isAdmin == null  || !isAdmin.equals("admin") ) {
			// 어드민용 조회가 아닐때  읽음처리
			aprService.updateApprovalLineReadStatus(approvalNo, userNo);
		}
		
		return new Gson().toJson(map);
	}
	
	
	// ajax용 종류별 결재 리스트 조회
	@ResponseBody
	@PostMapping("/selectApprovalList")
	public String selectApprovalList(	@ModelAttribute("loginUser") Member loginUser,
										Integer year,
										Integer type,
										Integer page,
										String menu,
										String status
										) {
		System.out.println(year+"==========들어온 페이지=========================="+status);
		Integer aprStatus = null;
		if (status != null && !status.equals("all")) {
			aprStatus = Integer.parseInt(status);
	    }
		
		List<Approval> list = null;
		int count = 0;
		int userNo = loginUser.getUserNo();
		
		switch (menu) {
		// 참조중인 문서 리스트 조회용
		case "refer": list = aprService.selectApprovalListforRefer(userNo, aprStatus, year, page, type);
					 count = aprService.selectApprovalListforReferCount(userNo, aprStatus, year, type, false);
			break;
			
		// 결재대기중인 문서 리스트 조회용
		case "wait": list = aprService.selectApprovalListforAuthorize(userNo, "wait", aprStatus, type, year, page);
					 count = aprService.selectApprovalListforAuthorizeCount(userNo, "wait", aprStatus, type, year, false);
			break;
			
		// 결재한 문서 리스트 조회용
		case "authorized": list = aprService.selectApprovalListforAuthorize(userNo, "authorized", aprStatus, type, year, page);
						  count = aprService.selectApprovalListforAuthorizeCount(userNo, "authorized", aprStatus, type, year, false);
			break;
			
		case "draft": // 기안한 문서 리스트 조회용(임시저장, 참조, 결재, 결재대기 중인 문서 제외 전체)
		case "temp":  // 임시저장 문서 리스트 조회용
		case "return": // 반려당한 문서 리스트 조회용
		default : list = aprService.selectApprovalList(userNo, aprStatus, type, year, page, false);
			 	 count = aprService.selectApprovalListCount(userNo, aprStatus, type, year, false);
		}
		
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("count", count);
		result.put("loginUserNo", loginUser.getUserNo());

		return new Gson().toJson(result);
	}
	
	
	
	
	// ajax용 결재문서 저장
	@ResponseBody
	@PostMapping("/insertApproval")
	public String insertApproval( @ModelAttribute("loginUser") Member loginUser,
								  @ModelAttribute Approval approval,
								  @RequestParam(value="images", required=false) MultipartFile[] imgList,
								  @RequestParam(value="imgNames", required = false) String[] imgNameList,
								  @RequestParam(value="files", required=false) MultipartFile[] fileList,
								  @RequestParam(value="userNoList", required=false) int[] userNoList,
								  @RequestParam(value="levelList", required=false) int[] levelList,
								  @RequestParam(value="typeList", required=false) String[] typeList,
								  HttpSession session
								) {
		// 기안자 유저번호 저장
		approval.setUserNo(loginUser.getUserNo());
		
		//------------------------ 결재라인 저장 구역 --------------------------------
		// 결재라인 저장용
		List<ApprovalLine> lines = new ArrayList<>();
		
		// 첫번째 결재자 찾는 용도
		int firstA = 999;
		int reali = 0;
		int nextAuthorizeUserNo = 0;
		
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
					reali = i;
					nextAuthorizeUserNo = userNoList[i];
				}
			}
			line.setStatus(status);

			lines.add(line);
		}
		
		if(firstA <= lines.size()) {			
			// 가장 첫번째 결재자 상태 대기상태로 변경
			lines.get(reali).setStatus(1);
			
			// 결재자가 존재하는 문서이므로 임시저장용이 아니면 문서상태 진행중으로 저장
			if(approval.getStatus() != 2) {
				approval.setStatus(0);
			}
			
			// 첫번째 결재자 전의 라인들은 모두 참조자라는 뜻이므로 상태 3(참조자용)으로 변경
			for(int i = 0; i< reali; i++) {
				lines.get(i).setStatus(3);
			}
			
			
		}else {
			// 결재자 없이 참조자만있는 문서라는 뜻이므로 임시저장용이 아니면 문서상태 완료로 찍어야함
			if(approval.getStatus() != 2) {
				approval.setStatus(1);
				// todo! 결재문서 완료처리되면 자동으로 이름이랑 서명칸 이미지 저장시켜야함
				// 리턴값에 변화를 줘서 앞단에서 처리하는게 좋을 듯
			}
			
			// 결재자 없이 참조자만 있는 문서이니 모든 참조자 상태 3(참조자용)으로 변경
			for(ApprovalLine line : lines) {
				line.setStatus(3);
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
		
		// 양식복사 해왔을 경우를 위한 로직
		// 실제로 저장되어있는 파일중 이미지 이름들과 같은 애들 복사해서 신규로 파일 생성
		if (imgNameList != null && imgNameList.length > 0) {
			for (int i = 0; i < imgNameList.length; i++) {
				String src = "src=\"" + imgNameList[i] + "\"";
				String changeName;
				try {
					changeName = FileRenamePolicy.copyFile(imgNameList[i], serverFolderPath);
					content = content.replace(src, "src=\"" + changeName + "\"");
					saveList.add(new ApprovalFile("approval" , null ,changeName));
				} catch (IOException e) {
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
		int approvalNo = aprService.insertApproval(approval, lines , saveList);
		
		// 만약 insert 실패하면 위에서 파일 저장 진행했던거 다 날리는 구문 실행
		if(approvalNo <= 0) {
			if (saveList.size() > 0) {
				// 저장된 파일 리스트 실제 파일들 삭제
				for (ApprovalFile file : saveList) {
					File deleteFile = new File(serverFolderPath + file.getChangeName());
					if (deleteFile.exists()) { // 파일이 존재하면
						deleteFile.delete();// 파일 삭제
					}
				}
			}
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 만약 결재문서자체는 잘 저장되었는데 상태가 완결상태이면 앞단에 알려줌
		if(approvalNo > 0 && approval.getStatus() == 1) {
			approval.setApprovalNo(approvalNo);
			// 본인정보 , 서명정보, 직급, 이름 돌려줘야함
			String signImg = aprService.selectSignImg(loginUser.getUserNo());
			map.put("result", -1);
			map.put("approval", approval);
			map.put("userName", loginUser.getUserName());
			map.put("pName", loginUser.getPName());
			map.put("signImg", signImg);
		}else if(approvalNo > 0) {
			map.put("result", 1);
			map.put("nextAuthorizeUserNo", nextAuthorizeUserNo);
		}else {
			map.put("result", 0);
		}
		
		return new Gson().toJson(map);
	}
	
	
	
	// ajax용 결재문서 업데이트 (임시저장건, 반려건)
		@ResponseBody
		@PostMapping("/updateApproval")
		public String updateApproval( @ModelAttribute("loginUser") Member loginUser,
									  @ModelAttribute Approval approval,
									  @RequestParam(value="images", required=false) MultipartFile[] imgList,
									  @RequestParam(value="imgNames", required = false) String[] imgNameList,
									  @RequestParam(value="files", required=false) MultipartFile[] fileList,
									  @RequestParam(value="fileNames", required=false) String[] fileNameList,
									  @RequestParam(value="userNoList", required=false) int[] userNoList,
									  @RequestParam(value="levelList", required=false) int[] levelList,
									  @RequestParam(value="typeList", required=false) String[] typeList,
									  HttpSession session
									) {
			// 기안자 유저번호 저장
			approval.setUserNo(loginUser.getUserNo());
			int approvalNo = approval.getApprovalNo();
			System.out.println("문서 업데이트=============== "+ approvalNo);
			
			//------------------------ 결재라인 저장 구역 --------------------------------
			// 결재라인 저장용
			List<ApprovalLine> lines = new ArrayList<>();
			
			// 첫번째 결재자 찾는 용도
			int firstA = 999;
			int reali = 0;
			
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
						reali = i;
					}
				}
				line.setStatus(status);

				lines.add(line);
			}
			
			if(firstA <= lines.size()) {			
				// 가장 첫번째 결재자 상태 대기상태로 변경
				lines.get(reali).setStatus(1);
				
				// 결재자가 존재하는 문서이므로 임시저장용이 아니면 문서상태 진행중으로 저장
				if(approval.getStatus() != 2) {
					approval.setStatus(0);
				}
				
				// 첫번째 결재자 전의 라인들은 모두 참조자라는 뜻이므로 상태 3(참조자용)으로 변경
				for(int i = 0; i< reali; i++) {
					lines.get(i).setStatus(3);
				}
				
			}else {
				// 결재자 없이 참조자만있는 문서라는 뜻이므로 임시저장용이 아니면 문서상태 완료로 찍어야함
				if(approval.getStatus() != 2) {
					approval.setStatus(1);
					// todo! 결재문서 완료처리되면 자동으로 이름이랑 서명칸 이미지 저장시켜야함
					// 리턴값에 변화를 줘서 앞단에서 처리하는게 좋을 듯
				}
				
				// 결재자 없이 참조자만 있는 문서이니 모든 참조자 상태 3(참조자용)으로 변경
				for(ApprovalLine line : lines) {
					line.setStatus(3);
				}
				
			}
			
			// ----------------- 본문 이미지 파일 + 첨부파일 내용 변동있으면 필요없어진 실제파일 삭제시키는 구역 ------------------------
			
			// 일단 먼저 저장되어있던 모든 파일 리스트 불러옴
			List<ApprovalFile> savedFileList = aprService.selectFileList("approval", approvalNo, "all");

			// 파일 저장경로 얻어오기
			String webPath = "/resources/file/approval/";
			String serverFolderPath = session.getServletContext().getRealPath(webPath);
			
			// 본문 이미지 리스트와 비교 먼저 수행
			if (imgNameList != null && imgNameList.length > 0) {
				// 이미지 이름들과 실제 db에 저장되어있는 파일명들 비교해서 있는애들은 빼고 없는애들만 리스트에 남김
				for (int i = 0; i < savedFileList.size(); i++) {
					String changeName = savedFileList.get(i).getChangeName();

					for (int j = 0; j < imgNameList.length; j++) {
						String imgName = imgNameList[j];

						if (changeName.equals(imgName)) {
							savedFileList.remove(i);
							// 아이템을 하나 지웠으므로 다시 이전 숫자부터 반복하게 -- 함
							i--;
							break;
						}
					}
				}
			}
			
			// 첨부파일 리스트와 비교 수행
			if (fileNameList != null && fileNameList.length > 0) {
				// 첨부파일 이름들과 실제 db에 저장되어있는 파일명들 비교해서 있는애들은 빼고 없는애들만 리스트에 남김
				for (int i = 0; i < savedFileList.size(); i++) {
					String changeName = savedFileList.get(i).getChangeName();

					for (int j = 0; j < fileNameList.length; j++) {
						String fileName = fileNameList[j];

						if (changeName.equals(fileName)) {
							savedFileList.remove(i);
							// 아이템을 하나 지웠으므로 다시 이전 숫자부터 반복하게 -- 함
							i--;
							break;
						}
					}
				}
			}
			
			// 검열하고 남은 이미지 리스트 실제 파일들 삭제
			for (ApprovalFile file : savedFileList) {
				File deleteFile = new File(serverFolderPath + file.getChangeName());
				if (deleteFile.exists()) { // 파일이 존재하면
					// 파일 삭제
					deleteFile.delete();
				}
			}

			// db에서도 파일 삭제 진행
			if (savedFileList.size() > 0) {
				aprService.deleteFileList(savedFileList);
			}

			//----------------- 신규로 들어온 파일 가공해서 업데이트 및 저장시키는 구역 -------------------------
			
			//----- 본문 이미지 저장 구역 --------
			// 본문용으로 저장시킬 파일 객체 리스트
			List<ApprovalFile> forSaveFileList = new ArrayList<>();
			
			// 본문 가공을 위해 별도로 빼서 저장
			String content = approval.getContent();
			
			if(imgList != null && imgList.length > 0) {
				for(int i=0; i< imgList.length; i++) {
					String src = "src=\""+i+"\"";
					String changeName;
					try {
						changeName = FileRenamePolicy.saveFile( imgList[i] , serverFolderPath);
						content = content.replace(src,"src=\""+changeName+"\"");
						
						forSaveFileList.add(new ApprovalFile( "approval" , null ,changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			approval.setContent(content);

			//---------- 첨부파일 저장구역 --------------
			
			if(fileList != null && fileList.length > 0) {
				for(int i=0; i< fileList.length; i++) {
					try {
						String originName = fileList[i].getOriginalFilename();
						String changeName = FileRenamePolicy.saveFile( fileList[i] , serverFolderPath);
						
						forSaveFileList.add(new ApprovalFile("approval" , originName ,changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			
			int result = aprService.updateApproval(approval, lines , forSaveFileList);
			
			// 만약 업데이트 실패하면 위에서 파일 저장 진행했던거 다 날리는 구문 실행
			if(result <= 0) {
				if (forSaveFileList.size() > 0) {
					// 저장된 파일 리스트 실제 파일들 삭제
					for (ApprovalFile file : forSaveFileList) {
						File deleteFile = new File(serverFolderPath + file.getChangeName());
						if (deleteFile.exists()) { // 파일이 존재하면
							deleteFile.delete();// 파일 삭제
						}
					}
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			// 만약 결재문서자체는 잘 저장되었는데 상태를 완결상태로 해야하는거면 앞단에 알려줌
			if(result > 0 && approval.getStatus() == 1) {
				// 본인정보 , 서명정보, 직급, 이름 돌려줘야함
				String signImg = aprService.selectSignImg(loginUser.getUserNo());
				map.put("result", -1);
				map.put("approval", approval);
				map.put("userName", loginUser.getUserName());
				map.put("pName", loginUser.getPName());
				map.put("signImg", signImg);
			}else if(result > 0) {
				map.put("result", 1);
			}else {
				map.put("result", 0);
			}
			
			return new Gson().toJson(map);
		}
	
	
	
	// ajax용 결재문서 결재처리 ( + 결재자가 결재 후 다음 결재라인들 상태 변경) 
	@ResponseBody
	@PostMapping("/updateApprovalStateAuthorized")
	public String updateApprovalStateAuthorized( 	Integer approvalNo,
												Integer myLevel
												) {
		int result = 0;
		// 다음 결재자 변수용
		int nextAuthorizeLevel = 999;
		// 다음결재자 유저번호 저장용(다음결재자한테 알림 날리기용도)
		int nextAuthorizeUserNo = 0;
		if(approvalNo != null && approvalNo != 0 && myLevel != null && myLevel != 0 ) {
			List<ApprovalLine> lines = aprService.selectLineList("approval", approvalNo) ;

			// 라인 리스트 돌면서 내 다음 결재자 찾기
			for(int i=0; i<lines.size(); i++) {
				ApprovalLine line = lines.get(i);
				if(line.getType().equals("A")) {
					if(line.getLevel() > myLevel && line.getLevel() < nextAuthorizeLevel) {
						nextAuthorizeLevel = line.getLevel();
						nextAuthorizeUserNo = line.getUserNo();
					}
				}
			}
			
			if(nextAuthorizeLevel == 999) {
				// 다음 결재자를 못찾았다는 소리임 -> 다음 결재자 값 갈아끼기
				nextAuthorizeLevel = 0;
			}
			
			// 결재라인 상태들 변경
			result = aprService.updateNextLinesStatus(approvalNo, nextAuthorizeLevel, myLevel);
		}
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("nextAuthorizeUserNo", nextAuthorizeUserNo);
		
		return new Gson().toJson(map);
	}
	
	
	// ajax용 결재문서 완결처리
	@ResponseBody
	@PostMapping("/updateApprovalStateEnd")
	public int updateApprovalStateEnd( 	@ModelAttribute Approval approval) {
		
		int result = 0;
		System.out.println("============================="+approval);
		
		Approval existApproval = aprService.selectApproval(approval.getApprovalNo());
		
		// 작성자 userNo 세팅
		approval.setUserNo(existApproval.getUserNo());
		
		if(approval != null && approval.getApprovalNo() != 0 ) {
			result = aprService.updateApprovalStateEnd(approval);
			
			/* [혜린] - 연차 insert 시 캘린더 내 연차일정 추가 */
			Approval apv = aprService.selectAddEvent(approval.getApprovalNo());
			
			if(existApproval.getType() != 0) { // 0:일반 제외 1,2,3 연차만
				
				Calendar calendar = new Calendar();
				String name = "";
				
				switch(apv.getType()) {
				case 1 :name = "휴가"; break;
				case 2 :name = "오전반차"; break;
				case 3 :name = "오후반차"; break;
				}
				calendar.setTitle(apv.getUserName()+" "+name); // ex)ㅇㅇㅇ 휴가
				calendar.setContent(apv.getApprovalNo()+"");
				calendar.setCategory("H");
				calendar.setUserNo(apv.getUserNo());
				calendar.setStartDate(apv.getStartDate()+"");
				calendar.setEndDate(apv.getEndDate()+"");
				calendar.setColor("var(--col9)");
				calendar.setDDay("N");
				
				aprService.insertEvent(calendar); //연차 일정 추가
			}
		}
		
		if(result > 0) {
			// 결재완료 알림처리 위해 기안자 번호 돌려줌
			result = existApproval.getUserNo();
		}
		
		System.out.println("===================결재 완료처리=================="+ result +"     "+ existApproval.getUserNo());
		
		return result;
	}
	
	
	// ajax용 결재문서 반려처리
	@ResponseBody
	@PostMapping("/updateApprovalReturn")
	public int updateApprovalReturn( 	@ModelAttribute("loginUser") Member loginUser,
										Integer approvalNo) {
		int result = 0;
		System.out.println("=============================반려처리=========="+approvalNo);
		
		if(approvalNo != 0 ) {
			result =aprService.updateApprovalStatus(approvalNo, -1);
			if(result > 0) {				
				result = aprService.updateLineStatusReturn(approvalNo, loginUser.getUserNo());
			}
		}
		
		if(result > 0) {
			// 알림 발송을 위해 기안자 유저번호를 되돌려주기
			result =  aprService.selectApproval(approvalNo).getUserNo();
		}
		
		return result;
	}
	
	
	// ajax용 결재문서 삭제
	@ResponseBody
	@PostMapping("/deleteApproval")
	public int deleteApproval(	Integer approvalNo, 
								HttpSession session) {
		
		// 파일 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);

		// 결재문서 삭제 (실제 결재라인, 메모 모두 같이 삭제) + 실제 저장된 파일들 삭제 
		int result = aprService.deleteApproval(approvalNo, serverFolderPath);
		
		/* [혜린] - 취소된 연차관련 일정 삭제 */
		Calendar calendar = new Calendar();
		calendar.setContent(approvalNo+"");
		
		aprService.deleteApvEvent(calendar);
		
		
		return result;
	}
	
	
	// ajax용 즐겨찾기 저장
	@ResponseBody
	@PostMapping("/insertFavor")
	public int insertFavor( @ModelAttribute("loginUser") Member loginUser,
							@RequestParam(value="userNoList", required = false) int[] userNoList,
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
		favor.setUserNo(loginUser.getUserNo());
		
		int result = aprService.insertFavor(favor, lines);

		return result;
	}
	
	
	// ajax용 즐겨찾기 삭제
	@ResponseBody
	@PostMapping("/deleteFavor")
	public int deleteFavor(Integer favorNo) {
		
		int result = aprService.deleteFavor(favorNo);

		return result;
	}
	
	
	
	// ajax용 메모 리스트 조회
	@ResponseBody
	@PostMapping("/selectMemoList")
	public String selectMemoList(Integer approvalNo) {
		
		List<ApprovalMemo> list = aprService.selectMemoList(approvalNo);

		return new Gson().toJson(list);
	}
	
	// ajax용 메모 조회
	@ResponseBody
	@PostMapping("/selectMemo")
	public String selectMemo(@ModelAttribute("loginUser") Member loginUser, Integer memoNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		ApprovalMemo memo = aprService.selectMemo(memoNo);
		List<ApprovalFile> files = aprService.selectFileList("memo", memoNo, "attachment") ;
		
		map.put("memo", memo);
		map.put("files", files);
		map.put("loginUser", loginUser.getUserNo());
		
		return new Gson().toJson(map);
	}
	
	
	// ajax용 메모 저장
	@ResponseBody
	@PostMapping("/insertMemo")
	public int insertMemo(	@ModelAttribute("loginUser") Member loginUser,
							@ModelAttribute ApprovalMemo memo,
							@RequestParam(value="memoFiles", required=false) MultipartFile[] fileList,
							HttpSession session
								) {
		// 유저번호 저장
		memo.setUserNo( loginUser.getUserNo());
		
		List<ApprovalFile> saveList = new ArrayList<>();
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		
		if(fileList != null && fileList.length > 0) {
			for(int i=0; i< fileList.length; i++) {
				try {
					String originName = fileList[i].getOriginalFilename();
					String changeName = FileRenamePolicy.saveFile( fileList[i] , serverFolderPath);
					
					saveList.add(new ApprovalFile("memo" , originName ,changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		int result = aprService.insertMemo(memo, saveList);
		
		// 만약 insert 실패하면 위에서 파일 저장 진행했던거 다 날리는 구문 실행
		if(result <= 0) {
			if (saveList.size() > 0) {
				// 저장된 파일 리스트 실제 파일들 삭제
				for (ApprovalFile file : saveList) {
					File deleteFile = new File(serverFolderPath + file.getChangeName());
					if (deleteFile.exists()) { // 파일이 존재하면
						deleteFile.delete();// 파일 삭제
					}
				}
			}
		}
		
		return result;
	}
	
	
	
	// ajax용 메모 수정
		@ResponseBody
		@PostMapping("/updateMemo")
		public int updateMemo(	@ModelAttribute("loginUser") Member loginUser,
								@ModelAttribute ApprovalMemo memo,
								@RequestParam(value="memoFiles", required=false) MultipartFile[] fileList,
								HttpSession session
									) {
			// 유저번호 저장
			memo.setUserNo( loginUser.getUserNo());
			
			List<ApprovalFile> saveList = new ArrayList<>();
			
			// 파일 저장할 저장경로 얻어오기
			String webPath = "/resources/file/approval/";
			String serverFolderPath = session.getServletContext().getRealPath(webPath);
			
			if(fileList != null && fileList.length > 0) {
				for(int i=0; i< fileList.length; i++) {
					try {
						String originName = fileList[i].getOriginalFilename();
						String changeName = FileRenamePolicy.saveFile( fileList[i] , serverFolderPath);
						
						saveList.add(new ApprovalFile("memo" , originName ,changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			//todo! 지금은 파일 추가만 가능한데 나중에 파일 수정, 제거도 가능해야함
			int result = aprService.updateMemo(memo, saveList);
			
			// 만약 update 실패하면 위에서 파일 저장 진행했던거 다 날리는 구문 실행
			if(result <= 0) {
				if (saveList.size() > 0) {
					// 저장된 파일 리스트 실제 파일들 삭제
					for (ApprovalFile file : saveList) {
						File deleteFile = new File(serverFolderPath + file.getChangeName());
						if (deleteFile.exists()) { // 파일이 존재하면
							deleteFile.delete();// 파일 삭제
						}
					}
				}
			}
			
			return result;
		}
	
	
	// ajax용 메모 삭제
	@ResponseBody
	@PostMapping("/deleteMemo")
	public int deleteMemo(Integer memoNo, HttpSession session) {
		
		List<ApprovalFile> files = aprService.selectFileList("memo", memoNo, "attachment");
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		
		// 실제 파일 삭제
		if (files.size() > 0) {
			// 저장된 파일 리스트 실제 파일들 삭제
			for (ApprovalFile file : files) {
				File deleteFile = new File(serverFolderPath + file.getChangeName());
				if (deleteFile.exists()) { // 파일이 존재하면
					deleteFile.delete();// 파일 삭제
				}
			}
			aprService.deleteFileList(files);
		}
		
		int result = aprService.deleteMemo(memoNo);

		return result;
	}
	
	
	// ajax용 서명 이미지 조회
	@ResponseBody
	@PostMapping("/selectSignImg")
	public String selectSignImg(@ModelAttribute("loginUser") Member loginUser) {

		return aprService.selectSignImg(loginUser.getUserNo());
	}
	
	
	// ajax용 서명 이미지 수정
	@ResponseBody
	@PostMapping("/updateSignImg")
	public int updateSignImg(	HttpSession session, 
								@ModelAttribute("loginUser") Member loginUser,
								@RequestParam(value="signImg", required=false) MultipartFile signImg) {
		// 기본적으로 서명 이미지는 하나의 이름으로 계속해서 사용!! 
		// -> 전자결재 완결난 이후에 서명 이미지를 바꾸면 신규 서명이미지로 바로바로 표시되게끔 하기 위함임
		
		int result = 0;
		
		if(signImg != null) {
			// 파일 저장경로 얻어오기
			String imgPath = "/resources/file/signature/";
			String realPath = session.getServletContext().getRealPath(imgPath);
			
			// 기존 이미지 이름
			String beforeSignImg = aprService.selectSignImg(loginUser.getUserNo());
			
			// 만약 기존 서명 이미지가 있다면
			if(beforeSignImg != null && !beforeSignImg.isEmpty()) {
				// 기존 파일 삭제
				File deleteFile = new File(realPath + beforeSignImg);
				if (deleteFile.exists()) { // 파일이 존재하면
					deleteFile.delete();// 파일 삭제
				}
				Path existingPath = Path.of(realPath + beforeSignImg);
				try {
					// 기존파일을 신규파일로 덮어쓰기
					Files.copy(signImg.getInputStream(), existingPath, StandardCopyOption.REPLACE_EXISTING);
				} catch (IOException e) {
					e.printStackTrace();
					result = 0;
				}
				result = 1;
				
			}else {
				// 만약 기존 서명 이미지가 없다면 이미지 신규 저장 후 DB에 insert
				String changeName;
				try {
					changeName = FileRenamePolicy.saveFile( signImg , realPath);
					result = aprService.insertSignImg(loginUser.getUserNo(), changeName);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			
		}else {
			// 애초에 서명이미지 파일이 전송되지 않았다면 실패 반환
			result = 0;
		}
		
		return result;
	}
	
}
