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
		
		List<Map<String, Object>> valList = new ArrayList<Map<String, Object>>(); 
		for(Map<String, Object> map : codeService.selectCodeValList(codeVo)) {
			String codeVal = (String) map.get("CODE_VAL");
			// 회원조회시 관리자등급은 제외
			if(codeVal.equals("ATH999")) continue;
			valList.add(map);
		}
		
		mv.addObject("valList", valList);
		codeVo.setCodeDiv("STS");
		mv.addObject("stsList", codeService.selectCodeValList(codeVo));
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/userValList.do")
	public Object userValList(HttpServletRequest request, HttpServletResponse response, @RequestBody CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> userList = new ArrayList<Map<String,Object>>();
			codeVo.setCodeDiv("ATH");
			
			List<Map<String, Object>> valList = new ArrayList<Map<String, Object>>(); 
			for(Map<String, Object> user : userList) {
				String userCodeVal = (String) user.get("USER_CODE_VAL");
				for(Map<String, Object> code : codeService.selectCodeValList(codeVo)) {
					String codeVal = (String) code.get("CODE_VAL");
					// 회원조회시 관리자등급은 제외
					if(codeVal.equals("ATH999")) continue;
					else if(userCodeVal.equals(codeVal)) continue;// 회원조회시 등록되어있는 회원코드는 제외
					valList.add(map);
				}
			}
			map.put("valList", valList);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "회원목록 조회에 실패했습니다."); // 실패
		}
		
		return map;
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
	
	@ResponseBody
	@RequestMapping(value="/idCheck.do")
	public Object idCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody UserVo userVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Map<String, Object> chkMap = userService.selectUserId(userVo);
			
			if(chkMap.size() > 0) {
				map.put("message", "이미 등록되어있는 ID 입니다."); // 메시지
				map.put("result", 1); // 이미등록되어있음
			} else {
				map.put("result", 0); // 등록되어있지않음
			}
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "코드 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/userChange.do")
	public Object userChange(HttpServletRequest request, HttpServletResponse response, @RequestBody UserVo userVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			int userChange = 0;
			userChange = userService.userChange(userVo);
			
			if(userChange > 0) {
				String msg = "";
				
				if("C".equals(userVo.getMode())) {
					msg = "회원정보를 정상적으로 등록하였습니다.";
				} else if("M".equals(userVo.getMode())) {
					msg = "회원정보를 정상적으로 수정하였습니다.";
				} else if("D".equals(userVo.getMode())) {
					msg = "회원정보를 정상적으로 삭제하였습니다.";
				}
				map.put("message", msg); // 성공메시지
				map.put("result", userChange); // 성공
			} else {
				throw new Exception();
			}
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "코드 등록/수정에 실패했습니다."); // 실패
		}
		
		return map;
	}
}
