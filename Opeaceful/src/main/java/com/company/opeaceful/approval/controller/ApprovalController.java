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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.approval.model.service.ApprovalService;
import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.approval.model.vo.ApprovalFavor;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalLine;
import com.company.opeaceful.approval.model.vo.ApprovalMemo;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.company.opeaceful.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
@RequestMapping("/approval")
@SessionAttributes({"loginUser"})
public class ApprovalController {
	
	
	private ApprovalService aprService;

	@Autowired
	public ApprovalController(ApprovalService aprService) {
		this.aprService = aprService;
	}
	

	@GetMapping("/allApproval")
	public String allApproval( Model model ){
		int currentYear = Year.now().getValue();
		model.addAttribute("list", aprService.selectApprovalList(0, null, -1, currentYear, 1, true));
		model.addAttribute("count", aprService.selectApprovalListCount(0, null, -1, currentYear, true));

		return "approval/allApproval";
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
		model.addAttribute( "referCount", aprService.selectApprovalListforReferCount(userNo, null, 0, true));
		
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
		
		List<Approval> list = aprService.selectUserApproval(loginUser.getUserNo());
		
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
		map.put( "referCount", aprService.selectApprovalListforReferCount(userNo, null, 0, true));
		return new Gson().toJson(map);
	}
	
	
	// ajax용 선택된 결재문서 세부 내용 반환 + 확인된 문서 체크
	@ResponseBody
	@PostMapping("/selectApproval")
	public String selectApproval( @ModelAttribute("loginUser") Member loginUser, Integer approvalNo) {
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
		
		// 읽음처리
		aprService.updateApprovalLineReadStatus(approvalNo, userNo);
		
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
		System.out.println(year+"==========들어온 페이지=========================="+page);
		Integer aprStatus = null;
		if (status != null && !status.equals("all")) {
			aprStatus = Integer.parseInt(status);
	    }
		
		List<Approval> list = null;
		int count = 0;
		int userNo = loginUser.getUserNo();
		
		switch (menu) {
		// 참조중인 문서 리스트 조회용
		case "refer": list = aprService.selectApprovalListforRefer(userNo, aprStatus, year, page);
					 count = aprService.selectApprovalListforReferCount(userNo, aprStatus, year, false);
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

		return new Gson().toJson(result);
	}
	
	
	
	
	// ajax용 결재문서 저장
	@ResponseBody
	@PostMapping("/insertApproval")
	public String insertApproval(	  @ModelAttribute("loginUser") Member loginUser,
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
		}else {
			map.put("result", 0);
		}
		
		return new Gson().toJson(map);
	}
	
	
	
	// ajax용 결재문서 완결처리
	@ResponseBody
	@PostMapping("/updateApprovalStateEnd")
	public int updateApprovalStateEnd( 	@ModelAttribute Approval approval) {
		int result = 0;
		System.out.println("============================="+approval);
		if(approval != null && approval.getApprovalNo() != 0 ) {
			result = aprService.updateApprovalStateEnd(approval);
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
