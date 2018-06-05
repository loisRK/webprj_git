package com.iot.pf.dto;

import org.apache.ibatis.type.Alias;

@Alias("Album")
public class Album {

	private int pSeq;
	private String userId;
	private String pFileName;
	private String pFakeName;
	private long pFileSize;
	private String pType;
	private String postDate;
	private String thName;
	
	public int getpSeq() {
		return pSeq;
	}
	public void setpSeq(int pSeq) {
		this.pSeq = pSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getpFileName() {
		return pFileName;
	}
	public void setpFileName(String pFileName) {
		this.pFileName = pFileName;
	}
	public String getpFakeName() {
		return pFakeName;
	}
	public void setpFakeName(String pFakeName) {
		this.pFakeName = pFakeName;
	}
	public long getpFileSize() {
		return pFileSize;
	}
	public void setpFileSize(long pFileSize) {
		this.pFileSize = pFileSize;
	}
	public String getpType() {
		return pType;
	}
	public void setpType(String pType) {
		this.pType = pType;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	
	public String getThName() {
		return thName;
	}
	public void setThName(String thName) {
		this.thName = thName;
	}
	@Override
	public String toString() {
		return "Album [pSeq=" + pSeq + ", userId=" + userId + ", pFileName=" + pFileName + ", pFakeName=" + pFakeName
				+ ", pFileSize=" + pFileSize + ", pType=" + pType + ", postDate=" + postDate + ", thName=" + thName
				+ "]";
	}
	
	
	
}
