package com.iot.pf.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.iot.pf.dto.Album;

public interface AlbumService {
	
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
	public void deletePhoto(int pSeq);
	
	/**
	 * 사진 앨범에 보여주기위해 DB에 등록
	 * @param aInfo
	 * @throws IOException
	 */
	public void addAlbum(List<Album> aInfo) throws IOException;

}
