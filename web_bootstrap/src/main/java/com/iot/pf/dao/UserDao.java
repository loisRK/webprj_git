package com.iot.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.User;

public interface UserDao {
	
	/**
	 * user list 가져오기
	 * @param params
	 * @return
	 */
	public ArrayList<User> list(HashMap<String, String> params);
	
	/**
	 * 중복되는 아이디 갯수를 검색하기
	 * @param u
	 * @return 겹치는 아이디 갯수
	 */
	public int chkId(String userId);
	
	/**
	 * 입력한 id로 사용자 정보 조회하기
	 * @param params
	 * @return
	 */
	public User getUserById(String userId);
	
	/**
	 * 회원번호(seq)로 user정보 가져오기
	 * @param seq
	 * @return
	 */
	public User getUserBySeq(int seq);
	
	/**
	 * 로그인화면에서 입력한 비밀번호 암호화
	 * @param text
	 * @return 암호화된 문자열
	 */
	public String getEncText(String text);
	
	/**
	 * (INSERT) 사용자 추가하기
	 * @param user
	 * @return
	 */
	public int join(User user);
	
	/**
	 * (UPDATE)사용자가 사용자 정보 수정하기(email, nickname, pw)
	 * @param user
	 * @return
	 */
	public int update(User user);
	
	/**
	 * (DELETE) userId로 사용자 삭제
	 * @param userId
	 * @return
	 */
	public int delete(String userId);
	
	/**
	 * user 수 조회
	 * @param params
	 * @return
	 */
	public int totalCount(HashMap<String, String> params);
	
	/**
	 * (UPDATE)admin이 사용자 정보 수정하기(email, nickname)
	 * @param HashMap<String, String> params
	 * @return
	 */
	public int editUser(HashMap<String, String> params);
	
}
