package com.oph.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oph.service.LoginServiceI;
import com.oph.vo.LoginVo;

@Controller
public class LoginConteroller {
	
	@Autowired
	LoginServiceI loginService;

	/**
	 * 로그인 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/login.do")
	public ModelAndView viewLoginView(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/login/login");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/loginUser.do")
	public Object loginUser(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String,Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		try { 
			HttpSession session = request.getSession();
			LoginVo valList = new LoginVo();
			valList = loginService.selectUserInfo(param);
			if(valList != null){
				session.setAttribute("userInfo", valList);
				map.put("result", 1); // 실패
			}else {
				map.put("result", 2); // 실패
				map.put("message", "아이디 또는 패스워드가 일치하지 않습니다."); // 실패
			}
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", -1); // 실패
			map.put("message", "아이디 또는 패스워드가 일치하지 않습니다."); // 실패
		}
		
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/logout.do")
	public Object logout(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try { 
			HttpSession session = request.getSession();
			LoginVo valList = new LoginVo();
			session.invalidate(); // 세션 초기화
			map.put("result", 1); // 실패
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", -1); // 실패
		}
		
		return map;
	}
	
	
}
