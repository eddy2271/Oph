package com.oph.vo;

public class UserVo {
	String userId;			//회원ID
	String userPw;			//회원 비밀번호
	String userNm;			//회원 명
	String userDiv;			//회원 구분값
	String userCodeVal;		//회원 등급코드값
	String userPhNum;		//회원 휴대전화번호
	String userEvtCode;		//회원 이벤트(광고)코드
	String userSts;			//회원 상태
	String startDt;			//등록일시작일시
	String endDt;			//등록일종료일시
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserDiv() {
		return userDiv;
	}
	public void setUserDiv(String userDiv) {
		this.userDiv = userDiv;
	}
	public String getUserCodeVal() {
		return userCodeVal;
	}
	public void setUserCodeVal(String userCodeVal) {
		this.userCodeVal = userCodeVal;
	}
	public String getUserPhNum() {
		return userPhNum;
	}
	public void setUserPhNum(String userPhNum) {
		this.userPhNum = userPhNum;
	}
	public String getUserEvtCode() {
		return userEvtCode;
	}
	public void setUserEvtCode(String userEvtCode) {
		this.userEvtCode = userEvtCode;
	}
	public String getUserSts() {
		return userSts;
	}
	public void setUserSts(String userSts) {
		this.userSts = userSts;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	
	@Override
	public String toString() {
		return "UserVo [userId=" + userId + ", userPw=" + userPw + ", userNm=" + userNm + ", userDiv=" + userDiv
				+ ", userCodeVal=" + userCodeVal + ", userPhNum=" + userPhNum + ", userEvtCode=" + userEvtCode
				+ ", userSts=" + userSts + ", startDt=" + startDt + ", endDt=" + endDt + "]";
	}
}
