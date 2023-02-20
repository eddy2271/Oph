package com.oph.dao;

import java.util.List;
import java.util.Map;

import com.oph.vo.CodeVo;

public interface CodeDaoI {
	/**
	 * code 조회
	 * @param codeVo
	 * @return
	 */
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo);
}
