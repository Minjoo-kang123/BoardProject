package com.project.third.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.*;

import com.project.third.model.PostVO;
import com.project.third.model.UserVO;
import com.project.third.model.FileVO;
import com.project.third.service.FileService;
import com.project.third.service.PostService;


@Controller
public class PostController {	
	@Autowired
	private PostService postservice;
	@Autowired
	private FileService fileservice;
	
	String[] board = {""};
	@RequestMapping(value="/post/write", method=RequestMethod.GET)
	public void writeGET() {
		System.out.println("write 페이지 접근");
	}
	@RequestMapping(value="/alert", method=RequestMethod.GET)
	public String alertGET(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = new UserVO(); 
		user = (UserVO)session.getAttribute("user");
		
		if(user.getAuth() == 0) {
			request.setAttribute("msg", "해당 기능은 회원 승인 후 이용해주세요");
			request.setAttribute("url", "/");
		}
		return "alert";
	}
	@RequestMapping(value="/faq", method = RequestMethod.GET)
	public void faqGET() {
		System.out.println("faq 페이지 진입");
	}
	
	@RequestMapping(value="/post/write", method=RequestMethod.POST)
	public String writePOST(HttpServletRequest request, PostVO post, @RequestParam("upfile") MultipartFile[] files, RedirectAttributes rttr) throws Exception{
		HttpSession session = request.getSession();
		UserVO user = new UserVO(); 
		user = (UserVO)session.getAttribute("user");

		String writer = user.getUserId();
		post.setUserId(writer);
		
		int postid = postservice.insertPost(post);
		postid = post.getPostId();
		System.out.println(postid + "번 게시글 입니다.");
		
		
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String realPath = contextRoot+"resources\\fileupload\\";
		System.out.println(realPath);
        File folder = new File(realPath);
        
        if(!folder.exists())
            folder.mkdirs();
        
        for (MultipartFile mfile : files) {
        	FileVO file = new FileVO();
            String originalFileName = mfile.getOriginalFilename();
            if (!originalFileName.isEmpty()) {
                String saveFileName = UUID.randomUUID().toString() + originalFileName.substring(originalFileName.lastIndexOf('.'));
                file.setOriginalname(originalFileName);
                file.setSavename(saveFileName);
                file.setPostId(postid);
                fileservice.insertFile(file);
                System.out.println(mfile.getOriginalFilename() + "   " + saveFileName);
                mfile.transferTo(new File(folder, saveFileName));
            }
        }
		return "redirect:/";
	}
	
	
	@RequestMapping(value="/post/detail", method=RequestMethod.GET)
	public ModelAndView postDetail(HttpServletRequest request, @RequestParam(value = "id") int postId, RedirectAttributes attributes) throws Exception {
		System.out.println("detail 페이지 접근");
		HttpSession session = request.getSession();
		UserVO user = new UserVO(); 
		user = (UserVO)session.getAttribute("user");
		ModelAndView mv = new ModelAndView();
		
		if(user.getAuth() == 0) {
			mv.setViewName("redirect:/");
			return mv;
		}
		mv.setViewName("/post/detail");
		PostVO post = postservice.getPostDetail(postId);
		mv.addObject("post", post);
		List<FileVO> fileList = fileservice.getFileList(postId);
		mv.addObject("fileList",fileList);
		return mv;
	}
	
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public ModelAndView getBoardPost(HttpServletRequest request, @RequestParam(value = "id",  defaultValue= "1") int boardId, @RequestParam(value = "num") int page, RedirectAttributes attributes) throws Exception {
		System.out.println("Board별 list 접근");

		//페이징
		int count = postservice.getBoardCount(boardId);
		int pageNum = (int)Math.ceil((double)count/20);
		int displayPost = (page - 1) * 20;
		
		int pageNum_cnt = 10;
		int endPageNum = (int)(Math.ceil((double)page / (double)pageNum_cnt) * pageNum_cnt);
		int startPageNum = endPageNum - (pageNum_cnt - 1);
		 
		if(endPageNum > pageNum) {
			 endPageNum = pageNum;
		}
		boolean prev = startPageNum == 1 ? false : true;
		boolean next = endPageNum >= pageNum ? false : true;
		
		ModelAndView mv = new ModelAndView();

		mv.setViewName("board");
		List<PostVO> postList = postservice.getBoardPostListPage(boardId, displayPost);
		
		mv.addObject("startPageNum", startPageNum);
		mv.addObject("endPageNum", endPageNum);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		mv.addObject("postList", postList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("boardId", boardId);
		mv.addObject("boardList", board);
		return mv;
	}
	
	
	@RequestMapping(value="post/delete", method=RequestMethod.GET)
	public String deletePost(@RequestParam("id") int id) throws Exception {
		System.out.println(id + "삭제");
		postservice.deletePost(id);
		return "redirect:/";
	}
	
	@RequestMapping(value="post/update", method=RequestMethod.GET)
	public ModelAndView updatePost(HttpServletRequest request, @RequestParam("id") int id, RedirectAttributes attributes) throws Exception {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("/post/update");
		PostVO post = postservice.getPostDetail(id);
		mv.addObject("post", post);
		return mv;
	}
	
	@RequestMapping(value="post/update", method=RequestMethod.POST)
	public ModelAndView updatingPost(PostVO vo) throws Exception {
		postservice.updatePost(vo);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/post/detail");
		mv.addObject("post", vo);
		List<FileVO> fileList = fileservice.getFileList(vo.getPostId());
		mv.addObject("fileList",fileList);
		return mv;
	}
}
