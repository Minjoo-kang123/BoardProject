package com.project.third.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.third.model.CommentVO;
import com.project.third.model.UserVO;
import com.project.third.service.CommentService;

@Controller
public class CommentController {
	@Autowired
	private CommentService commentservice;
	
	@RequestMapping(value="/comment/insert", method=RequestMethod.POST)
	public CommentVO insertPOST(HttpServletRequest request, @RequestBody CommentVO comment) throws Exception{
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		System.out.println(comment.getContext()+ comment.getPostId());
		comment.setUserId(user.getUserId());
		commentservice.insertComment(comment);
		return comment;
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment/commentList", method = RequestMethod.GET)
	public List<CommentVO> getCommentList(@RequestParam("id") int postId) {
		return commentservice.getCommentList(postId);
	}
	@ResponseBody
	@RequestMapping(value="/comment/delete", method=RequestMethod.POST)
	public int deletetPOST(HttpServletRequest request, int commentId) throws Exception{
		commentservice.deleteComment(commentId);
		return 1;
	}
}
