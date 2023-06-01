package com.company.opeaceful.commom.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggingInterceptor extends HandlerInterceptorAdapter {

	static Logger logger = LoggerFactory.getLogger(LoggingInterceptor.class);
	
	// ����ڰ� ������� �ڵ��� ����
	static String logMp[] = {"iphone", "ipod", "android", "blackberry", "opera mobi"};
	
	
	/*
	 * ��� ��η� ������ ��û������ ���� �α������� ����� ���� �޼ҵ�
	 * 
	 * */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		// ���ӵ� ��� �������� (��/�����)
		String currentDevice = "web";
		String logUA = request.getHeader("user-agent").toLowerCase();
		for(String decice : logMp) {
			if(logUA.indexOf(decice) > -1) {
				currentDevice = "mobile";
				break;
			}
		}
		
		// ������ url, �������� �߰�
		HttpSession session = request.getSession();
		
		String currentDomain = request.getServerName();
		int currentPort = request.getServerPort();
		
		String queryString = "";
		if(request.getMethod().equals("GET")) {
			queryString = request.getQueryString();
		}else {
			Map map = request.getParameterMap();
			
			Object[] keys = map.keySet().toArray();
			
			for(int i =0; i< keys.length; i++) {
				if(i>0) {
					queryString += "&";
				}
				String[] values = (String[]) map.get(keys[i]);
				// ������ Ű������ ���� �� ������ ��������
				
				queryString += keys[i] + "=";
				
				int count = 0;
				
				for(String str : values) {
					if(count > 0 ) {
						queryString += ",";
					}
					
					queryString += str;
					count++;
				}
			}
		}
		
		// �Ķ���Ͱ� �ƿ� ���ٸ�, ���ʿ� �α������� ���Խ�Ű�� ���� ������
		if(queryString == null || queryString.trim().length() == 0) {
			queryString = null;
		}
		
		//ip���� �߰�
		String uri = request.getRequestURI();
		String ip = getIp(request);
		
		// �������� ���� �߰� s == secure
		String protocol = (request.isSecure()) ? "https" : "http";
		
		// ���̵� ���� �߰�
		String userId = "";
		
		/*
		 * Member user = (Member) session.getAttribute("loginUser"); if(user != null) {
		 * userId = user.getUserId(); }
		 */
		logger.info(ip+":"+currentDevice+":"+userId+":"+protocol+"://"+currentDomain
				+":"+currentPort+uri+(queryString !=null ? "?"+queryString : ""));
		
		return true;
	}
	
	public String getIp(HttpServletRequest request){
		 String ip = request.getHeader("X-Forwarded-For");
	
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
}
