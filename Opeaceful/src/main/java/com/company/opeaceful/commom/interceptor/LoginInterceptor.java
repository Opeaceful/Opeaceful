package com.company.opeaceful.commom.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.company.opeaceful.member.model.service.MemberService;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	private MemberService memberService;
	
	
}
