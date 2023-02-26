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

	// 파트너/클라이언트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getAthList(Map<String, Object> param) {
		return eventDaoI.getAthList(param);
	}
	
	// 연관된 클라이언트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getClientList(Map<String, Object> param) {
		return eventDaoI.getClientList(param);
	}
	
	// 예약현황 리스트 가져오기
	@Override
	public List<Map<String, Object>> getRevList() {
		return eventDaoI.getRevList();
	}

	// 이벤트 리스트 가져오기
	@Override
	public List<Map<String, Object>> getEvtList(Map<String, Object> param) {
		return eventDaoI.getEvtList(param);
	}

	// 데이터 저장하기
	@Override
	public int saveEvt(Map<String, Object> param) {
		return eventDaoI.saveEvt(param);
	}

	// 데이터 수정하기
	@Override
	public int updateEvt(Map<String, Object> param) {
		return eventDaoI.updateEvt(param);
	}
	
	// 데이터 삭제하기
	@Override
	public int removeEvt(Map<String, Object> param) {
		return eventDaoI.removeEvt(param);
	}
}
