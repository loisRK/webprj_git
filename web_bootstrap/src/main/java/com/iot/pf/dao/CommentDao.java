package com.iot.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.Comment;

public interface CommentDao {
	
	/**
	 * (insert)comment 등록하기
	 * @param comment
	 * @return
	 */
	public int insert(Comment comment);
	
	/**
	 * 게시물에 달린 총 댓글 갯수 세기
	 * @param postNum
	 * @return
	 */
	public int count(int postNum);
	
	/**
	 * 존재하는 댓글 리스트업하기
	 * @param params
	 * @return
	 */
	public ArrayList<Comment> commentPaging(HashMap<String, Object> params);
	
	/**
	 * 댓글번호(comNum)으로 댓글 삭제하기
	 * @param comNum
	 * @return
	 * @throws Exception
	 */
	public int delete(int comNum);
	
	/**
	 * 댓글 수정하기
	 * @param c
	 * @return
	 */
	public int updateCom(Comment c);
	
	/**
	 * 댓글 번호로 댓글 정보 불러오기
	 * @param comNum
	 * @return
	 */
	public Comment getOneCom(int comNum);
}
