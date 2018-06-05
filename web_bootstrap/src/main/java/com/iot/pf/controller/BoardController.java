package com.iot.pf.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.Comment;
import com.iot.pf.dto.Freeboard;
import com.iot.pf.dto.User;
import com.iot.pf.service.AttachmentService;
import com.iot.pf.service.CommentService;
import com.iot.pf.service.FreeboardService;
import com.iot.pf.service.UserService;
import com.iot.pf.util.FileUtil;

@Controller
public class BoardController {

	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(BoardController.class);

	@Autowired
	FreeboardService bService;
	@Autowired
	UserService uService;
	@Autowired
	AttachmentService aService;
	@Autowired
	CommentService cService;
	@Autowired
	FileUtil fUtil;


	/**
	 * 수정 화면에서 첨부파일 삭제하기 위한 메서드
	 * @param params
	 * @return
	 * @throws IOException
	 * @author jYeory
	 */
	@RequestMapping("/bbs/free/delAttachFile.do")
	@ResponseBody
	public HashMap<String, String> delAttachFile(@RequestParam HashMap<String, String> params) throws IOException{
		logger.debug("/bbs/free/delAttachFile.do - params: " + params);
		int attachSeq = Integer.parseInt(params.get("attachSeq"));
		HashMap<String, String> result = new HashMap<String, String>();
		try {
			bService.delAttachedFile(attachSeq);
			result.put("code", "ok");
			result.put("msg", "첨부파일을 삭제하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "error");
			result.put("msg", "첨부파일을 삭제하는 도중 오류가 발생하였습니다.");
		}
		return result;
	}

	/**
	 * 수정 화면에서 첨부파일 정보를 가져오기 위한 메서드
	 * @param params
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/bbs/free/getAttachedFiles.do")
	@ResponseBody
	public List<Attachment> getAttachedFiles(@RequestParam HashMap<String, String> params) throws IOException{
		String docType = params.get("docType");
		int seq = Integer.parseInt(params.get("postNum"));
		return aService.getAttachment(docType, seq);
	}

	@RequestMapping("/goUpdate.do")
	public ModelAndView goUpdate(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("goUpdate.do - params: "+params);
		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("userId") != null) {	// 로그인 했을 때			

			int postNum = Integer.parseInt(params.get("postNum"));

			Freeboard board = bService.findByNum(postNum);

			if(board.getHasFile().equals("1")) {
				// 첨부파일 데이터 가져오기
				ArrayList<Attachment> aList = aService.getAttachment("free", postNum);
				// 가져온 첨부파일 데이터 JSP에서 쓰기 위해 넣어주기
				mv.addObject("attachFile", aList);
			}

			mv.addObject("currentPageNo", params.get("currentPageNo"));
			mv.addObject("board", board);
			mv.setViewName("bbs/free/update");

		} else {	// 로그인 안했을 때
			mv.setViewName("error/error");
			mv.addObject("nextLocation", "/goLogin.do");
			mv.addObject("msg", "로그인 먼저 하세요.");
		}
		return mv;
	}

	/**
	 *  첨부파일을 포함한 글 수정(ver bootstrap)
	 *  비동기 방식으로 첨부파일을 먼저 업로드 하기 때문에 jsp에서 컨트롤러로 파라미터를 보낼 때 json으로 보낸다.
	 *  때문에 RequestBody를 선언해야 파라미터를 받아올 수 있다. 
	 */
	@RequestMapping("/bs/update.do")
	@ResponseBody
	public HashMap<String, String> bsUpdate(HttpSession session, @RequestBody(required=false) HashMap<String, Object> attaches) {
		logger.debug("/bs/update.do attaches : "+attaches);
		int postNum = Integer.parseInt(String.valueOf(attaches.get("postNum")));
		// 글 제목
		String title = String.valueOf(attaches.get("title"));
		// 글 내용
		String content = String.valueOf(attaches.get("content"));
		// 이미 업로드 된 첨부파일에 대한 정보
		List<LinkedHashMap<String, String>> fileMap = (List<LinkedHashMap<String, String>>) attaches.get("attaches");

		List<Attachment> files = null;
		Attachment att = null;
		// 이미 업로드 된 첨부파일에 대한 정보는 LinkedHashMap으로 받아 오기에 Attachment로 변경해주어야 한다.
		if(fileMap.size() > 0){
			files = new ArrayList<Attachment>();
			for(LinkedHashMap<String, String> m : fileMap) {
				att = new Attachment();
				att.setAttachSeq(Integer.parseInt(String.valueOf(m.get("attachSeq"))));
				att.setAttachDocType(m.get("attachDocType"));
				att.setAttachDocSeq(Integer.parseInt(String.valueOf(m.get("attachDocSeq"))));
				att.setFilename(m.get("filename"));
				att.setFakeName(m.get("fakeName"));
				att.setContentType(m.get("contentType"));
				att.setFileSize(Long.parseLong(String.valueOf(m.get("fileSize"))));

				files.add(att);
			}
		}

		Freeboard board = bService.findByNum(postNum);
		HashMap<String, String> result = new HashMap<String, String>();
		if(session.getAttribute("userId") != null) {

			board.setTitle(title);
			board.setContents(content);
			board.setHasFile((files == null || files.size() == 0)? "0" :"1");

			try {
				bService.updateWithFileInfo(board, files);
			}catch(Exception e) {
				e.printStackTrace();
				result.put("code", "error");
				result.put("msg", "글을 수정하는 중 오류가 발생했습니다.");
			}
			result.put("code", "ok");
			result.put("msg", "수정되었습니다.");

		} else {
			// 로그인 하라고 안내...
			result.put("code", "no");
			result.put("msg", "로그인 먼저 하세요.");
		}
		return result;
	}

	@RequestMapping("/fileUpload.do")
	@ResponseBody
	public List<Attachment> fileUpload(@RequestParam HashMap<String, String> params, HttpSession session, MultipartHttpServletRequest mReq) throws IOException{
		Map<String, MultipartFile> fileMap = mReq.getFileMap();
		List<Attachment> attaches = new ArrayList<Attachment>();
		for(MultipartFile mf : fileMap.values()) {
			attaches.add(fUtil.copyToTmpFolder(mf, params.get("docType")));
		}

		return attaches;
	}

	/**
	 *  첨부파일을 포함한 글쓰기 (ver bootstrap)
	 *  비동기 방식으로 첨부파일을 먼저 업로드 하기 때문에 jsp에서 컨트롤러로 파라미터를 보낼 때 json으로 보낸다.
	 *  때문에 RequestBody를 선언해야 파라미터를 받아올 수 있다. 
	 */
	@RequestMapping("/bs/write.do")
	@ResponseBody
	public HashMap<String, String> bsWrite(HttpSession session, @RequestBody(required=false) HashMap<String, Object> attaches) {
		logger.debug("/bs/write.do attaches : "+attaches);
		// 글 제목
		String title = String.valueOf(attaches.get("title"));
		// 글 내용
		String content = String.valueOf(attaches.get("content"));
		// 이미 업로드 된 첨부파일에 대한 정보
		List<LinkedHashMap<String, String>> fileMap = (List<LinkedHashMap<String, String>>) attaches.get("attaches");

		List<Attachment> files = null;
		Attachment att = null;
		// 이미 업로드 된 첨부파일에 대한 정보는 LinkedHashMap으로 받아 오기에 Attachment로 변경해주어야 한다.
		if(fileMap.size() > 0){
			files = new ArrayList<Attachment>();
			for(LinkedHashMap<String, String> m : fileMap) {
				att = new Attachment();
				att.setAttachDocType(m.get("attachDocType"));
				att.setFilename(m.get("filename"));
				att.setFakeName(m.get("fakeName"));
				att.setContentType(m.get("contentType"));
				att.setFileSize(Long.parseLong(String.valueOf(m.get("fileSize"))));

				files.add(att);
			}
		}

		HashMap<String, String> result = new HashMap<String, String>();
		Freeboard board = new Freeboard();
		if(session.getAttribute("userId") != null) {
			board.setWriter(session.getAttribute("userId").toString());
			board.setUserId(session.getAttribute("userId").toString());
			board.setTitle(title);
			board.setHasFile((files == null || files.size() == 0) ? "0" : "1");
			board.setContents(content);

			try {
				// 게시글 작성(파일 업로드와 함께)
				bService.writeWithFileInfo(board, files);
			} catch(Exception e) {
				e.printStackTrace();
				result.put("code", "error");
				result.put("msg", "Error: Submit failed. ");
			}
			result.put("msg", "Successfully Submitted.");
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

	// 글쓰기 페이지 여는 메서드
	@RequestMapping("/writePage.do")
	public ModelAndView writePage(@RequestParam HashMap<String, String> params, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(session.getAttribute("userId") != null) {
			mv.addObject("currentPageNo", params.get("currentPageNo"));
			mv.setViewName("bbs/free/write");
		} else {
			mv.setViewName("error/error");
			mv.addObject("nextLocation", "/goLogin.do");
			mv.addObject("msg", "로그인 먼저 하세요.");
		}
		return mv;
	}

	@RequestMapping("/bbs/free/list.do")
	public ModelAndView list(@RequestParam HashMap<String, String> params) {
		logger.debug("/bbs/free/list.do - params: "+params);
		int totalList = bService.count(params);
		int pageSize = 10;
		int currentPageNo = 1;

		if(params.containsKey("currentPageNo")) 
			currentPageNo = Integer.parseInt(params.get("currentPageNo"));

		// 총 페이지 수 초기화
		int totalPage = 0;
		totalPage = (totalList % pageSize != 0)? (totalList / pageSize + 1) : (totalList / pageSize) ;

		int startArticleNo = (currentPageNo - 1) * pageSize;
		int pageBlockSize = 10;
		int pageBlockStart = (currentPageNo - 1) / pageBlockSize * pageBlockSize +1;
		int pageBlockEnd = (currentPageNo - 1) / pageBlockSize * pageBlockSize + pageBlockSize;
		pageBlockEnd = (pageBlockEnd >= totalPage)? totalPage : pageBlockEnd;

		HashMap<String, Object> p = new HashMap<String, Object>();
		p.put("startArticleNo", startArticleNo);
		p.put("pageSize", pageSize);
		p.put("searchType", params.get("searchType"));
		p.put("searchText", params.get("searchText"));
		ArrayList<Freeboard> result = bService.paging(p);

		ModelAndView mv = new ModelAndView();
		mv.addObject("result", result);
		mv.addObject("totalPage", totalPage);
		mv.addObject("currentPageNo", currentPageNo);
		mv.addObject("totalList", totalList);
		mv.addObject("pageBlockSize", pageBlockSize);
		mv.addObject("pageBlockStart", pageBlockStart);
		mv.addObject("pageBlockEnd", pageBlockEnd);
		mv.addObject("searchType", params.get("searchType"));
		mv.addObject("searchText", params.get("searchText"));
		mv.setViewName("bbs/free/list");
		return mv;
	}

	@RequestMapping("/read.do")
	public ModelAndView read(@RequestParam HashMap<String, String> params) {
		logger.debug("read.do - params: "+params);
		ModelAndView mv = new ModelAndView();

		int postNum = Integer.parseInt(params.get("postNum"));
		int edit = 0;	// 댓글 편집포맷 변경 신호

		if(params.containsKey("edit"))
			edit = Integer.parseInt(params.get("edit"));

		// 특정 게시글
		Freeboard board = null;
		String email = null;
		int totalAtt = 0;
		try {
			// 게시글 1건 조회 & 조회수 증가
			board = bService.readArticle(postNum);
			// 첨부파일 있는지 검사
			if(board.getHasFile().equals("1")) {
				// 첨부파일 데이터 가져오기
				ArrayList<Attachment> aList = aService.getAttachment("free", postNum);
				totalAtt = aService.countAtt(postNum);	// 첨부파일이 존재하면 몇갠지 세주기
				// 가져온 첨부파일 데이터 JSP에서 쓰기 위해 넣어주기
				mv.addObject("attachFile", aList);
			}
			// board.getUserId로 이메일 정보 넘겨주기
			User u = uService.getUserById(board.getUserId());
			email = u.getEmail();

		} catch(Exception e) {
			e.printStackTrace();
		}

		// 댓글 paging
		int totalComment = cService.count(postNum);
		int commentSize = 10;
		int currentComPage = 1;

		if(params.containsKey("currentComPage"))
			currentComPage = Integer.parseInt(params.get("currentComPage"));

		// 총 페이지 수 초기화
		int totalPage = 0;
		totalPage = (totalComment % commentSize != 0)? (totalComment / commentSize + 1) : (totalComment / commentSize);
		// 댓글 페이지 쪽 수 매기기
		int startArticleNo = (currentComPage - 1) * commentSize;
		int pageBlockSize = 10;
		int pageBlockStart = (currentComPage - 1) / pageBlockSize * pageBlockSize +1;
		int pageBlockEnd = (currentComPage - 1) / pageBlockSize * pageBlockSize + pageBlockSize;
		pageBlockEnd = (pageBlockEnd >= totalPage)? totalPage : pageBlockEnd;

		// 댓글 리스트 보내기
		HashMap<String, Object> p = new HashMap<String, Object>();
		p.put("startArticleNo", startArticleNo);
		p.put("commentSize", commentSize);
		p.put("postNum", postNum);
		ArrayList<Comment> comments = cService.commentPaging(p);

		mv.addObject("comments", comments);
		mv.addObject("totalPage", totalPage);
		mv.addObject("currentComPage", currentComPage);	// 댓글 페이지 넘버
		mv.addObject("totalComment", totalComment);
		mv.addObject("pageBlockSize", pageBlockSize);
		mv.addObject("pageBlockStart", pageBlockStart);
		mv.addObject("pageBlockEnd", pageBlockEnd);
		// 댓글 paging 정보

		mv.addObject("board", board);	// 게시글 정보
		mv.addObject("currentPageNo", params.get("currentPageNo")); // 게시글 페이지 넘버
		mv.addObject("email", email);
		mv.addObject("postNum", postNum);
		mv.addObject("comNum", params.get("comNum"));
		mv.addObject("edit", edit);	// 편집버튼 누르면 1로 바뀜, 기본값 0
		mv.addObject("totalAttach", totalAtt);
		mv.addObject("msg", params.get("msg"));
		mv.setViewName("bbs/free/read");
		return mv;
	}

	@RequestMapping("/delete.do")
	public ModelAndView delete(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("delete.do - params: "+params);
		System.out.println("/delete.do - params : " + params);
		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("userId") != null) {

			int postNum = Integer.parseInt(params.get("postNum"));
			String userId = String.valueOf(session.getAttribute("userId"));
			try{
				// 글번호로 연결된 첨부파일 가져오기
				ArrayList<Attachment> aList = aService.getAttachment("free", postNum);
				bService.delete(postNum, userId, aList);

			} catch(Exception e) {

				String url = "/wpf/read.do?postNum="+postNum
						+ "&currentPageNo="+params.get("currentPageNo");
				RedirectView rv = new RedirectView(url);
				String msg = "";

				switch(e.getMessage()) {	// if-else로도 가능
				case "DELETE ERROR": // 삭제 이상
					msg = "삭제 중 오류가 발생했습니다.";
					break;
				case "NOT_EQ_PASSWORD": //비밀번호 불일치
					msg = "비밀번호가 일치하지 않습니다.";
					break;
				}
				mv.addObject("msg", msg);
				mv.setView(rv);
				return mv;
			}

			RedirectView rv = new RedirectView("/wpf/bbs/free/list.do");
			mv.setView(rv);
			return mv;
		} else {
			mv.setViewName("error/error");
			mv.addObject("nextLocation", "/goLogin.do");
			mv.addObject("msg", "로그인 먼저 하세요.");
			return mv;
		}
	}

	@RequestMapping("/bbs/free/fileDownload.do")
	@ResponseBody
	public byte[] fileDownload(@RequestParam HashMap<String, String> params, HttpServletResponse rep) {
		logger.debug("/bbs/free/fileDownload.do - params: " + params);
		//1. 첨부파일 seq 꺼내기
		int seq = Integer.parseInt(params.get("attachSeq"));
		//2. seq에 해당하는 첨부파일 1건 가져오기
		Attachment attFile = aService.getOneAttach(seq);
		//3. response
		byte[] b = fUtil.download(attFile, rep);

		return b;
	}


}
