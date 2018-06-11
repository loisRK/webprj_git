package com.iot.pf.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.iot.pf.dto.Album;
import com.iot.pf.service.AlbumService;
import com.iot.pf.util.AlbumUtil;

@Controller
public class AlbumController {

	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(AlbumController.class);

	@Autowired
	AlbumUtil aUtil;
	@Autowired
	AlbumService aService;
	@Value("${photo.upload.directory}")
	private String photoUploadDirectory;
	// 썸네일 다이렉토리
	@Value("${thumb.upload.directory}")
	private String thumbUploadDirectory;


	@RequestMapping("/showAlbum.do")
	public ModelAndView showAlbum(@RequestParam HashMap<String, String> params) {
		logger.debug("/showAlbum.do - params: " + params);
		ModelAndView mv = new ModelAndView();

		mv.setViewName("bbs/album/view");
		return mv;
	}

	@RequestMapping("/albumList.do")
	@ResponseBody
	public ArrayList<Album> albumList(@RequestParam HashMap<String, String> params) {
		logger.debug("/albumList.do - params: " + params);

		ArrayList<Album> pList = aService.getPhotos();

		return pList;
	}

	// Album에서 post 버튼 누르면 사진 업로드 창 열리게 함
	@RequestMapping("/goPost.do")
	@ResponseBody
	public HashMap<String, String> goPost(HttpSession session) {

		HashMap<String, String> result = new HashMap<String, String>();
		if(session.getAttribute("userId") != null) {
			result.put("code", "login");
		} else {
			result.put("code", "nLogin");
		}
		return result;
	}

	// post버튼 누른 후 dropzone modal 나오게 하는 메서드
	@RequestMapping("/showPostingArea.do")
	@ResponseBody
	public ModelAndView showPostingArea() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("bbs/album/post");
		return mv;
	}


	// 비동기 앨범에 업로드
	@RequestMapping("/photoUpload.do")
	@ResponseBody
	public List<Album> photoUpload(HttpSession session, MultipartHttpServletRequest mReq) throws IOException{
		logger.debug("/photoUpload.do - params: " + mReq);
		Map<String, MultipartFile> fileMap = mReq.getFileMap();
		List<Album> attaches = new ArrayList<Album>();
		for(MultipartFile mf : fileMap.values()) {
			attaches.add(aUtil.copyToTmpFolder(mf));
		}

		return attaches;
	}	

	// 앨범게시판에 사진 등록하기
	@RequestMapping("/postPhoto.do")
	@ResponseBody
	public HashMap<String, String> postPhoto(HttpSession session, @RequestBody(required=false) HashMap<String, Object> photos){
		logger.debug("/postPhoto.do - params: " + photos);

		String userId = (String) session.getAttribute("userId");

		// 이미 업로드 된 첨부파일에 대한 정보
		List<LinkedHashMap<String, String>> fileMap = (List<LinkedHashMap<String, String>>) photos.get("album");

		List<Album> files = null;
		Album a = null;
		// 이미 업로드 된 첨부파일에 대한 정보는 LinkedHashMap으로 받아 오기에 Attachment로 변경해주어야 한다.
		if(fileMap.size() > 0){
			files = new ArrayList<Album>();
			for(LinkedHashMap<String, String> m : fileMap) {
				a = new Album();
				a.setUserId(userId);
				a.setpFileName(m.get("pFileName"));
				a.setpFakeName(m.get("pFakeName"));
				a.setpFileSize(Long.parseLong(String.valueOf(m.get("pFileSize"))));
				a.setpType(m.get("pType"));
				a.setThName(m.get("pFakeName"));

				files.add(a);
			}
		}

		HashMap<String, String> result = new HashMap<String, String>();
		if(session.getAttribute("userId") != null) {

			try {
				// 앨범에 사진 등록
				aService.addAlbum(files);
			} catch(Exception e) {
				e.printStackTrace();
				result.put("code", "error");
				result.put("msg", "Error: Uploading Photos.");
			}

			result.put("msg", "Successfully Uploaded.");
			result.put("code", "ok");
			return result;
		} 
		else {
			// 로그인 안했을때 코드
			result.put("code", "no");
			result.put("msg", "Login First.");
		}
		return result;
	}

	/**
	 * 이미지를 웹에 노출 시칸다.
	 * @param response
	 * @param id
	 */
	// 가변 .do(jsp에서 보내주는 id값을 연결
	@RequestMapping("/getFullPic.do")
	@ResponseBody
	public void picture(HttpServletResponse response, @RequestParam HashMap<String, String> params) {
		logger.debug("/getFullPic.do - params: " + params);

		Album a = aService.getOnePhoto(Integer.parseInt(params.get("id")));
		File imageFile = null;
		// 이미지 파일이 저장되어 있는 경로에 있는 id(=pFakeName)을 이미지파일변수에 저장
		imageFile = new File(photoUploadDirectory+ "/" + a.getpFakeName());

		response.setContentType(a.getpType());
		response.setContentLength((int) a.getpFileSize());

		try {
			InputStream is = new FileInputStream(imageFile);
			IOUtils.copy(is,  response.getOutputStream());
			response.flushBuffer();
			is.close();

		} catch(IOException e) {
			logger.error("Could not show picture " + params.get("id"), e);
		}

	}

	// 가변 .do(jsp에서 보내주는 id값을 연결
//	@RequestMapping("/thumn/{id}.do")
//	@ResponseBody
//	public void getThumbnail(HttpServletResponse response, @PathVariable String id) {
//		logger.debug("/thumb/id.do - params: " + id);
//
//		Album a = aService.getOnePhoto(Integer.parseInt(id));
//		File imageFile = null;
//		// 이미지 파일이 저장되어 있는 경로에 있는 id(=pFakeName)을 이미지파일변수에 저장
//		imageFile = new File(thumbUploadDirectory, a.getThName());
//
//		response.setContentType(a.getpType());
//		response.setContentLength((int) a.getpFileSize());
//
//		try {
//			InputStream is = new FileInputStream(imageFile);
//			IOUtils.copy(is,  response.getOutputStream());
//			response.flushBuffer();
//			is.close();
//
//		} catch(IOException e) {
//			logger.error("Could not show picture " + id, e);
//		}
//
//	}
}
