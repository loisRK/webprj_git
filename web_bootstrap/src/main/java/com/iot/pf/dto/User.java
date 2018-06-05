package com.iot.pf.dto;

import org.apache.ibatis.type.Alias;

@Alias("User")
public class User {
	private int seq;
	private String userId;
	private String userName;
	private String userPw;
	private String nickname;
	private String email;
	private String isAdmin;
	private String createDate;
	private String updateDate;

	public User() {};

	public User(int seq,
			String userId,
			String userName,
			String userPw,
			String nickname,
			String email,
			String isAdmin,
			String createDate,
			String updateDate) {
		this.seq = seq;
		this.userId = userId;
		this.userName = userName;
		this.userPw = userPw;
		this.nickname = nickname;
		this.email = email;
		this.isAdmin = isAdmin;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "User [seq=" + seq + ", userId=" + userId + ", userName=" + userName + ", userPw=" + userPw
				+ ", nickname=" + nickname + ", email=" + email + ", isAdmin=" + isAdmin + ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}

}
