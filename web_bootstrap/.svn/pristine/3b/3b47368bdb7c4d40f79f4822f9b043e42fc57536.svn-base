package com.iot.pf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.iot.pf.dto.User;
import com.iot.pf.service.UserService;
import com.iot.pf.util.MailUtil;

@Controller
public class IndexController {

	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(IndexController.class);
	
	@Autowired
	MailUtil mUtil;
	@Autowired
	UserService uService;

	// index page
	@RequestMapping("/index.do")
	public ModelAndView cover() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		return mv;
	}

	// home page
	@RequestMapping("/home.do")
	public ModelAndView home(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String userId = String.valueOf(session.getAttribute("userId"));
		
		if(userId != null) {	// 로그인 한 경우 user정보 같이 넘겨주기
			User u = uService.getUserById(userId);
			mv.addObject("user", u);
		}
		// 로그인 안 한 경우 user 정보 없이 페이지만 열어주기
		mv.setViewName("home");
		return mv;
	}

	// home blank page
	@RequestMapping("/blank.do")
	public ModelAndView blank() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("blank");
		return mv;
	}
	
	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 로그아웃
		session.invalidate();	// session 만료시키는 코드(담겨있던 정보가 다 삭제 됨)
		// 로그아웃 완료 후 로그인 페이지로 보내기
//		RedirectView rv = new RedirectView("/wpf/index.do");
		mv.addObject("msg", "Seeya!");
		mv.setViewName("index");
		return mv;
	}
	
	// 로그인 안한 상태에서 접근하려할 때 에러띄우는 메서드
	@RequestMapping("/loginRequired.do")
	public ModelAndView loginRequired(@RequestParam HashMap<String, String> params) {
		logger.debug("loginRequired params : " + params); 
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", params.get("msg"));
		mv.setViewName("error/error500");
		return mv;
	}
	
	@RequestMapping("/error.do")
	@ResponseBody
	public ModelAndView error(@RequestParam HashMap<String, String> params) {
		logger.debug("/error.do params :" + params);
		ModelAndView mv = new ModelAndView();
		mv.addObject("nextLocation", params.get("nextLocation"));
		mv.addObject("msg", "Login required");
		return mv;
	}

	// 비밀번호 재설정 페이지
	@RequestMapping("/pwReminderPage.do")
	public ModelAndView pwReminderPage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("forgotPw");
		return mv;
	}
	
	// Admin 메뉴 클릭했을 때 admin인지 아닌지 체크
	@RequestMapping("/isAdmin.do")
	@ResponseBody
	public HashMap<String, String> isAdmin(HttpSession session){
		logger.debug("/isAdmin.do params :" + session);
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		if(session.getAttribute("userId") != null) {
			if(session.getAttribute("isAdmin").toString().equals("1")) {
				result.put("code", "admin");
				result.put("msg", "Please enter your Admin Password.");
			}else {
				result.put("code", "notAdmin");
				result.put("msg", "You don't have any rights to see this page.");
			}
		} else {
			result.put("code", "notLogin");
			result.put("msg", "Login First");
		}
		return result;
	}
	
	/**
	 * 관리자가 userList 열람하기 위한 메서드
	 * admin password = admin 비밀번호 일치하는지 체크
	 * @param session
	 * @param params
	 * @return
	 */
	@RequestMapping("/adminChk.do")
	@ResponseBody
	public HashMap<String, String> adminChk(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.debug("/adminChk.do params :" + params);
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		if(session.getAttribute("userId") != null) {
			if(params.get("adminPw").toString().equals("admin")) {
				result.put("msg", "Accepted.");
				result.put("code", "okay");
				return result;
			} else {
				result.put("msg", "Wrong Password");
				result.put("code", "wrong");
				return result;
			}
		}
		result.put("msg", "Login First");
		result.put("code", "no");
		return result;
	}
	
	/**
	 * 홈에서 관리자한테 메세지 보내는 메서드
	 * @param params
	 * @return
	 */
	@RequestMapping("/sendMail.do")
	@ResponseBody
	public HashMap<String, String> sendMail(@RequestParam Map<String, String> params){
		logger.debug("/sendMail.do params :" + params);
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		try {
			mUtil.sendEmail(params);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "error");
			result.put("msg", "Sending Error!");
		}
		result.put("code", "success");
		result.put("msg", "Thank you:)");
		return result;
	}


}
