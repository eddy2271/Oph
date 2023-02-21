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
	public List<Map<String, Object>> selectCodeList(CodeVo codeVo) {
		return codeDao.selectCodeList(codeVo);
	}
	
}