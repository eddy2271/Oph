package com.oph.dao;

import java.util.List;
import java.util.Map;

import com.oph.vo.CodeVo;

public interface CodeDaoI {
	
	/**
	 * code 구분 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeDivList();
	
	/**
	 * code 값 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo);
	/**
	 * code 목록 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo);
	
	/**
	 * code 중복 조회
	 * @param codeVo
	 * @return
	 */
	public Map<String, Object> selectCodeData(CodeVo codeVo);
	
	/**
	 * code 등록 수정
	 * @param codeVo
	 * @return
	 */
	public int codeChange(CodeVo codeVo);
	
}
