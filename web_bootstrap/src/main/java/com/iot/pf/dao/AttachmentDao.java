package com.iot.pf.dao;

import java.util.ArrayList;

import com.iot.pf.dto.Attachment;

public interface AttachmentDao {
	
	/**
	 * seq로 table에서 첨부파일 삭제하기
	 * @param seq
	 * @return
	 */
	public int deleteAtt(int seq);

	/**
	 * seq로 파일 하나불러오기
	 * @param seq
	 * @return
	 */
	public Attachment getOneAttach(int seq);
	
	/**
	 * 첨부된 파일들을 불러오기
	 * @param docType
	 * @param seq 
	 * @return
	 */
	public ArrayList<Attachment> getAttachment(String docType, int seq);
	
	/**
	 * 첨부파일 등록
	 * @param attachment
	 * @return
	 */
	public int insert(Attachment attachment);
	
	/**
	 * 글번호로 그 글에 달린 attachment 갯수 가져오기
	 * @param postNum
	 * @return
	 */
	public int countAtt(int postNum);
	
}
