package com.iot.pf.service;

import java.util.ArrayList;

import com.iot.pf.dto.Attachment;

public interface AttachmentService {
	
	/**
	 * attachSeq로 table에서 첨부파일 삭제하기
	 * @param seq	파일번호(attachment table)
	 * @return
	 */
	public void deleteAtt(int attachSeq);
	
	/**
	 * seq로 파일 하나불러오기
	 * @param seq 파일번호(attachment table)
	 * @return
	 */
	public Attachment getOneAttach(int seq);

	/**
	 * 글번호로 그 글에 포함된 파일 모두 가져오기
	 * @param docType	"free"
	 * @param seq	글번호(free_board table)
	 * @return
	 */
	public ArrayList<Attachment> getAttachment(String docType, int seq);

	/**
	 * 파일 저장하기(db에)
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
