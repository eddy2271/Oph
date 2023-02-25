package com.oph.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oph.dao.CodeDaoI;
import com.oph.vo.CodeVo;

@Service("CodeServiceI")
public class CodeServiceImpl implements CodeServiceI{

	@Autowired
	CodeDaoI codeDao;
	
	@Override
	public List<Map<String, Object>> selectCodeDivList() {
		return codeDao.selectCodeDivList();
	}
	
	@Override
	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo) {
		return codeDao.selectCodeValList(codeVo);
	}
	
	@Override
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo) {
		return codeDao.selectCodeList(codeVo);
	}
	
	@Override
	public Map<String, Object> selectCodeData(CodeVo codeVo) {
		return codeDao.selectCodeData(codeVo);
	}
	
	@Override
	public int codeChange(CodeVo codeVo) {
		return codeDao.codeChange(codeVo);
	}
}
