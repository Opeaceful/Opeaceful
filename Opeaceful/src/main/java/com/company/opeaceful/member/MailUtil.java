package com.company.opeaceful.member;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;

import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;

public class MailUtil {
	@Autowired
	private MemberService memberService;
	
	public void sendEmail(Member m) throws Exception{
		
		//Mail Server 설정
		String charSet="utf-8";
		String hostSMTP="smtp.gmail.com";
		String hostSMTPid="shwldml@gmail.com"; //관리자 이메일 아이디
		String hostSMTPpw="dcjyfhttgveuoqcs"; //관리자 이메일 비밀번호
		
		//보내는 사람 
		String fromEmail="shwldml@gmail.com"; //보내는 사람 이메일 
		String fromName="opeaceful"; //보내는 사람 이름
		
		String subject="opeaceful 임시 비밀번호 발송"; //메일 제목
		String msg="";
		
		msg += "<div align='left'>";
		msg += "<div>";
		msg += m.getUserName() + "님의 임시 비밀번호입니다. <br>";
		msg += "로그인 후 비밀번호를 변경해 주세요</div>";
		msg += "<p>사원 번호 : " + m.getEno()+ "</p>";
		msg += "<p>임시 비밀번호 : ";
		msg += m.getUserPwd() + "</p></div>";
		//email전송
		String mailRecipient = m.getEmail();//받는 사람 이메일 주소
		try {
			//객체 선언
			HtmlEmail mail = new HtmlEmail();
			mail.setDebug(false);
			mail.setCharset(charSet);
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(587);
			mail.setAuthentication(hostSMTPid, hostSMTPpw);
			mail.setStartTLSRequired(true);
			mail.addTo(mailRecipient,charSet);
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void findPw(HttpServletResponse response,Member m) {
		response.setContentType("text/html;charset=utf-8");
		
	}

}