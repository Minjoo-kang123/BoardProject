package com.project.third.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.third.mapper.UserMapper;
import com.project.third.model.UserVO;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper membermapper;

	/* 회원가입 */
	@Override
	public void userJoin(UserVO user) throws Exception {
		membermapper.userJoin(user);	
	}
	@Override
	public UserVO userLogin(String userId,String password) throws Exception {	
		return membermapper.userLogin(userId, password);
	}
	@Override
	public int idCheck(String userId) throws Exception {
		return membermapper.idChecking(userId);
	}
	@Override
	public UserVO getUser(String userId) throws Exception {
		return membermapper.getUser(userId);
	}
	@Override
	public List<UserVO> getSpUserList() throws Exception{
		return membermapper.getSpUserList();
	}
	@Override
	public List<UserVO> getUserList() throws Exception{
		return membermapper.getUserList();
	}
	@Override
	public void userSubmit(String userId) throws Exception{
		membermapper.userSubmit(userId);
	}
	@Override
	public void deleteUser(String userId) throws Exception{
		membermapper.deleteUser(userId);
	}
}
