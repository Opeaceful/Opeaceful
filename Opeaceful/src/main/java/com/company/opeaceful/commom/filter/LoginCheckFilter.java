package com.company.opeaceful.commom.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.opeaceful.member.model.vo.Member;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
// [지의] 로그인유저 필터
@WebFilter(urlPatterns = "/*")
public class LoginCheckFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginCheckFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
		
        String uri = httpRequest.getRequestURI(); // 현재 요청의 URI를 반환

        // 로그인 요청이거나 첫 페이지인 경우 필터 적용 X
        if (uri.contains("resources") ||  uri.equals(httpRequest.getContextPath() + "/login") || uri.equals(httpRequest.getContextPath() + "/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession();
        Member loginUser = (Member)session.getAttribute("loginUser");

        if (loginUser == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }

        chain.doFilter(request, response);
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
