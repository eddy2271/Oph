package com.oph.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oph.dao.UserDaoI;
import com.oph.vo.UserVo;

@Service("UserServiceI")
public class UserServiceImpl implements UserServiceI{

	@Autowired
	UserDaoI userDao;
	
	@Override
	public List<Map<String, Object>> selectUserList(UserVo userVo) {
		return userDao.selectUserList(userVo);
	}
	
//	@Override
//	public List<Map<String, Object>> selectCodeDivList() {
//		return userDao.selectCodeDivList();
//	}
//	
//	@Override
//	public List<Map<String, Object>> selectCodeValList(CodeVo codeVo) {
//		return userDao.selectCodeValList(codeVo);
//	}
//	
	
//	
//	@Override
//	public int codeChange(CodeVo codeVo) {
//		return userDao.codeChange(codeVo);
//	}
}
