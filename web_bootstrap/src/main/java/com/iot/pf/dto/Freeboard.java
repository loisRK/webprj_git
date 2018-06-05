package com.iot.pf.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("Freeboard")
public class Freeboard {
	private int postNum;
	private String writer;
	private String userId;
	private String title;
	private String contents;
	private int viewCnt;
	private String hasFile;
	private int hasComment;
	private Timestamp postDate;
	private Timestamp updateDate;
	private String postType;

	public Freeboard() {}

	public Freeboard(int postNum, 
			String writer, 
			String userId, 
			String title, 
			String contents, 
			int viewCnt, 
			String hasFile,
			int hasComment,
			Timestamp postDate,
			Timestamp updateDate,
			String postType) {
		this.postNum = postNum;
		this.writer = writer;
		this.userId = userId;
		this.title = title;
		this.contents = contents;
		this.viewCnt = viewCnt;
		this.hasFile = hasFile;
		this.hasComment = hasComment;
		this.postDate = postDate;
		this.updateDate = updateDate;
		this.postType = postType;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public String getHasFile() {
		return hasFile;
	}

	public void setHasFile(String hasFile) {
		this.hasFile = hasFile;
	}

	public int getHasComment() {
		return hasComment;
	}

	public void setHasComment(int hasComment) {
		this.hasComment = hasComment;
	}

	public Timestamp getPostDate() {
		return postDate;
	}

	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}

	public Timestamp getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	public String getPostType() {
		return postType;
	}

	public void setPostType(String postType) {
		this.postType = postType;
	}

	@Override
	public String toString() {
		return "Freeboard [postNum=" + postNum + ", writer=" + writer + ", userId=" + userId + ", title=" + title
				+ ", contents=" + contents + ", viewCnt=" + viewCnt + ", hasFile=" + hasFile + ", hasComment="
				+ hasComment + ", postDate=" + postDate + ", updateDate=" + updateDate + ", postType=" + postType + "]";
	}

}
