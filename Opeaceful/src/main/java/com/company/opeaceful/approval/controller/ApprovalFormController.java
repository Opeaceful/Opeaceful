package com.company.opeaceful.approval.controller;

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

	@GetMapping("") //  
	public String approvalForm(Model model) {
		List<ApprovalForm> formList = aprService.selectFormList( 1 , "all");
		model.addAttribute(formList);

		return "approval/approvalForm";
	}

	// ajax용 폼 리스트 반환
	@PostMapping("/selectFormList")
	public String selectFormList( String checkType, int currentPage ) {
		List<ApprovalForm> formList  = new ArrayList<>();
		
		if(checkType != null) {
			 formList = aprService.selectFormList(currentPage, checkType);
		}else {
			formList = aprService.selectFormListAll();
		}

		return new Gson().toJson(formList);
	}
	
	// ajax용 폼 반환
	@PostMapping("/selectForm")
	public String selectForm(int formNo) {
		ApprovalForm form= aprService.selectForm(formNo);

		return new Gson().toJson(form);
	}

	// ajax용 폼 insert
	@PostMapping("/insertForm")
	@ResponseBody
	public void insertForm(@ModelAttribute	 ApprovalForm form, 
							String content,
							@RequestParam(value="title", required = false) String title,
							@RequestParam(value="images", required = false) List<MultipartFile> imgList,
							HttpSession session) {
		
		System.out.println("들어온 폼 "+form + imgList + content+ title );
//		System.out.println("이미지 파일 "+images);
//		String content = form.getContent();
		//	TODO ! 파일들 가공하고 기존파일들이랑 비교해서 삭제할거 삭제해야함
		List<ApprovalFile> fileList = new ArrayList<>();
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolerPath = session.getServletContext().getRealPath(webPath);
		
//		if(images != null && images.length > 0) {
//			for(int i=0; i< images.length; i++) {
//				String src = "src='"+i+"'";
//				String changeName;
//				
//				try {
//					changeName = FileRenamePolicy.saveFile( images[i] , serverFolerPath);
//					content = content.replace(src, "src='"+webPath+changeName+"'");
//					
//					fileList.add(new ApprovalFile(changeName));
//				} catch (IllegalStateException | IOException e) {
//					e.printStackTrace();
//				}
//				
//			}
//		}
		

		
//		System.out.println(content);
//		
//		form.setContent(content);
//		
//		int result = aprService.insertForm(form , fileList);

//		return 0;
	}
	
	
	
	// ajax용 폼 update
	@PostMapping("/updateForm")
	public String updateForm(ApprovalForm form, 
								@RequestParam(value="images", required = false) List<MultipartFile> imgList) {
		// TODO ! 파일들 가공하고 필요없는거 걸러서 삭제시키기
		List<ApprovalFile> fileList = new ArrayList<>();
		
//		int result = aprService.updateForm(form, fileList);

		return new Gson().toJson(form);
	}
}
