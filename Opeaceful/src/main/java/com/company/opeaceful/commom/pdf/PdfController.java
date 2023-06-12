package com.company.opeaceful.commom.pdf;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/pdf")
public class PdfController {
	
	
	@Autowired
	private PdfRender pdfRender;
	

	@GetMapping("/salary")
    public String generatePdf(
//    		@RequestBody Map<String, String> requestBody
    		
    		) {
        try {
            // HTML 내용을 가져오는 로직 작성
        	//String htmlContent = requestBody.get("htmlContent");
        
        	String htmlContent = "<html>"+"안녕하세요"+"</html>";
            
            //System.out.println(htmlContent);
            
            
            
            // HTML을 PDF로 변환하여 저장
            String outputPath = "AA.pdf";
            pdfRender.renderPdf(htmlContent, outputPath);
            
            // PDF 생성 성공 시, 다운로드 링크 또는 메시지 반환
            return "redirect:/pdf/download-pdf?filePath=" + outputPath;
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 로직 작성
            return "error";
        }
    }
    
    // PDF 다운로드 링크 처리 메서드
    @GetMapping("/download-pdf")
    public ResponseEntity<byte[]> downloadPdf(@RequestParam("filePath") String filePath) throws IOException {
        
    	System.out.println("안으로 들어옴");
    	
    	 //파일 생성
    	File file = new File(filePath);
        byte[] pdfBytes = Files.readAllBytes(file.toPath());
        
        //응답헤더
        HttpHeaders headers = new HttpHeaders();
        //pdf로 설정
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDisposition(ContentDisposition.attachment().filename(file.getName()).build());
       
        //만든 요청으로 pdf 다운로드
        return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
    }
   

    


 


	

}
