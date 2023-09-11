package com.project.third.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.third.mapper.PostMapper;
import com.project.third.model.PostVO;

@Service
public class PostServiceImpl implements PostService{
	@Autowired
	PostMapper postmapper;
	
	@Override
	public int insertPost(PostVO vo) {
		return postmapper.insertPost(vo);
	}
	@Override
	public List<PostVO> getPostList(int num){
		return postmapper.getPostList(num);
	}

	@Override
	public PostVO getPostDetail(int id) {
		return postmapper.getPostDetail(id);
	}
	@Override
	public void deletePost(int id) {
		postmapper.deletePost(id);
	}
	@Override
	public void updatePost(PostVO vo) {
		postmapper.updatePost(vo);
	}
	
	@Override
	public List<PostVO> getBoardPostListPage(int boardId, int num){
		return postmapper.getBoardPostListPage(boardId, num);
	}

	@Override
	public int getCount() {
		return postmapper.getCount();
	}
	@Override
	public int getBoardAuth(int boardId) {
		return postmapper.getCount();
	}
	@Override
	public int getBoardCount(int boardId) {
		return postmapper.getBoardCount(boardId);
	}
}
