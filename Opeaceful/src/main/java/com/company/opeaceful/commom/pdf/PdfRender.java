package com.company.opeaceful.commom.pdf;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.pdf.BaseFont;

@Component
public class PdfRender {
	
	@Autowired
	private ServletContext servletContext;
	
	public void renderPdf(String htmlContent, String outputPath) throws Exception {
		
		OutputStream outputStream = new FileOutputStream(outputPath);

        //render설정
        ITextRenderer renderer = new ITextRenderer();
        //renderer.getFontResolver().setEncoding("UTF-8");
        renderer.setDocumentFromString(htmlContent);
        
                
        // ITextFontResolver 생성
        ITextFontResolver fontResolver = renderer.getFontResolver();
        
        System.out.println(fontResolver);

        String Path = "/resources/font/NanumGothic.ttf";
        String fontStream = servletContext.getRealPath(Path);
		
		//하 폰트적용 끝나질않네 
        fontResolver.addFont(fontStream, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        
        System.out.println(fontResolver);
        
        renderer.layout();
        //PDF로 만들어줌
        renderer.createPDF(outputStream);
        renderer.finishPDF();
        
        outputStream.close();
    }
	

}
