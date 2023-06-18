package com.company.opeaceful.approval.model.websocket;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.company.opeaceful.approval.model.vo.Approval;
import com.company.opeaceful.chat.model.vo.Chat;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.member.model.vo.Member;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

public class AprWebsocketHandler extends TextWebSocketHandler {

	private Set<WebSocketSession> sessions = Collections.synchronizedSet( new HashSet<WebSocketSession>());
	
	
	// synchronizedSet : 동기화된 Set반환
    // -> 멀티 스레드 환경에서 하나의 컬렉션 요소에 여러 스레드가 동시에 접근하면 충돌이 발생할 수 있으므로 동기화를 진행
	// 클라이언트와 연결이 수립되고, 통신준비가 완료되면 수행되는 메소드
		@Override
		public void afterConnectionEstablished(WebSocketSession session) {
			
			// WebSocketSession : 웹소켓에 접속/요청한 클라이언트의 세션 정보
			System.out.println(session.getId()+" 연결됨");
			sessions.add(session); // 전달받은 session을 set에 추가

		}
		
		// 클라이언트와 연결이 종료되면 수행
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			sessions.remove(session);
			//웹 소켓 연결이 종료되는 경우 , sessions안에 저장되어있던 클라이언트의 session 정보를 삭제
		}
	
		// 클라이언트로부터 텍스트 메세지를 전달받았을 때 수행
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			// TextMessage : 웹소켓을 이용해 전달된 텍스트가 담겨있는 객체
			
			//payLoad : 전송되는 데이터(json객체)
			System.out.println("메세지 : " + message.getPayload());

			// JackSon라이브러리  : java에서 json을 다루기 위한 라이브러리
			// JackSon-databind -> ObjectMapper를 이용해서 JSON형태로 넘어온 데이터를 특정 VO필드에 맞게 자동 매핑
			ObjectMapper objectMapper = new ObjectMapper();
			
			Approval aprMessage = objectMapper.readValue(message.getPayload(), Approval.class); 

			System.out.println(aprMessage);
			
			// 같은 방에 접속중인 클라이언트에게 전달받은 메세지 뿌리기
			for( WebSocketSession s : sessions ) {
				// 반복을 진행중인 WebSocketSession 안에 담겨있는 유저번호 == 메세지 안에 담겨있는 유저번호 일치하는 경우 메세지 뿌리기
				
				int userNo = ((Member)s.getAttributes().get("loginUser")).getUserNo();
				
				if(userNo == aprMessage.getUserNo()) {
					s.sendMessage(new TextMessage( new Gson().toJson(aprMessage) ));
					break;
				}
			}
		}
	
}
