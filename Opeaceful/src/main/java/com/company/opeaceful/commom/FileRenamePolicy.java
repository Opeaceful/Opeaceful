package com.company.opeaceful.commom;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class FileRenamePolicy {

	// 변경된 이름을 돌려주면서 , 원본파일을 변경된 파일 이름으로 서버에 저장시키는 메소드
	static public String saveFile(MultipartFile upfile, String savePath) throws IllegalStateException, IOException {
		
		String originName = upfile.getOriginalFilename(); 
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int random =(int)( Math.random()*90000 + 10000);
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + random + ext;
		
		upfile.transferTo(new File(savePath+changeName));
		
		return changeName;
	}
	
	// (승은) 기존 파일이 저장되어있는 경로 + 기존 파일명을 받아 복사 후 신규 저장된파일 이름 반환하는 메소드 [전자결재 양식 복사용]
	static public String copyFile(String originFileName , String savedPath  ) throws IOException {
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random =(int)( Math.random()*90000 + 10000);
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
		String changeName = currentTime + random + ext;
		
		
		// 기존 파일 받아옴
		File sourceFile = new File(savedPath + originFileName);
		// 복사용 파일
	    File copyFile = new File(savedPath + changeName);

	    // 파일 복사
	    Path sourceFilePath = sourceFile.toPath();
	    Path copyFilePath = copyFile.toPath();
	    Files.copy(sourceFilePath, copyFilePath, StandardCopyOption.REPLACE_EXISTING);

	    return changeName;
	}
}
