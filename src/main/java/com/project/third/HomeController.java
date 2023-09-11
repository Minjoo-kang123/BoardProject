package com.project.third;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.third.model.PostVO;
import com.project.third.service.PostService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private PostService postservice;
	String[] board = {"","메뉴얼", "EDR 관련 문의", "보안 및 네트워크 지원", "그룹웨어 및 메일 지원", "서명 이미지 신청", "KIMS 지원 문의", "IP 신청"};
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView getPostpage(HttpServletRequest request, @RequestParam(value = "num", defaultValue= "1") int page, RedirectAttributes attributes) throws Exception {
		System.out.println("post별 list 접근");
		
		int count = postservice.getCount();
		int pageNum = (int)Math.ceil((double)count/20); // 총 페이지 넘버 갯수
		int displayPost = (page - 1) * 20; // 가져올 post의 시작점
		
		int pageNum_cnt = 10;
		int endPageNum = (int)(Math.ceil((double)page / (double)pageNum_cnt) * pageNum_cnt);
		int startPageNum = endPageNum - (pageNum_cnt - 1);
		
		System.out.println((int)(Math.ceil((double)page / (double)pageNum_cnt) * pageNum_cnt));
		if(endPageNum > pageNum) {
		 endPageNum = pageNum;
		}
		boolean prev = startPageNum == 1 ? false : true;
		boolean next = endPageNum >= pageNum ? false : true;
		
		ModelAndView mv = new ModelAndView();

		mv.setViewName("home");
		List<PostVO> postList = postservice.getPostList(displayPost);
		
		mv.addObject("startPageNum", startPageNum);
		mv.addObject("endPageNum", endPageNum);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		mv.addObject("postList", postList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("boardList", board);
		return mv;
	}
	
}
