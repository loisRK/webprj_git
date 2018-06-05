package com.iot.pf.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dao.AttachmentDao;
import com.iot.pf.dao.FreeboardDao;
import com.iot.pf.dao.UserDao;
import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.Freeboard;
import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.FreeboardService;
import com.iot.pf.util.FileUtil;

@Service("freeboardService")
public class FreeboardServiceImpl implements FreeboardService {

	@Autowired
	FreeboardDao dao;
	@Autowired
	UserDao uDao;
	@Autowired
	AttachmentDao aDao;
	@Autowired
	FileUtil fUtil;

	@Override
	public ArrayList<Freeboard> paging(HashMap<String, Object> params) {
		return dao.paging(params);
	}

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void delete(int postNum, String userId, ArrayList<Attachment> aList) throws Exception {
		// 삭제
		int result = dao.delete(postNum);	// 게시글 삭제
		for(Attachment att : aList) {
			aDao.deleteAtt(att.getAttachSeq());	// 게시글 번호로 찾은 첨부파일들 삭제
			fUtil.deleteFile(att);	// 물리저장소에서 삭제
		}			
		// 삭제 이상
		if(result != 1) throw new Exception("DELETE ERROR");
	}

	@Override
	public int count(HashMap<String, String> params) {
		return dao.count(params);
	}

	@Override
	public Freeboard readArticle(int postNum) throws Exception {
		int result = dao.updateHits(postNum);
		if(result != 1) throw new Exception("조회수 증가 오류!!");

		Freeboard board = dao.findByNum(postNum);

		return board;
	}

	@Override
	public Freeboard findByNum(int postNum) {
		return dao.findByNum(postNum);
	}

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void writeWithFile(Freeboard board, List<MultipartFile> files) {
		// 게시글 먼저 입력
		dao.insert(board);
		int postNum = board.getPostNum();

		if(board.getHasFile().equals("1")) {
			for(MultipartFile f : files) {
				if(!f.isEmpty()) {
					Attachment att = new Attachment();
					att.setAttachDocType("free");
					att.setAttachDocSeq(postNum);
					att.setFilename(f.getOriginalFilename());
					att.setFileSize(f.getSize());
					String fakeName = UUID.randomUUID().toString();
					att.setFakeName(fakeName);

					// 파일 입력
					aDao.insert(att);

					// 폴더에 복사
					fUtil.copyToFolder(f, fakeName, false);
				}
			}
		}
	}

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public int delAttachedFile(int attachSeq) throws Exception {
		Attachment att = aDao.getOneAttach(attachSeq);
		int docSeq = att.getAttachDocSeq();	// 게시글번호가져오기
		Freeboard board = dao.findByNum(docSeq);		// 게시글
		aDao.deleteAtt(attachSeq);	// 첨부파일삭제(DB)
		// 게시글에 남은 첨부파일 불러오기
		List<Attachment> remain = aDao.getAttachment("free", docSeq);
		if(remain.size() == 0) {	// 첨부파일이 없으면 0
			board.setHasFile("0");
			dao.update(board);
		}
		fUtil.deleteFile(att);		// 물리저장소에서 삭제		

		return docSeq;
	}
	
	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void writeWithFileInfo(Freeboard board, List<Attachment> info) throws IOException {
		// 게시글 먼저 입력
		dao.insert(board);
		int postNum = board.getPostNum();

		if(board.getHasFile().equals("1")) {
			for(Attachment att : info) {
				att.setAttachDocSeq(postNum);

				// 파일 입력
				aDao.insert(att);

				// 폴더에 복사
				fUtil.copyTmpFileToUploadFolder(att);
			}
		}
	}

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void updateWithFileInfo(Freeboard board, List<Attachment> info) throws IOException {
		// 게시글 먼저 입력
		dao.update(board);
		int postNum = board.getPostNum();

		if(board.getHasFile().equals("1")) {
			for(Attachment att : info) {
				// pk(attachSeq)가 없는 파일 정보만 insert/copy 한다.
				if(att.getAttachSeq() == 0) {
					att.setAttachDocSeq(postNum);
					
					// 파일 입력
					aDao.insert(att);
					
					// 폴더에 복사
					fUtil.copyTmpFileToUploadFolder(att);
				}
			}
		}
	}

	@Override
	public void updateComment(HashMap<String, Object> params) throws Exception {
		
		int result = dao.updateComment(params);
		
		if(result != 1) throw new Exception();
	}


}
