package com.oph.dao;

import java.util.List;
import java.util.Map;

public interface EventDaoI {

	// 이벤트 리스트 가져오기
	List<Map<String, Object>> getEvtList(Map<String, Object> param);
}
