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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Object userValList(HttpServletRequest request, HttpServletResponse response, @RequestBody UserVo userVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			CodeVo codeVo = new CodeVo();
			
			if(userVo.getUserDiv().equals("ATH001")) { // 파트너등급
				codeVo.setCodeDiv("PAT");
			} else if(userVo.getUserDiv().equals("ATH002")) { // 클라이언트등급
				codeVo.setCodeDiv("CLT");
			}
			
			List<Map<String, Object>> userList = userService.selectUserCodeList(userVo);
			List<Map<String, Object>> codeList = codeService.selectCodeValList(codeVo);
			if(userList != null && !userList.isEmpty()) {
				for(Map<String, Object> user : userList) {
					String userCodeVal = (String) user.get("USER_CODE_VAL");
					if(codeList != null && !codeList.isEmpty()) {
						for(int i=0; i < codeList.size(); i++) {
							String codeVal = (String)codeList.get(i).get("CODE_VAL");
							if(userCodeVal.equals(codeVal)) {
								System.out.println("userCodeVal : " + userCodeVal);
								System.out.println("codeVal : " + codeVal);
								codeList.remove(i);
							}
						}
					}
				}
			}
			
			map.put("codeList", codeList);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "회원목록 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
	
	/**
	 * 회원 목록 조회 - dataTable용
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/userList.do", method = RequestMethod.POST)
	public Map<String, Object> getEvtList(@RequestParam Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", userService.selectUserList(param)); // 이벤트 리스트 가져오기
		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/idCheck.do")
	public Object idCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody UserVo userVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Map<String, Object> chkMap = userService.selectUserId(userVo);
			if (chkMap != null && !chkMap.isEmpty()) {
				if(chkMap.size() > 0) {
					map.put("message", "이미 등록되어있는 ID입니다."); // 메시지
					map.put("result", 1); // 이미등록되어있음
				}
			} else {
				map.put("message", "사용 가능한 ID입니다."); // 메시지
				map.put("result", 0); // 등록되어있지않음
			}
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "아이디 조회에 실패했습니다."); // 실패
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
			map.put("message", "회원 등록/수정에 실패했습니다."); // 실패
		}
		
		return map;
	}
}
