package com.iot.pf.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iot.pf.dao.AlbumDao;
import com.iot.pf.dto.Album;
import com.iot.pf.service.AlbumService;
import com.iot.pf.util.AlbumUtil;

@Service
public class AlbumServiceImpl implements AlbumService {

	@Autowired
	AlbumDao dao;
	@Autowired
	AlbumUtil aUtil;
	
	
	@Override
	public int insert(Album album) {
		return dao.insert(album);
	}
	
	@Override
	public ArrayList<Album> getPhotos() {
		return dao.getPhotos();
	}
	
	@Override
	public Album getOnePhoto(int pSeq) {
		return dao.getOnePhoto(pSeq);
	}
	
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public void deletePhoto(int pSeq) {
		Album a = dao.getOnePhoto(pSeq);
		dao.deletePhoto(pSeq);
		aUtil.deleteFile(a);
	}

	@Override
	public void addAlbum(List<Album> aInfo) throws IOException {
		for(Album a : aInfo) {
			// 폴더에 복사
			aUtil.copyTmpFileToUploadFolder(a);
			// 사진 DB 등록
			dao.insert(a);
		}
	}
	
	
	
}
