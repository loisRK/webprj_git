package com.iot.pf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot.pf.dao.CommentDao;
import com.iot.pf.dto.Comment;
import com.iot.pf.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentDao dao;
	
	@Override
	public int insert(Comment comment) throws Exception {
		int result = dao.insert(comment);
		if(result != 1) throw new Exception();
		return result;
	}

	@Override
	public int count(int postNum) {
		return dao.count(postNum);
	}

	@Override
	public ArrayList<Comment> commentPaging(HashMap<String, Object> params) {
		return dao.commentPaging(params);
	}

	@Override
	public void delete(int comNum) throws Exception {
		int result = dao.delete(comNum);
		if(result != 1) throw new Exception();
	}

	@Override
	public int updateCom(Comment c) throws Exception {
		int result = dao.updateCom(c);
		if(result != 1) throw new Exception();
		return result;
	}

	@Override
	public Comment getOneCom(int comNum) {
		return dao.getOneCom(comNum);
	}

	
}
