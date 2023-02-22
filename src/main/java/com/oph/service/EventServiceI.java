package com.oph.service;

import java.util.List;
import java.util.Map;

public interface EventServiceI {
	
	// 파트너 리스트 가져오기
	List<Map<String, Object>> getPartnerList(String userCodeVal);

}
