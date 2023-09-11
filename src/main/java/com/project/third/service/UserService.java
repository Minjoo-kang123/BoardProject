package com.project.third.service;

import java.util.List;

import com.project.third.model.UserVO;

public interface UserService {

	/* 회원가입 */
	public void userJoin(UserVO user) throws Exception;
	public UserVO userLogin(String userId, String password) throws Exception;
	public List<UserVO> getSpUserList() throws Exception;
	public List<UserVO> getUserList() throws Exception;
	public int idCheck(String userId) throws Exception;
	public UserVO getUser(String userId) throws Exception;
	public void userSubmit(String userId) throws Exception;
	public void deleteUser(String userId) throws Exception;
}
