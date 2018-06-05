package com.iot.pf.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@Controller
public class UserController {

	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(IndexController.class);

	@Autowired
	UserService uService;

	@RequestMapping("/goLogin.do")
	public ModelAndView goLogin(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("goLogin.do - params: "+params);
		ModelAndView mv = new ModelAndView();
		// 로그인 한 후 url로 로그인페이지로 오려고 하는 것 방지하기 위함
		if(session.getAttribute("userId") != null) {
			String url = "/wpf/home.do";
			RedirectView rv = new RedirectView(url);
			mv.addObject("userId", session.getAttribute("userId"));
			mv.setView(rv);
			return mv;
		}
		else {
			mv.setViewName("login");
		}
		mv.addObject("msg", params.get("msg"));
		return mv;
	}

	@RequestMapping("/login.do")
	public ModelAndView login(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("login.do - params: "+params);		// log에 params 추적하기
		System.out.println("login.do - params: "+params);		
		ModelAndView mv = new ModelAndView();

		String userId = params.get("userId");
		String userPw = params.get("userPw");

		try {
			// 비밀번호 일치 유무 체크한다음 다음페이지로 넘어가기(일치하면)
			if(uService.comparePw(userId, userPw)) {
				System.out.println("비밀번호 일치");
				User user = uService.getUserById(userId);

				// session.setAttribute -> site전체에 적용
				session.setAttribute("userId", user.getUserId());	// for 인증
				session.setAttribute("isAdmin", user.getIsAdmin());		// for 권한

				RedirectView rv = new RedirectView("/wpf/home.do");
				mv.setView(rv);
			}
			else {
				System.out.println("비밀번호 불일치");
				mv.addObject("msg", "비밀번호가 일치하지 않습니다.");
				mv.setViewName("login");
			}		
		} catch(Exception e) {
			switch(e.getMessage()) {
			case "NOT_FOUND_USER_ID":
				mv.setViewName("login");
				mv.addObject("msg", "ID가 존재하지 않습니다.");
				break;
			}
		}
		return mv;
	}

