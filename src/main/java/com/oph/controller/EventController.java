package com.oph.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.oph.service.EventServiceI;

@Controller
public class EventController {

	@Autowired
	private EventServiceI eventService;

	/**
	 * 이벤트 목록 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/evtFrame.do")
	public ModelAndView viewLoginView(HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/evt/evt");
//		String userDiv 		= session.getAttribute("userDiv").toString();		// 회원 구분
//		String userCodeVal	= session.getAttribute("userCodeVal").toString();	// 회원 코드 값
		
//		if(userDiv.equals("ATH001")) { // 파트너 권한
//			
//		} else if(userDiv.equals("ATH002")) { // 클라이언트 권한
//			
//		} else { // 관리자 권한
//			
//		}
		
//		mv.addObject("partnerList", eventService.getPartnerList(userCodeVal)); // 파트너 리스트 가져오기
		
		return mv;
	}
	
}
