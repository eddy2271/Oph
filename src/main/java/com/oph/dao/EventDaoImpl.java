package com.oph.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("EventDaoI")
public class EventDaoImpl implements EventDaoI {

	@Autowired
	private SqlSession sqlSession;
	
	// 이벤트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getEvtList(Map<String, Object> param) {
		return sqlSession.selectList("getEvtList", param);
	}
}
