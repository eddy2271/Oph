package com.oph.dao;

import java.util.Map;

import com.oph.vo.LoginVo;

public interface LoginDaoI {

	
	LoginVo selectUserInfo(Map<String,Object> param);
}
