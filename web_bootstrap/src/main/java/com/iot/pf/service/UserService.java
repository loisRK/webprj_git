package com.iot.pf.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.User;

public interface UserService {
	
	/**
	 * customer list 가져오기
	 * @param params
	 * @return
	 */
	public ArrayList<User> list(HashMap<String, String> params);
	
	/**
	 * 입력한 id로 사용자 정보 조회하기
	 * @param params
	 * @return
	 */
	public User getUserById(String userId);
	
	/**
	 * 회원번호(seq)로 사용자 정보 조회하기
	 * @param params
	 * @return
	 */
	public User getUserBySeq(int seq);
	
	/**
	 * 로그인정보(비밀번호)가 저장된 정보와 일치하는지 체크
	 * @param userId
	 * @param userPw
	 * @return
	 */
	public boolean comparePw(String userId, String userPw) throws Exception;
	
	/**
	 * 비밀번호 재설정 할 때, userId로 email일치여부 확인하기
	 * @param email
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public boolean compareEmail(String email, String userId) throws Exception;
	
	/**
	 * 아이디 중복 확인
	 * @param userId
	 * @return
	 */
	public int chkDuplicationId(String userId);
	
	/**
	 * 반환값이 1이 아닌경우 예외발시킴
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public int join(User user) throws Exception;
	
	/**
	 * 개인 프로필 업데이트하기
	 * @param user
	 * @throws Exception
	 */
	public void updateProfile(User user) throws Exception;
	
	/**
	 * user 수 조회
	 * @param params
	 * @return
	 */
	public int totalCount(HashMap<String, String> params);
	
	/**
	 * userId로 user삭제
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void delUser(String userId) throws Exception;
	
	/**
	 * (update)admin이 userId로 user정보 업데이트
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public void editUser(HashMap<String, String> params) throws Exception;
	
	/**
	 * 비밀번호변경
	 * @param user
	 * @throws Exception
	 */
	public void resetPw(HashMap<String, String> params) throws Exception;
	
}
