package com.company.opeaceful.approval.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.approval.model.service.ApprovalServiceImpl;
import com.company.opeaceful.approval.model.vo.ApprovalFile;
import com.company.opeaceful.approval.model.vo.ApprovalForm;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.google.gson.Gson;

@Controller
@RequestMapping("/approval/approvalForm")
//(승은)
public class ApprovalFormController {

	private ApprovalServiceImpl aprService;

	@Autowired
	public ApprovalFormController(ApprovalServiceImpl aprService) {
		this.aprService = aprService;
	}

	@GetMapping("")   
	public String approvalForm(Model model) {
		List<ApprovalForm> formList = aprService.selectFormList( 1 , -1);
		int count = aprService.selectFormListCount(-1);

		model.addAttribute("formList", formList );
		model.addAttribute("count",count);

		return "approval/approvalForm";
	}
	
	
	// ajax용 폼 총 개수 반환
	@ResponseBody
	@PostMapping("/selectFormListCount")
	public int selectFormListCount( Integer checkType ) {
		System.out.println("---------------------------- 카운트 세러 들어옴 ----------------------");
		System.out.println(checkType);
		int count = 0;
		if(checkType != null) {
			count = aprService.selectFormListCount( checkType);
		}
		return count;
	}
	

	// ajax용 폼 리스트 반환
	@ResponseBody
	@PostMapping("/selectFormList")
	public String selectFormList(
								Integer checkType,
								@RequestParam(value="currentPage", required = false) Integer currentPage
								) {
		
		List<ApprovalForm> formList  = new ArrayList<>();
		
		if(checkType != null && currentPage != null) {
			formList = aprService.selectFormList(currentPage, checkType);
		}else {
			formList = aprService.selectFormListAll();
		}

		return new Gson().toJson(formList);
	}
	
	// ajax용 폼 반환
	@ResponseBody
	@PostMapping("/selectForm")
	public String selectForm(int formNo) {
		
		ApprovalForm form= aprService.selectForm(formNo);

		return new Gson().toJson(form);
	}

	// ajax용 폼 insert
	@ResponseBody
	@PostMapping("/insertForm")
	public int insertForm(  @ModelAttribute	 ApprovalForm form, 
							@RequestParam(value="images", required = false) MultipartFile[]  imgList,
							HttpSession session) {
		
		String content = form.getContent();
		//	TODO ! 파일들 가공하고 기존파일들이랑 비교해서 삭제할거 삭제해야함
		List<ApprovalFile> fileList = new ArrayList<>();
		
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
					System.out.println(content);
					
					fileList.add(new ApprovalFile(changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		form.setContent(content);
		
		int result = aprService.insertForm(form , fileList);

		return result;
	}
	
	
	
	// ajax용 폼 update
	@ResponseBody
	@PostMapping("/updateForm")
	public int updateForm(	@ModelAttribute ApprovalForm form, 
								@RequestParam(value="images", required = false) MultipartFile[] imgList,
								@RequestParam(value="imgNames", required = false) String[] imgNameList,
								HttpSession session	) {
		
		System.out.println("---------update-------"+form.getFormNo());
		System.out.println(imgNameList);
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		
		
		// ---- 본문에 삭제된 이미지있으면 실제 파일도 삭제시키는 구역 -------
		List<ApprovalFile> savedFileList = aprService.selectFileList("form", form.getFormNo(), "content");
		//이 위에코드 수정!


		System.out.println("검사 전 " + savedFileList);
		System.out.println(savedFileList.size());

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
			System.out.println("검사 후 " + savedFileList);
			System.out.println(savedFileList.size());

		}

		// 검열하고 남은 이미지 리스트 실제 파일들 삭제
		for (ApprovalFile file : savedFileList) {
			File deleteFile = new File(serverFolderPath + file.getChangeName());
			System.out.println("---------------삭제할 파일-------------------" + file.getChangeName());
			if (deleteFile.exists()) { // 파일이 존재하면
				// 파일 삭제
				System.out.println(deleteFile.delete());
			}
		}

		// db에서도 파일 삭제 진행
		if (savedFileList.size() > 0) {
			aprService.deleteFileList(savedFileList);
		}

		//-------- 파일 가공해서 업데이트 및 저장시키는 구역 -------------
		
		// 본문용으로 저장시킬 파일 객체 리스트
		List<ApprovalFile> fileList = new ArrayList<>();
		
		// 본문 가공을 위해 별도로 빼서 저장
		String content = form.getContent();
		
		if(imgList != null && imgList.length > 0) {
			for(int i=0; i< imgList.length; i++) {
				String src = "src=\""+i+"\"";
				String changeName;
				
				try {
					changeName = FileRenamePolicy.saveFile( imgList[i] , serverFolderPath);
					content = content.replace(src,"src=\""+changeName+"\"");
					System.out.println(content);
					
					fileList.add(new ApprovalFile(changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		form.setContent(content);
		
		int result = aprService.updateForm(form , fileList);

		return result;
	}
	
	
	// ajax용 폼 delete form
	@ResponseBody
	@PostMapping("/deleteForm")
	public int deleteForm(@RequestParam(value = "formNoList", required = false) List<Integer> formNoList,
			HttpSession session) {
		int result = 0;
		for (int num : formNoList) {
			// 파일 저장할 저장경로 얻어오기
			String webPath = "/resources/file/approval/";
			String serverFolderPath = session.getServletContext().getRealPath(webPath);

			result += aprService.deleteForm(num, serverFolderPath);
		}

		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
