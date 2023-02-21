package com.oph.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EventController {


	/**
	 * 로그인 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/evtFrame.do")
	public ModelAndView viewLoginView(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/evt/evt");
		return mv;
	}
	
}
