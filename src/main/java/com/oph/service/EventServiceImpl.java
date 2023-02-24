package com.oph.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.oph.dao.EventDaoI;

@Service("EventServiceI")
public class EventServiceImpl implements EventServiceI{
	
	@Autowired
	private EventDaoI eventDaoI;

	// 파트너 리스트 가져오기
	@Override
	public List<Map<String, Object>> getPartnerList(String userCodeVal) {
		return null;
	}

	// 이벤트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getEvtList(Map<String, Object> param) {
		return eventDaoI.getEvtList(param);
	}

}
