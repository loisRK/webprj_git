package com.iot.pf.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.codec.net.URLCodec;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iot.pf.service.UserService;
import com.iot.pf.util.AES256Util;
import com.iot.pf.util.MailUtil;

@Controller
public class MailController {

	@Autowired
	UserService uService;
	@Autowired
	MailUtil mUtil;
	@Autowired
	AES256Util aes;

	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(IndexController.class);

	@RequestMapping("/checkEmail.do")
	@ResponseBody
	public HashMap<String, String> checkEmail(@RequestParam Map<String, String> params){
		logger.debug("loginRequired params : " + params); 
		HashMap<String, String> result = new HashMap<String, String>();

		String email = params.get("email");
		String userId = params.get("userId");

		try {
			if(uService.compareEmail(email, userId)) {	// userId존재유무와 email일치여부 확인 -> true
				try {
					InputStream is = this.getClass().getResourceAsStream("/html/ConfirmMail.html"); 
					BufferedReader br = new BufferedReader(new InputStreamReader(is)); //eq. scanner
					StringBuffer sb = new StringBuffer();

					//email encoding
					URLCodec codec = new URLCodec();
					String encEmail = codec.encode(aes.aesEncode(""+email));
					String encUserId = codec.encode(aes.aesEncode(""+userId));

					String line;
					while ((line = br.readLine()) != null) {
						if (line.indexOf("url") != -1) {
							line = line.replace("url",
									"http://localhost:8080/wpf/sendConfirm.do?email=" + encEmail+"&userId=" + encUserId);
						}
						//			     line = line.replace("url",
						//			     "http://ec2-13-125-225-98.ap-northeast-2.compute.amazonaws.com:8080/wpf/sendConfirm.do?email="
						//			     + encEmail+"&userId=" + encUserId);
						//			     }
						//    
						sb.append(line);
						//			     System.out.println(line);
					}
					br.close();
					String html = sb.toString();

					params.put("html", html);

					mUtil.sendPwEmail(params);
					
					result.put("code", "ok");
					result.put("msg", "Please check your email");
					
				} catch (Exception e) {
					e.printStackTrace();
					result.put("code", "no");
					result.put("msg", "Sending Message Error");		// confirm 이메일 발신 에러
					return result;
				}
			} else {
				result.put("code", "no");
				result.put("msg", "This Id or E-mail does not exist.");		// email불일치거나 Id불일치
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "error");
			result.put("msg", "Error: Check Id or Email.");	// Exception error
			return result;
		}
		return result;		
	}

	/**
	 * page, inside of mail, with confirm button
	 * @return
	 */
	@RequestMapping("/sendConfirm.do")
	public ModelAndView checkEmail(@RequestParam HashMap<String, String> params){
		logger.debug("sendConfirm.do params : " + params );
		ModelAndView mv = new ModelAndView();
		mv.addObject("userId", params.get("userId"));
		mv.addObject("email", params.get("email"));
		mv.setViewName("resetPw");
		return mv;
	}
	
	/**
	 * show password after click confirm
	 * @return
	 */
	@RequestMapping("/resetPassword.do")
	@ResponseBody
	public HashMap<String, String> resetPassword(@RequestParam HashMap<String, String> params) {
		logger.debug("resetPassword.do params : " + params );
		HashMap<String, String> result = new HashMap<String, String>();
		
		byte[] b = params.get("userId").getBytes();
		String t = new String(b);
		System.out.println("t1 ---------- " + t);
		//change pw
		try {
			//email decoding
			URLCodec codec = new URLCodec();
			System.out.println("t2 ---------- " + codec.decode(t));
			String decUserId = aes.aesDecode(codec.decode(t));
			params.put("userId", decUserId);
			uService.resetPw(params);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "no");
			result.put("msg", "Changing password Error");
			return result;
		}
		result.put("code", "ok");
		result.put("msg", "Your password has been changed.");
		return result;
	}
	
}
