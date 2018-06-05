package com.iot.pf.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iot.pf.dto.Comment;
import com.iot.pf.dto.Freeboard;
import com.iot.pf.service.CommentService;
import com.iot.pf.service.FreeboardService;

@Controller
public class CommentController {

	private Logger logger = Logger.getLogger(CommentController.class);

	@Autowired
	CommentService cService;
	@Autowired
	FreeboardService bService;

	// comment 등록 새 방식
	@RequestMapping("/bs/comment.do")
	@ResponseBody
	public HashMap<String, String> brComment(HttpSession session, @RequestBody(required=false) HashMap<String, Object> comments){
		logger.debug("/bs/comment.do - params: "+comments);
		HashMap<String, String> result = new HashMap<String, String>();

		if(session.getAttribute("userId") != null) {
			String comment = String.valueOf(comments.get("comment"));
			int postNum = Integer.valueOf((String) comments.get("postNum"));

			Comment c = new Comment();
			c.setComContents(comment);
			c.setComDocNum(postNum);
			c.setComDocType("free");
			c.setUserId(session.getAttribute("userId").toString());
			

			try {
				cService.insert(c);
				
				// 댓글 갯수 게시글 정보에 추가해서 리스트에서 볼 수 있게 하기
				HashMap<String, Object> h = new HashMap<String, Object>();
				h.put("totalCom", cService.count(postNum));
				h.put("postNum", postNum);
				bService.updateComment(h);
				
			} catch(Exception e) {
				e.printStackTrace();
				result.put("code", "error");
				result.put("msg", "Error: Cannot register your comment.");
			}
			result.put("msg", "Successfully registered!");
			result.put("code", "ok");
		} else {
			result.put("msg", "Session Expired. Login Again!");
			result.put("code", "no");
		}
		return result;
	}

	// 댓글 삭제
	@RequestMapping("/bs/comDelete.do")
	@ResponseBody
	public int comDelete(@RequestParam HashMap<String, String> params) {
		logger.debug("/bs/comDelete.do - params: "+params);

		int comNum = Integer.parseInt(params.get("comNum"));
		int postNum = Integer.parseInt(params.get("postNum"));

		try {
			cService.delete(comNum);
			
			// 댓글 삭제 후 댓글 갯수 갱신
			HashMap<String, Object> h = new HashMap<String, Object>();
			h.put("totalCom", cService.count(postNum));
			h.put("postNum", postNum);
			bService.updateComment(h);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}

	// 댓글 수정
	@RequestMapping("/bs/comEdit.do")
	@ResponseBody
	public void comEdit(@RequestParam HashMap<String, String> params) {
		logger.debug("/bs/comEdit.do - params: "+params);

		int comNum = Integer.parseInt(params.get("comNum"));
		String comContents = String.valueOf(params.get("comment"));

		Comment c = cService.getOneCom(comNum);
		c.setComContents(comContents);

		try {
			cService.updateCom(c);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
