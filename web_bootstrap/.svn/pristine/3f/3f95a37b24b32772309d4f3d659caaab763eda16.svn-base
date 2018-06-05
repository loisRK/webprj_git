package com.iot.pf.util;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dto.Attachment;

// 첨부파일 업로드&다운로드를 할 유틸리티 클래스, @Component - spring bean으로 등록
@Component
public class FileUtil {

	@Value("${file.upload.directory}")
	private String fileUploadDirectory;
	
	@Value("${file.upload.tmp.directory}")
	private String tmpDirectory;
	
//	private String fileUploadDirectory = "c:/tmp/upload";
	
	private static Logger logger = Logger.getLogger(FileUtil.class);
	
	/**
	 * 임시 폴더에 있는 업로드 된 파일을 업로드 폴더로 복사
	 * @param att
	 * @throws IOException
	 * @author jYeory
	 */
	public void copyTmpFileToUploadFolder(Attachment att) throws IOException {
		// 임시 파일 가져오기
		File source = new File(tmpDirectory, att.getFakeName());
		// 업로드 폴더 지정
		File dest = new File(fileUploadDirectory);
		// 없으면 생성
		if(!dest.exists()) dest.mkdirs();	
		// 업로드 폴더에 파일 지정
		dest = new File(dest, att.getFakeName());
		
		// 임시 폴더에 있는 업로드 파일을 업로드 폴더로 복사
		FileCopyUtils.copy(FileUtils.readFileToByteArray(source), dest);
	}
	
	/**
	 * 비동기 파일 업로드 임시 폴더에 저장!
	 * @param f
	 * @return
	 */
	public Attachment copyToTmpFolder(MultipartFile f, String docType) {
		Attachment att = null;
		if(!f.isEmpty()) {
			att = new Attachment();
			att.setAttachDocType(docType);
			att.setFilename(f.getOriginalFilename());
			att.setFileSize(f.getSize());
			String fakeName = UUID.randomUUID().toString();
			att.setFakeName(fakeName);
			att.setContentType(f.getContentType());

			// 폴더에 복사
			copyToFolder(f, fakeName, true);
		}
		return att;
	}
	
	/**
	 * 첨부파일을 서버 물리 저장소에 복사
	 * @param files		업로드한 파일
	 * @param fakename  서버에 저장할 가짜 파일명
	 * @param isTmp		임시파일이면 true, 그 외 false
	 */
	public void copyToFolder(MultipartFile files, String fakename, boolean isTmp) {
		// 저장할 폴더 생성
		File target = new File( isTmp ? tmpDirectory : fileUploadDirectory );
		if(!target.exists())
			target.mkdirs();
		
		// target폴더에 uuid를 이름으로 가진 새로운 파일 생성
		target = new File(target, fakename); 
		
		// 물리저장소에 파일 쓰기
		try {
			FileCopyUtils.copy(files.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public byte[] download(Attachment attFile, HttpServletResponse rep) {
				//3. response에 정보 입력(다운로드)
				String uploadDir = "fileUploadDirectory";
				File file = new File(uploadDir + "/" + attFile.getFakeName());
				// 한글 파일명 인코딩
				String encodingName;
				byte[] b = null;
				try {
					encodingName = java.net.URLEncoder.encode(attFile.getFilename(), "UTF-8");
					
					// 파일 다운로드를 할 수 있는 정보들을 브라우저에 알려주는 역할(정보전달)
					rep.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
					rep.setContentType(attFile.getContentType());
					rep.setHeader("Pragma", "no-cache");
					rep.setHeader("Cache-Control", "no-cache");
					rep.setContentLength((int) attFile.getFileSize());
					// 다운로드
					b = FileUtils.readFileToByteArray(file);
					
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return b;
	}
	
	public void deleteFile(Attachment attFile) {
		logger.debug("fileutil deleteFile - attFile: " + attFile);
		String uploadDir = "fileUploadDirectory";
		File file = new File(uploadDir + "/" + attFile.getFakeName());
//		File file = new File("c:/tmp/upload", attFile.getFakeName());  위와 같은 코드
		if(file.exists()) {
			boolean f = file.delete();
			logger.debug("deleted ? "+f);
		}
	}
	
	
	
}
