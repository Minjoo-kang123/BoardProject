package com.project.third.service;

import java.util.List;

import com.project.third.model.PostVO;


public interface PostService {
	public int insertPost(PostVO vo);
	public List<PostVO> getPostList(int num) throws Exception;
	public List<PostVO> getBoardPostListPage(int boardId, int num) throws Exception;
	public PostVO getPostDetail(int id) throws Exception;
	public void deletePost(int id) throws Exception;
	public void updatePost(PostVO vo);
	public int getCount();
	public int getBoardCount(int boardId);
	public int getBoardAuth(int boardId);
}
