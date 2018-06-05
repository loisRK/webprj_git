package com.iot.pf.util;

import java.util.Map;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;


@Component
public class MailUtil {
	// log에 params 입력되는지 추적하기위해 추가
	private Logger logger = Logger.getLogger(MailUtil.class);

	@Autowired
	protected JavaMailSender  mailSender;
	@Autowired
	AES256Util aes;

	// mailPwCheck 메서드
	public void sendPwEmail(Map<String, String> params) throws Exception {
		MimeMessage msg = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true);
		// msg.setFrom(params.get("youremail"));
		// msg.setRecipient(RecipientType.TO, new InternetAddress(params.get("email")));
		// msg.setSubject("Temporary Password From Minjae's Portfolio Website");
		// msg.setContent(params.get("html"), "text/html; charset=utf-8");
		helper.setFrom("rkim9034@gmail.com");
		helper.setTo(new InternetAddress(params.get("email")));
		helper.setSubject("To Reset Password (RK's Portfolio Website)");
		helper.setText(params.get("html"), true);
		// helper.setText("<html><body><a href='http://localhost:8080/PortwithDesign/sendConfirm.do' target='_blank'>click</a></body></html>", true);
		logger.debug("sendPwEmail \n "+params.get("html"));
		/*
		        msg.setFrom(email.getSender());
		        msg.setSubject(email.getSubject());
		        msg.setText(email.getContent());
		        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
		 */

		mailSender.send(msg);
	}

	// home화면에서 message보내는 메서드
	public void sendEmail(Map<String, String> params) throws Exception {
		logger.debug("sendEmail() params :" + params);

		MimeMessage msg = mailSender.createMimeMessage();
//		MimeMessageHelper helper = new MimeMessageHelper(msg, true);

		//		msg.setFrom(new InternetAddress("jyeory@gmail.com", params.get("sender")));	// 보내는 사람 이메일주소, 구글에서 적용안됨
		msg.setRecipient(RecipientType.TO , new InternetAddress("rkim9034@gmail.com"));	// 내 이메일 주소(받는사람이메일주소)
		msg.setSubject("Message From My Portfolio - From. " + params.get("sender"));	// 보내는 사람 이름
		msg.setText("Subject : " + params.get("subject") 
		+ "\n Sender Email : " + params.get("sEmail")
		+ "\n Message : " + params.get("message"));	// 보내는 메세지 종류, 보내는 사람 이메일, 메세지 내용

		/*
		helper.setFrom(params.get("sEmail"));	// 보내는 사람 이메일주소
		helper.setTo("rkim9034@gmail.com");		// 내 이메일 주소
		helper.setSubject(params.get("sender"));	// 보내는 사람 이름
		helper.setText(params.get("subject") + params.get("message"));	// 보내는 메세지 종류와 내용

		File tempFile = new File(params.get("attachFilePath"));
		FileSystemResource file = new FileSystemResource(tempFile);
		System.out.println("-------------------------------------------------------------------");
		System.out.println("attach file path : "+tempFile.getAbsolutePath());
		System.out.println("attach file name : "+tempFile.getName());
		System.out.println("attach file size : "+tempFile.length());
		System.out.println("-------------------------------------------------------------------");
		helper.addAttachment(file.getFilename(), file);
		 */

		mailSender.send(msg); 
	}

}
