package com.company.opeaceful.commom.interceptor;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.board.model.vo.BoardType;

public class BoardTypeInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	private BoardService boardService;
	
	@Override // 전치리할 메서드 작성
	public boolean preHandle(HttpServletRequest request , HttpServletResponse response, Object handler) {
		
		ServletContext application = request.getServletContext();
		
		if(application.getAttribute("boardTypeList") == null) {
			ArrayList<BoardType> list = boardService.selectBoardTypeList();
			System.out.println(list);
			application.setAttribute("boardTypeList", list);
		}
		return true;
	}
	
	
}
