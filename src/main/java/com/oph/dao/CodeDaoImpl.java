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
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo) {
		return sqlSession.selectList("code.selectCodeList", codeVo);
	}
}
