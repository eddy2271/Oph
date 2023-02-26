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
	
	@Override
	public List<Map<String, Object>> selectUserCodeList(UserVo userVo) {
		return userDao.selectUserCodeList(userVo);
	}
	
	@Override
	public Map<String, Object> selectUserId(UserVo userVo) {
		return userDao.selectUserId(userVo);
	}
	
	@Override
	public int userChange(UserVo userVo) {
		return userDao.userChange(userVo);
	}
}
