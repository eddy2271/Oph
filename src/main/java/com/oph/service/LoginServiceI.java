package com.oph.service;

import java.util.Map;

import com.oph.vo.LoginVo;

public interface LoginServiceI {

	
	LoginVo selectUserInfo(Map<String,Object> param);
}
