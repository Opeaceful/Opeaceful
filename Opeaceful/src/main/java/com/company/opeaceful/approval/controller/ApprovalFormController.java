package com.company.opeaceful.approval.controller;

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

	@GetMapping("") //  
	public String approvalForm(Model model) {
		List<ApprovalForm> formList = aprService.selectFormList( 1 , -1);
		System.out.println(formList.size());
		model.addAttribute("formList",formList );

		return "approval/approvalForm";
	}

	// ajax용 폼 리스트 반환
	@PostMapping("/selectFormList")
	@ResponseBody
	public String selectFormList(
								Integer checkType,
								@RequestParam(value="currentPage", required = false) Integer currentPage
								) {
		
		System.out.println("---------------------");
		System.out.println(checkType);
		System.out.println(currentPage);
		
		List<ApprovalForm> formList  = new ArrayList<>();
		
		if(checkType != null && currentPage != null) {
			formList = aprService.selectFormList(currentPage, checkType);
		}else {
			formList = aprService.selectFormListAll();
		}

		return new Gson().toJson(formList);
	}
	
	// ajax용 폼 반환
	@PostMapping("/selectForm")
	@ResponseBody
	public String selectForm(int formNo) {
		ApprovalForm form= aprService.selectForm(formNo);

		return new Gson().toJson(form);
	}

	// ajax용 폼 insert
	@PostMapping("/insertForm")
	@ResponseBody
	public int insertForm( @ModelAttribute	 ApprovalForm form, 
							@RequestParam(value="images", required = false) MultipartFile[]  imgList,
							HttpSession session) {
		
		System.out.println("들어온 폼 "+form.getTitle() + imgList.length );

		String content = form.getContent();
		//	TODO ! 파일들 가공하고 기존파일들이랑 비교해서 삭제할거 삭제해야함
		List<ApprovalFile> fileList = new ArrayList<>();
		
		// 파일 저장할 저장경로 얻어오기
		String webPath = "/resources/file/approval/";
		String serverFolerPath = session.getServletContext().getRealPath(webPath);
		String realPath = session.getServletContext().getContextPath();
		
		if(imgList != null && imgList.length > 0) {
			for(int i=0; i< imgList.length; i++) {
				String src = "src=\""+i+"\"";
				String changeName;
				
				try {
					changeName = FileRenamePolicy.saveFile( imgList[i] , serverFolerPath);
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
	@PostMapping("/updateForm")
	public String updateForm(ApprovalForm form, 
								@RequestParam(value="images", required = false) List<MultipartFile> imgList,
								@RequestParam(value="imgNames", required = false) ArrayList<String> imgNameList) {
		// TODO ! 파일들 가공하고 필요없는거 걸러서 삭제시키기
		List<ApprovalFile> fileList = new ArrayList<>();
		
		List<ApprovalFile> savedFileList = aprService.selectFileList("form" , form.getFormNo(), "content");
		
		for(int i=0; i< savedFileList.size(); i++) {
			String changeName = savedFileList.get(i).getChangeName();
			
			for(int j=0; j< imgNameList.size(); j++) {
				String imgName = imgNameList.get(i);
				
				if(changeName.equals(imgName)) {
					savedFileList.remove(i);
					i--;
					break;
				}
			}
		}
		
//		int result = aprService.updateForm(form, fileList);

		return new Gson().toJson(form);
	}
}
