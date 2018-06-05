
package com.iot.pf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iot.pf.dao.UserDao;
import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@Service("userService")
@Transactional(rollbackFor= {Exception.class})
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;

	@Override
	public ArrayList<User> list(HashMap<String, String> params) {
		return dao.list(params);
	}

	// Service에서 예외를 던지면 Controller에서 받아야함
	@Override
	public int join(User user) throws Exception {
		int result = dao.join(user);
		if(result != 1) throw new AnomalyException(1, result);
		return result;
	}

	@Override
	public User getUserById(String userId) {
		return dao.getUserById(userId);
	}
	
	@Override
	public User getUserBySeq(int seq) {
		return dao.getUserBySeq(seq);
	}

	@Override
	public boolean comparePw(String userId, String userPw) throws Exception {
		int result = dao.chkId(userId);
		if(result != 1) throw new Exception("NOT_FOUND_USER_ID");

		// result = 1 이면 다음 코드가 수행 됨
		User u = dao.getUserById(userId);
		if(u.getUserPw().equals(dao.getEncText(userPw))) {
			return true;
		}
		return false;
	}

	@Override
	public int chkDuplicationId(String userId) {
		return dao.chkId(userId);
	}

	@Override
	public int totalCount(HashMap<String, String> params) {
		return dao.totalCount(params);
	}

	@Override
	public void delUser(String userId) throws Exception {
		int result = dao.delete(userId);
		if(result != 1) throw new AnomalyException(1, result);
	}

	@Override
	public void editUser(HashMap<String, String> params) throws Exception {
		int result = dao.editUser(params);
		if(result != 1) throw new AnomalyException();
	}

	@Override
	public boolean compareEmail(String email, String userId) throws Exception {
		int result = dao.chkId(userId);
		if(result != 1) throw new Exception("NOT_FOUND_USER_ID");
		
		User u = dao.getUserById(userId);
		if(!u.getEmail().equals(email)) {
			return false;
		}
		return true;
	}

	@Override
	public void resetPw(HashMap<String, String> params) throws Exception {
		User u = dao.getUserById(params.get("userId"));
		u.setUserPw(params.get("password"));
		
		int result = dao.update(u);
		if(result != 1) throw new Exception();
	}

	@Override
	public void updateProfile(User user) throws Exception {
		int result = dao.update(user);
		if(result != 1) throw new Exception();
	}

}
