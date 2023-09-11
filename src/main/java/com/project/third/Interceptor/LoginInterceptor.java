package com.project.third.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.project.third.model.UserVO;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession session = request.getSession();
		UserVO user = new UserVO(); 
		user = (UserVO)session.getAttribute("user");
		
		if(user == null) {
			response.sendRedirect("/user/login");
			return false;
		}
		return true;
	}
}
