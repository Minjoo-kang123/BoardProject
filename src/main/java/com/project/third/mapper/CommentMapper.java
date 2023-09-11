package com.project.third.mapper;

import java.util.List;

import com.project.third.model.CommentVO;

public interface CommentMapper {
	public void insertComment(CommentVO vo);
	public List<CommentVO> getCommentList(int postId);
	public void deleteComment(int commentId);
}
