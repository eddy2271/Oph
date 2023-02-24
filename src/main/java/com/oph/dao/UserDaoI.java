package com.oph.dao;

import java.util.List;
import java.util.Map;

import com.oph.vo.UserVo;

public interface UserDaoI {
	
	/**
	 * 회원 목록 조회
	 * @param userVo
	 * @return
	 */
	public List<Map<String, Object>> selectUserList(UserVo userVo);
	
//	/**
//	 * code 구분 조회
//	 * @param codeVo
//	 * @return
//	 */
//	public List<Map<String, Object>> selectCodeDivList();
//	
//	/**
//	 * code 값 조회
//	 * @param codeVo
//	 * @return
//	 */
//	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo);
//	
//	/**
//	 * code 등록 수정
//	 * @param codeVo
//	 * @return
//	 */
//	public int codeChange(CodeVo codeVo);
	
}
