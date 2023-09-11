package com.project.third.mapper;

import java.util.List;

import com.project.third.model.PostVO;

public interface PostMapper {
	public int insertPost(PostVO vo);
	public List<PostVO> getPostList(int num);
	public PostVO getPostDetail(int id);
	public void deletePost(int id);
	public void updatePost(PostVO vo);
	public List<PostVO> getBoardPostListPage(int boardId, int num);
	public int getCount();
	public int getBoardCount(int boardId);
	public int getBoardAuth(int boardId);
}
