package com.oph.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oph.vo.CodeVo;

@Repository("CodeDaoI")
public class CodeDaoImpl implements CodeDaoI{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<Map<String, Object>> selectCodeDivList() {
		return sqlSession.selectList("code.selectCodeDivList");
	}
	
	@Override
	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo) {
		return sqlSession.selectList("code.selectCodeValList", codeVo);
	}
	
	@Override
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo) {
		return sqlSession.selectList("code.selectCodeList", codeVo);
	}
	
	@Override
	public int codeChange(CodeVo codeVo) {
		int cnt = 0;
		if("C".equals(codeVo.getMode())) {
			cnt = sqlSession.insert("code.codeInsert", codeVo);
		} else if("M".equals(codeVo.getMode())) {
			cnt = sqlSession.update("code.codeUpdate", codeVo);
		} else if("D".equals(codeVo.getMode())) {
			cnt = sqlSession.delete("code.codeDelete", codeVo);
		}
		
		return cnt;
	}
}
