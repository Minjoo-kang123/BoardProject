package com.project.third.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.project.third.model.UserVO;

public class AuthInterceptor  implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession session = request.getSession();
		UserVO user = new UserVO(); 
		user = (UserVO)session.getAttribute("user");
		
		if(user.getAuth() == 0) {
			response.sendRedirect("/alert"); // 경고창을 띄워준 뒤 main이동
			return false;
		}
		return true;
	}
}
