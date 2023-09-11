package com.project.third.controller;

import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.third.model.UserVO;
import com.project.third.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userservice;
	@Autowired
	private JavaMailSender mailSender;
	
	//회원가입 페이지 이동
	@RequestMapping(value="/user/join", method=RequestMethod.GET)
	public void joinGET() {
	}
	
	//로그인 페이지 이동
	@RequestMapping(value="/user/login", method = RequestMethod.GET)
	public void loginGET() {
	}
	
	@RequestMapping(value="/user/join", method=RequestMethod.POST)
	public String joinPOST(HttpServletRequest request, UserVO user,  RedirectAttributes attributes) throws Exception{
		int check = userservice.idCheck(user.getUserId());
		if(check > 0) {
			String message = "중복된 아이디입니다. 다시 입력해주세요";
			attributes.addFlashAttribute("error", message);
			return "redirect:/user/join";
		}
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		
		String phone = phone1 + phone2 + phone3;
		user.setPhone(phone);
		userservice.userJoin(user);
		return "redirect:/";
		
	}
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, UserVO member, RedirectAttributes rttr) throws Exception{
		HttpSession session = request.getSession();
		
		String userId = (String) request.getParameter("userId");
		String password = (String) request.getParameter("password");
		System.out.println(userId + " " + password);
		
		UserVO user = userservice.userLogin(userId, password);
		System.out.println(userId + " " + password);
		if(user != null) {
			session.setAttribute("user", user); 	// session에 멤버 정보 설정 > 해당 정보를 통해 로그인 여부 및 관련 정보 가져오기 가능
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("result", 0);			
			return "redirect:/user/login";	// 틀렸을 시 다시 돌아가기
		}
	}
	
	@RequestMapping(value="/user/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, UserVO user, RedirectAttributes rttr) throws Exception{
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public ModelAndView userList() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/userlist");
		List<UserVO> userList = userservice.getSpUserList();
		List<UserVO> allUserList = userservice.getUserList();
		mv.addObject("allUserList", allUserList);
		mv.addObject("userList", userList);
		return mv;
	}
	
	@RequestMapping(value="/admin/userdetail", method=RequestMethod.GET)
	public ModelAndView getUser(HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		String userId = (String)request.getParameter("userId");
		System.out.println(userId);
		UserVO userinfo = userservice.getUser(userId);
		
		mv.setViewName("/admin/userdetail");
		mv.addObject("userinfo", userinfo);
		return mv;
	}
	
	@RequestMapping(value="/admin/submit", method=RequestMethod.POST)
	public String submitPOST(HttpServletRequest request, RedirectAttributes attributes) throws Exception{
		String userid = request.getParameter("userid");
		String email = request.getParameter("email");
		userservice.userSubmit(userid);
		//이메일 전송
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
			messageHelper.setFrom("qyahzn1324@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject("회원가입승인"); // 메일제목
			messageHelper.setText(userid + "의 회원 가입이 승인되었습니다. 지금부터 홈페이지를 이용가능합니다."); // 메일 내용
			mailSender.send(mimeMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		System.out.println("아이디" + userid);
		return "redirect:/admin";
	}
	
	@RequestMapping(value="/admin/delete", method=RequestMethod.POST)
	public String deletePOST(HttpServletRequest request, RedirectAttributes attributes) throws Exception{
		String userid = request.getParameter("userid");
		String email = request.getParameter("email");
		
		//이메일 전송
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
			messageHelper.setFrom("qyahzn1324@gmail.com"); // 보내는사람 메일
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject("회원가입거부"); // 메일제목
			messageHelper.setText(userid + "의 회원 가입이 거부되었습니다. 기재한 정보는 모두 삭제처리되었습니다. 다시 입력한 뒤 시도해주세요"); // 메일 내용
			mailSender.send(mimeMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		userservice.deleteUser(userid);
		return "redirect:/admin";
	}

}
