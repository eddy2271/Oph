package com.oph.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oph.service.CodeServiceI;
import com.oph.service.UserServiceI;
import com.oph.vo.CodeVo;
import com.oph.vo.UserVo;

@Controller
public class UserConteroller {

	@Autowired
	UserServiceI userService;
	
	@Autowired
	CodeServiceI codeService;
	
	/**
	 * 회원관리 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/user.do")
	public ModelAndView userManageView(HttpServletRequest request, CodeVo codeVo) {
		ModelAndView mv = new ModelAndView("/user/user");
		
		codeVo.setCodeDiv("ATH");
		mv.addObject("valList", codeService.selectCodeValList(codeVo));
		codeVo.setCodeDiv("STS");
		mv.addObject("stsList", codeService.selectCodeValList(codeVo));
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/userList.do")
	public Object userList(HttpServletRequest request, HttpServletResponse response, @RequestBody UserVo userVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> userList = new ArrayList<Map<String,Object>>();
			
			userList = userService.selectUserList(userVo);
			map.put("userList", userList);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "회원목록 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
}
