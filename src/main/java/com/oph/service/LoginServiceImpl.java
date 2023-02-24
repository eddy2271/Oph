package com.oph.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oph.dao.LoginDaoI;
import com.oph.vo.LoginVo;

@Service("LoginServiceI")
public class LoginServiceImpl implements LoginServiceI{

	@Autowired
	LoginDaoI loginDao;
	
	@Override
	public LoginVo selectUserInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return loginDao.selectUserInfo(param);
	}

}
