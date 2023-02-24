package com.oph.dao;

import java.util.List;
import java.util.Map;

import com.oph.vo.CodeVo;

public interface CodeDaoI {
	
	/**
	 * code Div 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeDivList();
	
	/**
	 * code Div 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo);
	/**
	 * code 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo);
}
