package com.iot.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.Freeboard;


public interface FreeboardDao {

	/**
	 * 게시물 리스트업
	 * @param params
	 * @return
	 */
	public ArrayList<Freeboard> paging(HashMap<String, Object> params);
	
	/**
	 * 총 게시물 수 세기
	 * @return
	 */
	public int count(HashMap<String, String> params);
	
	/**
	 * (INSERT) 글쓰기
	 * @param user
	 * @return
	 */
	public int insert(Freeboard board);
	
	/**
	 * (UPDATE)글 수정하기(글 제목, 글 내용)
	 * @param user
	 * @return
	 */
	public int update(Freeboard board);
	
	/**
	 * 댓글쓸때 댓글 총 갯수 카운팅해서 게시글 정보로 넣어주기
	 * @param hasComment
	 * @param postNum
	 * @return
	 */
	public int updateComment(HashMap<String, Object> params);
	
	/**
	 * (DELETE)글 삭제
	 * @param user
	 * @return
	 */
	public int delete(int postNum);
	
	/**
	 * 게시글 열람 시 페이지 조회 수 증가
	 * @param postNum(글번호)
	 * @return SQL 수정되면 1, 에러나면 0
	 */
	public int updateHits(int postNum);
	
	/**
	 * 특정 게시글 조회
	 * @param postNum
	 * @return
	 */
	public Freeboard findByNum(int postNum);
	
	
}
