package com.company.opeaceful.commom.pdf;

import java.io.FileOutputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Component;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.pdf.BaseFont;

@Component
public class PdfRender {
	
	public void renderPdf(String htmlContent, String outputPath) throws Exception {
		
		OutputStream outputStream = new FileOutputStream(outputPath);

        //render설정
        ITextRenderer renderer = new ITextRenderer();
        
        renderer.setDocumentFromString(htmlContent);
        
        
    

        renderer.getFontResolver().addFont("C:/Opeaceful/Opeaceful/src/main/webapp/resources/font/notokr-regular.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

        renderer.layout();
        //PDF로 만들어줌
        renderer.createPDF(outputStream);
        renderer.finishPDF();
        
        outputStream.close();
    }
	

}
