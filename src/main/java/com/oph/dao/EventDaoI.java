package com.oph.dao;

import java.util.List;
import java.util.Map;

public interface EventDaoI {
	// 파트너/클라이언트 리스트 가져오기
	List<Map<String, Object>> getAthList(Map<String, Object> param);
	
	// 연관된 클라이언트 리스트 가져오기
	List<Map<String, Object>> getClientList(Map<String, Object> param);
	
	// 예약현황 리스트 가져오기
	List<Map<String, Object>> getRevList();

	// 이벤트 리스트 가져오기
	List<Map<String, Object>> getEvtList(Map<String, Object> param);
	
	// 데이터 저장하기
	int saveEvt(Map<String, Object> param);
	
	// 데이터 수정하기
	int updateEvt(Map<String, Object> param);
	
	// 데이터 삭제하기
	int removeEvt(Map<String, Object> param);
}
