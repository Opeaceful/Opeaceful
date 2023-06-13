package com.company.opeaceful.commom.pdf;

import java.io.FileOutputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Component;
import org.xhtmlrenderer.pdf.ITextRenderer;

@Component
public class PdfRender {
	
	public void renderPdf(String htmlContent, String outputPath) throws Exception {
		
		OutputStream outputStream = new FileOutputStream(outputPath);

        //render설정
        ITextRenderer renderer = new ITextRenderer();
        
        renderer.setDocumentFromString(htmlContent);
        renderer.layout();
        //PDF로 만들어줌
        renderer.createPDF(outputStream);
        renderer.finishPDF();
        
        outputStream.close();
    }
	

}
