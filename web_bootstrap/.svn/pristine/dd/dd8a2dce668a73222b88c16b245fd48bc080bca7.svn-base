package com.iot.pf.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)		// spring으로 test하겠다는 것
@ContextConfiguration(locations = {		// spring 설정파일 지정, locations = {개별 위치지정}
		"file:src/main/resources-common/applicationContext-datasource.xml",
		"file:src/main/resources-common/applicationContext-beans.xml"
})

public class UserTest {

	@Autowired
	UserService service;

	@Test
	public void join() {
		User u = new User();
		u.setUserId("testRKK");
		u.setUserPw("20180424");
		u.setUserName("김륜경");
		u.setNickname("IOT");
		u.setEmail("loiskim150@gmail.com");
		u.setIsAdmin("1");

		// exception은 객체지향적이지 않음
		try {
			service.join(u);
		} catch(AnomalyException ae) {
			ae.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
