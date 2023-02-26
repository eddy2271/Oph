package com.oph.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oph.vo.CodeVo;
import com.oph.vo.UserVo;

@Repository("UserDaoI")
public class UserDaoImpl implements UserDaoI{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<Map<String, Object>> selectUserList(UserVo userVo) {
		return sqlSession.selectList("user.selectUserList", userVo);
	}
	
	@Override
	public List<Map<String, Object>> selectUserCodeList(UserVo userVo) {
		return sqlSession.selectList("user.selectUserCodeList", userVo);
	}
	
	@Override
	public Map<String, Object> selectUserId(UserVo userVo) {
		return sqlSession.selectOne("user.selectUserId", userVo);
	}
	
	@Override
	public int userChange(UserVo userVo) {
		int cnt = 0;
		if("C".equals(userVo.getMode())) {
			cnt = sqlSession.insert("user.userInsert", userVo);
		} else if("M".equals(userVo.getMode())) {
			cnt = sqlSession.update("user.userUpdate", userVo);
		} else if("D".equals(userVo.getMode())) {
			cnt = sqlSession.delete("user.userDelete", userVo);
		}
		
		return cnt;
	}
	
}
