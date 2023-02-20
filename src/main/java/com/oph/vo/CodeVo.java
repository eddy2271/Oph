package com.oph.vo;

public class CodeVo {
	String codeDiv; // 코드 구분
	String codeVal; // 코드 값
	String codeDesc; // 코드 설명
	
	public String getCodeDiv() {
		return codeDiv;
	}
	public void setCodeDiv(String codeDiv) {
		this.codeDiv = codeDiv;
	}
	public String getCodeVal() {
		return codeVal;
	}
	public void setCodeVal(String codeVal) {
		this.codeVal = codeVal;
	}
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	
	@Override
	public String toString() {
		return "CodeVo [codeDiv=" + codeDiv + ", codeVal=" + codeVal + ", codeDesc=" + codeDesc + "]";
	}
	
}
