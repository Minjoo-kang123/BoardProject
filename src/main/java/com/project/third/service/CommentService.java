package com.project.third.service;

import java.util.List;

import com.project.third.model.CommentVO;

public interface CommentService {
	public void insertComment(CommentVO vo);
	public List<CommentVO> getCommentList(int postId);
	public void deleteComment(int commentId);
}
