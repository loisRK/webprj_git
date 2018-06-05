package com.iot.pf.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dto.Album;

// 포토앨범에 사진 업로드 & 다운로드 할 유틸리티 클래스
@Component
public class AlbumUtil {

	@Value("${photo.upload.directory}")
	private String photoUploadDirectory;

	@Value("${photo.upload.tmp.directory}")
	private String tmpDirectory;
	
	@Value("${thumb.upload.directory}")
	private String thumbUploadDirectory;

	private static Logger logger = Logger.getLogger(AlbumUtil.class);

	/**
	 * 임시 폴더에 있는 업로드 된 파일을 업로드 폴더로 복사
	 * @param a
	 * @throws IOException
	 */
	public void copyTmpFileToUploadFolder(Album a) throws IOException {
		// 임시파일 가져오기
		File source = new File(tmpDirectory, a.getpFakeName());
		
		// 썸네일 생성
		File thumbnailFile = new File(thumbUploadDirectory);
		// 썸네일 폴더없음 생성하기
		if(!thumbnailFile.exists())
			thumbnailFile.mkdirs();
		// 썸네일 폴더에 fakename으로 파일 생성하기
		thumbnailFile = new File(thumbUploadDirectory, a.getpFakeName());
		
		BufferedImage srcImage = ImageIO.read(source);	// 이미지 읽는거, source=사진파일
		BufferedImage scaledImage = Scalr.resize(srcImage, Scalr.Mode.FIT_TO_WIDTH, 120);	// 사진 변환
		// 120: 픽셀(사이즈)

		//	                  int x = (scaledImage.getWidth() / 2) - 50;
		//	                  int y = (scaledImage.getHeight() / 2) - 50;
		//	                  scaledImage = Scalr.crop(scaledImage, x, y, scaledSize, scaledSize);

		String extension = a.getpFileName().substring(a.getpFileName().lastIndexOf(".")).toLowerCase();
		// 'jpg' 확장자 짤라내는 거
		ImageIO.write(scaledImage, extension.substring(1, extension.length()), thumbnailFile);
		// thumbnailFIle에 scaledImage를 'jpg'형식으로 write

		
		// 업로드 폴더 지정
		File dest = new File(photoUploadDirectory);
		// 폴더없으면 생성하기 & 지정하기
		if(!dest.exists()) dest.mkdirs();
		dest = new File(dest, a.getpFakeName());

		//임시폴더에 있는 업로드 파일을 업로드 폴더로 복사
		FileCopyUtils.copy(FileUtils.readFileToByteArray(source), dest);
	}

	/**
	 * 비동기 사진 업로드 임시 폴더에 저장
	 * @param f
	 * @param pType
	 * @return
	 */
	public Album copyToTmpFolder(MultipartFile f) {
		Album a = null;
		if(!f.isEmpty()) {
			a = new Album();
			a.setpFileName(f.getOriginalFilename());
			a.setpFileSize(f.getSize());
			String fakeName = UUID.randomUUID().toString();
			a.setpFakeName(fakeName);
			a.setpType(f.getContentType());

			copyToFolder(f, fakeName, true);
		}
		return a;
	}

	/**
	 * 첨부파일을 서버 물리 저장소에 복사
	 * @param files	업로드한 파일
	 * @param fakename	서버에 저장할 가짜 파일명
	 * @param isTmp	임시파일이면 true, 아니면 false
	 */
	public void copyToFolder(MultipartFile files, String fakename, boolean isTmp) {
		// 저장할 폴더 생성
		File target = new File( isTmp? tmpDirectory : photoUploadDirectory);
		if(!target.exists())
			target.mkdirs();

		// target 폴더에 uuid를 이름으로 가진 새로운 파일 생성
		target = new File(target, fakename);

		// 물리저장소에 파일 쓰기
		try {
			FileCopyUtils.copy(files.getBytes(), target);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 사진 삭제 메서드
	 * @param a
	 */
	public void deleteFile(Album a) {
		logger.debug("AlbumUtil deleteFile - a: " + a);

		String uploadDir = "photoUploadDirectory";
		File file = new File(uploadDir + "/" + a.getpFakeName());
		if(file.exists()) {
			boolean p = file.delete();
			logger.debug("photo deleted ? " + p);
		}
	}


}
