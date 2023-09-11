package com.project.third.mapper;

import java.util.List;

import com.project.third.model.UserVO;

public interface UserMapper {
	public void userJoin(UserVO user);
	public UserVO userLogin(String userId, String password);
	public int idChecking(String userId);
	public List<UserVO> getSpUserList() throws Exception;
	public List<UserVO> getUserList() throws Exception;
	public UserVO getUser(String userId);
	public void userSubmit(String userId) throws Exception;
	public void deleteUser(String userId) throws Exception;
}

