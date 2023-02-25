package com.oph.service;

import java.util.List;
import java.util.Map;

import com.oph.vo.UserVo;

public interface UserServiceI {
	
	/**
	 * 회원 목록 조회
	 * @param userVo
	 * @return
	 */
	public List<Map<String, Object>> selectUserList(UserVo userVo);
	
	/**
	 * 회원 ID 조회
	 * @param userVo
	 * @return
	 */
	public Map<String, Object> selectUserId(UserVo userVo);
	
	/**
	 * 회원정보 등록/수정
	 * @param codeVo
	 * @return
	 */
	public int userChange(UserVo userVo);
}
