package com.oph.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class FrameController  {
	@RequestMapping(value="/indexFrame.do")
	public ModelAndView indexFrame(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("/frame/indexFrame");
		
		return mv;
	}
	
	@RequestMapping(value="/topFrame.do")
	public ModelAndView topFrame(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("/frame/topFrame");
		
		return mv;
	}
	
	@RequestMapping(value="/menuFrame.do")
	public ModelAndView menuFrame(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("/frame/menuFrame");
		
		return mv;
	}
}
