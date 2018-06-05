package com.iot.pf.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iot.pf.dao.AttachmentDao;
import com.iot.pf.dto.Attachment;
import com.iot.pf.service.AttachmentService;
import com.iot.pf.util.FileUtil;

@Service
public class AttachmentServiceImpl implements AttachmentService {

	@Autowired
	AttachmentDao dao;
	@Autowired
	FileUtil fUtil;
	
	@Override
	public ArrayList<Attachment> getAttachment(String docType, int seq) {
		return dao.getAttachment(docType, seq);
	}

	@Override
	public int insert(Attachment attachment) {
		return dao.insert(attachment);
	}

	@Override
	public Attachment getOneAttach(int seq) {
		return dao.getOneAttach(seq);
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public void deleteAtt(int attachSeq) {
		Attachment att = dao.getOneAttach(attachSeq);
		dao.deleteAtt(attachSeq);
		fUtil.deleteFile(att);		
	}

	@Override
	public int countAtt(int postNum) {
		return dao.countAtt(postNum);
	}		
}