	@RequestMapping("/goJoin.do")
	public ModelAndView goJoin() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("join");
		return mv;
	}

	@RequestMapping("/join.do")
	public ModelAndView join(@RequestParam HashMap<String, String> params) {

		logger.debug("join.do - params: "+params);		// log에 params 추적하기
		System.out.println("/join.do - params : " + params);
		ModelAndView mv = new ModelAndView();

		User user = new User();
		user.setUserName(params.get("userName"));
		user.setUserId(params.get("userId"));
		user.setUserPw(params.get("userPw"));
		user.setNickname(params.get("nickname"));
		user.setEmail(params.get("email"));

		try {
			uService.join(user);
		} catch(Exception e) {
			e.printStackTrace();
			mv.setViewName("login");
			mv.addObject("msg", "-Join Error-");
			return mv;
		}
		mv.addObject("result", user);
		mv.setViewName("login");
		mv.addObject("msg", "Successfully Registered!!");
		return mv;
	}

	/**
	 * bootstrap-table-editable이 호출하는 수정 메서드
	 * userList 수정 - by admin
	 *   parameter from : /user/list.do  
	 * @param params
	 * @param session
	 * @return
	 */
	@RequestMapping("/user/edit.do")
	@ResponseBody
	public HashMap<String, Object> edit(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("/user/edit.do - params: "+params);
		// 2018-04-30 14:29 [DEBUG] /user/edit.do - params: {name=userName, value=테스트111, pk=1}
		params.put("seq", params.get("pk"));

		HashMap<String, Object> retMap = new HashMap<String, Object>();
		try {
			uService.editUser(params);
			retMap.put("code", "OK");
			retMap.put("msg", "Successfully edited.");
		} catch (Exception e) {
			e.printStackTrace();
			retMap.put("code", "ERROR");
			retMap.put("msg", "Some Error Ouccured.");
		}
		return retMap;
	}

	// 비동기방식, modelandview가 없으므로 화면을 보여주지 않음, 요청한 곳으로 결과를 돌려보내기만 함
	@RequestMapping("/chkId.do")
	@ResponseBody // 비동기메서드라는 표시
	public int chkId(@RequestParam HashMap<String, String> params) {
		logger.debug("/chkId.do params :" + params);
		String userId = String.valueOf(params.get("userId"));
		return uService.chkDuplicationId(userId);
	}

	@RequestMapping("/user/list.do")
	public ModelAndView list(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("/user/list.do params :" + params);
		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("userId") != null) {	// 로그인 o
			if(session.getAttribute("isAdmin").equals("1")) {	// 권한 o
				mv.setViewName("user/list");
			} else {	// 권한 x
				mv.setViewName("error/error");
				mv.addObject("nextLocation", "/index.do");
				mv.addObject("msg", "권한이 없습니다.");
			}
		} else {	// 로그인 x
			mv.setViewName("error/error");
			mv.addObject("nextLocation", "/goLogin.do");
			mv.addObject("msg", "로그인 먼저 하세요.");
		}
		return mv;
	}

	@RequestMapping("/user/getUserData.do")
	@ResponseBody
	public HashMap<String, Object> getUserData(@RequestParam HashMap<String, String> params) {
		logger.debug("/user/getUserData.do params : " + params);

		int totalCount = uService.totalCount(params);
		params.put("start",  String.valueOf(params.get("offset")));
		params.put("rows",  String.valueOf(params.get("limit")));

		ArrayList<User> result = uService.list(params);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("total", totalCount);
		resultMap.put("rows", result);
		resultMap.put("searchType", params.get("searchType"));
		resultMap.put("searchText", params.get("searchText"));
		return resultMap;
	}

	// userList - admin이 userlist 관리할 때 쓰는 메서드
	@RequestMapping("/user/checkPk.do")
	@ResponseBody
	public long checkPk(@RequestParam HashMap<String, String> params) {
		logger.debug("/user/checkPk.do params : " + params);
		Calendar c = Calendar.getInstance();
		return c.getTimeInMillis();	// timestmap값을 long으로 얻음
	}

	// 회원탈퇴 메서드
	@RequestMapping("/withdraw.do")
	@ResponseBody
	public HashMap<String, String> withdraw(HttpSession session, @RequestParam HashMap<String, String> params) throws Exception {
		logger.debug("/withdraw.do - params: "+params);

		HashMap<String, String> result = new HashMap<String, String>();
		String userId = String.valueOf(session.getAttribute("userId"));
		String password = params.get("password");

		if(uService.comparePw(userId, password)) {
			try {
				uService.delUser(userId);
				session.invalidate();
			} catch (Exception e) {
				e.printStackTrace();
				result.put("code", "error");
			}
			result.put("code", "delete");
		} else {
			result.put("code", "wrongPw");
		}
		return result;
	}

	/**
	 * 개인 프로필 수정 전 pw체크
	 * @param params
	 */
	@RequestMapping("/user/pwCheck.do")
	@ResponseBody
	public HashMap<String, String> pwCheck(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.debug("/user/pwCheck.do - params: "+params);
		HashMap<String, String> result = new HashMap<String, String>();
		String userId = String.valueOf(session.getAttribute("userId"));
		String userPw = String.valueOf(params.get("password"));
		
		try {
			if(uService.comparePw(userId, userPw)) {
				result.put("code", "correct");
			} else {
				result.put("code", "incorrect");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "error");
		}
		return result;
	}
	
	/**
	 * 프로필 수정하기 누르면 수정페이지 나오는 메서드
	 * @param params
	 * @param session
	 * @return
	 */
	@RequestMapping("/goEditProfile.do")
	public ModelAndView profile(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("userId") != null) {
			User u = uService.getUserById(String.valueOf(session.getAttribute("userId")));
			mv.addObject("user", u);
			mv.setViewName("profile/profile");
		} else {
			RedirectView rv = new RedirectView("/wpf/goLogin.do");
			mv.addObject("msg", "Login First!");
			mv.setView(rv);
		}
		return mv;
	}
	
	@RequestMapping("/editProfile.do")
	@ResponseBody
	public HashMap<String, String> editProfile(HttpSession session, @RequestParam HashMap<String, String> params){
		logger.debug("/editProfile.do params : "+params);
		HashMap<String, String> result = new HashMap<String, String>();
		String userId = String.valueOf(session.getAttribute("userId"));
		
		User u = uService.getUserById(userId);
		u.setEmail(params.get("email"));
		u.setNickname(params.get("nickname"));
		u.setUserPw(params.get("userPw"));
		
		try {
			uService.updateProfile(u);
			result.put("code", "success");
			result.put("msg", "Your Profile has been succesfully updated!");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "fail");
			result.put("msg", "Error: Updating profile.");
		}
		return result;
	}


}
