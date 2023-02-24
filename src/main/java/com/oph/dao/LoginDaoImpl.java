package com.oph.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oph.vo.LoginVo;

@Repository("LoginDaoI")
public class LoginDaoImpl implements LoginDaoI{


	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public LoginVo selectUserInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("login.selectUserInfo",param);
	}

}
