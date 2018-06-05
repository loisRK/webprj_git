package com.iot.pf.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.Freeboard;

public interface FreeboardService {

	/**
	 * 게시글 등록(첨부파일 정보포함)
	 * @param board 게시글
	 * @param files 첨부파일
	 * @author jYeory
	 */
	public void writeWithFileInfo(Freeboard board, List<Attachment> info) throws IOException ;
	
	/**
	 * 게시글 수정(첨부파일 정보포함)
	 * @param board 게시글
	 * @param files 첨부파일
	 * @author jYeory
	 */
	public void updateWithFileInfo(Freeboard board, List<Attachment> info) throws IOException;
	
	/**
	 * 게시글 댓글 갯수 업로드해주기
	 * @param totalComment
	 * @param postNum
	 * @throws Exception
	 */
	public void updateComment(HashMap<String, Object> params) throws Exception;
	
	/**
	 * 수정할 때, 첨부파일 번호로 첨부파일 삭제하기
	 * @param attachSeq
	 * @throws Exception
	 */
	public int delAttachedFile(int attachSeq) throws Exception;
	
	/**
	 * 게시글 등록(첨부파일 포함)
	 * @param board 게시글
	 * @param files 첨부파일
	 */
	public void writeWithFile(Freeboard board, List<MultipartFile> files);

	/**
	 * paging
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
	 * 특정 게시글 조회
	 * @param postNum
	 * @return
	 */
	public Freeboard findByNum(int postNum);
	
	/**
	 * (DELETE)글 삭제 
	 * @param postNum
	 * @return
	 */
	public void delete(int postNum, String userId, ArrayList<Attachment> aList) throws Exception;
	
	/**
	 * 특정 게시글을 조회하고 조회수를 증가 시킨다.
	 * throws -> 예외가 발생할 수 있다고 미리 표시
	 * @param postNum(글번호)
	 * @return BoardDao
	 */
	public Freeboard readArticle(int postNum) throws Exception;
}
