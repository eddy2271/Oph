package com.oph.vo;

public class CodeVo {
	String codeDiv; // 코드 구분
	String codeVal; // 코드 값
	String codeDivDesc; // 코드 설명
	String codeValDesc; // 코드 설명
	
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
	public String getCodeDivDesc() {
		return codeDivDesc;
	}
	public void setCodeDivDesc(String codeDivDesc) {
		this.codeDivDesc = codeDivDesc;
	}
	public String getCodeValDesc() {
		return codeValDesc;
	}
	public void setCodeValDesc(String codeValDesc) {
		this.codeValDesc = codeValDesc;
	}
	@Override
	public String toString() {
		return "CodeVo [codeDiv=" + codeDiv + ", codeVal=" + codeVal + ", codeDivDesc=" + codeDivDesc + ", codeValDesc="
				+ codeValDesc + "]";
	}
	
}
