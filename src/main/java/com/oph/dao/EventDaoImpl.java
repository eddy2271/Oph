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
	
	// 파트너/클라이언트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getAthList(Map<String, Object> param) {
		return sqlSession.selectList("evt.getAthList", param);
	}
	
	// 연관된 클라이언트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getClientList(Map<String, Object> param) {
		return sqlSession.selectList("evt.getClientList", param);
	}
	
	// 예약현황 리스트 가져오기
	@Override
	public List<Map<String, Object>> getRevList() {
		return sqlSession.selectList("evt.getRevList");
	}
	
	// 이벤트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getEvtList(Map<String, Object> param) {
		return sqlSession.selectList("evt.getEvtList", param);
	}

	// 데이터 저장하기
	@Override
	public int saveEvt(Map<String, Object> param) {
		return sqlSession.insert("evt.saveEvt", param);
	}

	// 데이터 수정하기
	@Override
	public int updateEvt(Map<String, Object> param) {
		return sqlSession.update("evt.updateEvt", param);
	}
	
	// 데이터 삭제하기
	@Override
	public int removeEvt(Map<String, Object> param) {
		return sqlSession.delete("evt.removeEvt", param);
	}
}
