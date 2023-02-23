package com.oph.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("EventServiceI")
public class EventServiceImpl implements EventServiceI{

	// 파트너 리스트 가져오기
	@Override
	public List<Map<String, Object>> getPartnerList(String userCodeVal) {

		return null;
	}

}
