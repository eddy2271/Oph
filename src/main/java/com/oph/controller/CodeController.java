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
import com.oph.vo.CodeVo;

@Controller
public class CodeController {
	
	@Autowired
	CodeServiceI codeService;
	
	/**
	 * 코드관리 화면
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/code.do")
	public ModelAndView codeManageView(HttpServletRequest request,CodeVo codeVo) {
		ModelAndView mv = new ModelAndView("/code/code");
		
		List<Map<String, Object>> divList = codeService.selectCodeDivList();
		mv.addObject("divList", divList);
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/codeValList.do")
	public Object codeValList(HttpServletRequest request, HttpServletResponse response, @RequestBody CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> valList = new ArrayList<Map<String,Object>>();
			valList = codeService.selectCodeValList(codeVo);
			map.put("valList", valList);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "코드설명 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/codeList.do")
	public Object codeList(HttpServletRequest request, HttpServletResponse response, @RequestBody CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> codeList = new ArrayList<Map<String,Object>>();
			
			codeList = codeService.selectCodeList(codeVo);
			map.put("codeList", codeList);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "코드목록 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/valCheck.do")
	public Object valCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Map<String, Object> chkMap = codeService.selectCodeData(codeVo);
			if (chkMap != null && !chkMap.isEmpty()) {
				if(chkMap.size() > 0) {
					String codeDiv = (String) chkMap.get("CODE_DIV");
					String codeVal = (String) chkMap.get("CODE_VAL");
					String codeDivDesc = (String) chkMap.get("CODE_DIV_DESC");
					String codeValDesc = (String) chkMap.get("CODE_VAL_DESC");
					map.put("message", "이미 등록되어있는 코드입니다. \n 구분 : "+codeDiv+", 구분 설명 : "+codeDivDesc+", 값 : " + codeVal + ", 값 설명 : " + codeValDesc + ""); // 메시지
					map.put("result", 1); // 이미등록되어있음
				}
			} else {
				map.put("message", "사용 가능한 코드입니다."); 
				map.put("result", 0); // 등록되어있지않음
			}
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
			map.put("message", "코드 조회에 실패했습니다."); // 실패
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/codeChange.do")
	public Object codeChange(HttpServletRequest request, HttpServletResponse response, @RequestBody CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			int codeChange = 0;
			codeChange = codeService.codeChange(codeVo);
			
			if(codeChange > 0) {
				String msg = "";
				
				if("C".equals(codeVo.getMode())) {
					msg = "코드를 정상적으로 등록하였습니다.";
				} else if("M".equals(codeVo.getMode())) {
					msg = "코드를 정상적으로 수정하였습니다.";
				} else if("D".equals(codeVo.getMode())) {
					msg = "코드를 정상적으로 삭제하였습니다.";
				}
				map.put("message", msg); // 성공메시지
				map.put("result", codeChange); // 성공
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
