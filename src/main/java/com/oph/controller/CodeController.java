package com.oph.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oph.service.CodeServiceI;
import com.oph.vo.CodeVo;

@Controller
public class CodeController {
	
	@Autowired
	CodeServiceI codeService;
	
	@ResponseBody
	@RequestMapping(value="/codeList")
	public Object codeList(HttpServletRequest request, HttpServletResponse response, CodeVo codeVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> codeList = new ArrayList<Map<String,Object>>();
			codeList = codeService.selectCodeList(codeVo);
			map.put("result", 1); // 성공
		} catch(Exception e) {
			map.put("reulst", -1); // 실패
		}
		
		return map;
	}
}
