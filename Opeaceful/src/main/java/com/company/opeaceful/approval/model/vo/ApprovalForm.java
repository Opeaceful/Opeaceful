package com.company.opeaceful.approval.model.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
//(승은)
public class ApprovalForm {
	private int formNo;			//	FORM_NO
	private int type;			//	TYPE
	private String title;		//	TITLE
	private String content;		//	CONTENT
	
	private MultipartFile[] images;

}
