package com.company.opeaceful.chat.model.websocket;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.company.opeaceful.chat.model.service.ChatService;
import com.company.opeaceful.chat.model.vo.Chat;
import com.company.opeaceful.chat.model.vo.ChatParticipant;
import com.company.opeaceful.member.model.vo.Member;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

public class ChatWebsocketHandler extends TextWebSocketHandler{
	
	/*
	 * WebSocketHandler 인터페이스 : 웹소켓을 위한 메소드를 지원하는 인터페이스
 	 * -> WebSocketHandler 인터페이스를 구현하는 클래스(TextWebSocketHandler)을 이용해서 웹소켓 기능을 구현할 예정
	 * 
	 * * 웹소켓 핸들러 주요 메서드 *
	 * 
	 *  void handleMessage(WebSocketSession session, WebSocketMessage message)
	 *  - 클라이언트로부터 메세지가 도착했을시 실행
	 *  
	 *  void afterConnectionEstablished(WebSocketSession session)
	 *  - 클라이언트와 연결이 완료되고 , 통신할 준비가 완료되면 실행
	 *  
	 * 	void afterConnectionClosed( WebSocketSession session, CloseStatus closeStatus)
	 *  - 클라이언트와 연결이 종료되면 실행
	 *  
	 *  void handlerTransportError(WebSocketSession session, Throwable execprion)
	 *   - 메세지 전송중 에러발생하면 실행
	 * 
	 * */
	
	@Autowired
	private ChatService chatService;
	
	private Set<WebSocketSession> sessions = Collections.synchronizedSet( new HashSet<WebSocketSession>());
	
	private Map< String, Object > map  = new HashMap<>();	
	
	private void saveChatRoomListToSession(WebSocketSession session, List<Integer> chatRoomList) {
	    session.getAttributes().put("chatRoomList", chatRoomList);
	}
	
	// synchronizedSet : 동기화된 Set반환
    // -> 멀티 스레드 환경에서 하나의 컬렉션 요소에 여러 스레드가 동시에 접근하면 충돌이 발생할 수 있으므로 동기화를 진행
	
	// 클라이언트와 연결이 수립되고, 통신준비가 완료되면 수행되는 메소드
		@Override
		public void afterConnectionEstablished(WebSocketSession session) {
			
			// WebSocketSession : 웹소켓에 접속/요청한 클라이언트의 세션 정보
			System.out.println(session.getId()+" 연결됨");
			
			System.out.println();
			
			sessions.add(session); // 전달받은 session을 set에 추가
			List<Integer> chatRoomList = (List<Integer>) session.getAttributes().get("chatRoomList");
		    map.put(session.getId(), chatRoomList);
		    map.put(session.getId() + "userNo", (int) session.getAttributes().get("userNo"));
		    
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
			
			Member loginUser = (Member)session.getAttributes().get("loginUser");
			
			//payLoad : 전송되는 데이터(json객체)
			System.out.println("메세지 : " + message.getPayload());
			

			// JackSon라이브러리  : java에서 json을 다루기 위한 라이브러리
			// JackSon-databind -> ObjectMapper를 이용해서 JSON형태로 넘어온 데이터를 특정 VO필드에 맞게 자동 매핑
			ObjectMapper objectMapper = new ObjectMapper();
			
			Chat chatMessage = objectMapper.readValue(message.getPayload(), Chat.class); 
			
			//룸생성되었을때 올라온 요청건임
			if(chatMessage.roomNew()) {
				/*
				 * 여기서 db를 한번 조회해오긴 해야함
				 * 신규 룸번호에 딸린 유저들 조회해와서 chatService.chatRoomList(룸번호를 넘겨서 여기 참여중인 유저 목록 받아오기)
				 * 저장되어있는 세션들 돌면서
				 * map에서 get(세션아이디+"userNo")  ==  각 세션 userNo 
				 * 참여중인 유저 목록이랑 비교해서 참여중인 유저라면 아래 로직 진행
				 * 세션들의 아이디를 getId로 가져와서 map.get(세션아이디값) -> chatRoomList 반환할것임
				 * chatRoomList 여기에 룸번호 추가하고 
				 * map.put(session.getId() , 가공한 chatRoomList);
				 * (맵에 기존에 있던 세션.아디 키값을 아예 삭제하고 다시 넣어주는 식으로 해도됨)
				 * 룸 리스트에 신규 룸번호 추가해서 다시 저장해주기
				 * 
				 * 
				 * 신규 룸 생성용이니까 이후 로직은 진행하지 않고 return 시키거나
				 * 취향대로 이후동작 선택
				 * */
				List<ChatParticipant> participants = chatService.getParticipantsInRoom(chatMessage.getChatRoomNo());
				
				 for (WebSocketSession s : sessions) {
				        String sessionId = s.getId();
				        int userNo = (int) map.get(sessionId + "userNo");
				        boolean isParticipant = false;	
				        for (ChatParticipant participant : participants) {
				            if (participant.getUserNo() == userNo) {
				                isParticipant = true;
				                break;
				            }
				        }
				        if (isParticipant) {
				            // 해당 세션의 chatRoomList 가져오기
				        	ArrayList<Integer> chatRoomList = (ArrayList<Integer>) map.get(sessionId);
				            if (chatRoomList == null) {
				                chatRoomList = new ArrayList<>();
				            }
				            chatRoomList.add(chatMessage.getChatRoomNo());
				            map.put(sessionId, chatRoomList);				            			            				            	
				        }
				    }
				 return;
			}
			
			
			
			chatMessage.setReceivedDate(new Timestamp(System.currentTimeMillis()));
			// 전달받은 채팅 메세지를 db에 삽입

			chatMessage.setProfileImg(loginUser.getProfileImg());	
			chatMessage.setUserName(loginUser.getUserName());
			chatMessage.setUserNo(loginUser.getUserNo());
			
	//		System.out.println(chatMessage);
			int result = chatService.insertMessage(chatMessage);
			
			if(result > 0) {
				// 같은 방에 접속중인 클라이언트에게 전달받은 메세지 뿌리기
				for( WebSocketSession s : sessions ) {
					// 반복을 진행중인 WebSocketSession 안에 담겨있는 방번호 == 메세지 안에 담겨있는 방번호가 일치하는 경우 메세지 뿌리기
				//	System.out.println(s.getAttributes());
					
					ArrayList<Integer> chatRoomList = (ArrayList<Integer>) map.get(s.getId());
										
					for(int room : chatRoomList) {
						
							if(room == chatMessage.getChatRoomNo()) {
								s.sendMessage(new TextMessage( new Gson().toJson(chatMessage) ));
								break;
							}
						
					}
					
//					// 메세지에 담겨있는 채팅방 번호와 chatRoomNo 일치하는지 비교
//					if(chatMessage.getChatRoomNo() == chatRoomNo) {
//						// 같은 방 클라이언트에게 json형태로 메세지를 보냄
//						// s.sendMessage( new TextMessage( JSON객체 ) )
//						s.sendMessage(new TextMessage( new Gson().toJson(chatMessage) ));
//					}
				
				}
			}
			
		
		}
		
		
		
	

}
