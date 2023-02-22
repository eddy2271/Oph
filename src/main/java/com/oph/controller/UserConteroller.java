package com.oph.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserConteroller {

	/**
	 * 회원관리 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/user.do")
	public ModelAndView userManageView(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/user/user");
		return mv;
	}
	
	
}
