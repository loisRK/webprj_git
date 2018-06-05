package com.iot.pf.dao;

import java.util.ArrayList;

import com.iot.pf.dto.Album;

public interface AlbumDao {

	/**
	 * album에 사진 등록
	 * @param album
	 * @return
	 */
	public int insert(Album album);
	
	/**
	 * 저장된 사진 불러오기
	 * @param pType
	 * @param pSeq
	 * @return
	 */
	public ArrayList<Album> getPhotos();
	
	/**
	 * pSeq로 사진 하나 불러오기
	 * @param pSeq
	 * @return
	 */
	public Album getOnePhoto(int pSeq);
	
	/**
	 * pSeq로 사진 삭제하기
	 * @param pSeq
	 * @return
	 */
	public int deletePhoto(int pSeq);
	
}
