package com.project.third.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.third.mapper.CommentMapper;
import com.project.third.model.CommentVO;

@Service
public class CommentServiceImpl implements CommentService{
	@Autowired
	CommentMapper commentmapper;
	@Override
	public void insertComment(CommentVO vo) {
		commentmapper.insertComment(vo);
	}
	@Override
	public List<CommentVO> getCommentList(int postId){
		return commentmapper.getCommentList(postId);
	}
	@Override
	public void deleteComment(int commentId) {
		commentmapper.deleteComment(commentId);
	}
}
