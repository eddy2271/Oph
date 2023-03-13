package com.oph.controller;

import java.lang.reflect.Field;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oph.service.EventServiceI;
import com.oph.vo.LoginVo;
import com.oph.vo.SearchVo;

@Controller
public class EventController {

	@Autowired
	private EventServiceI eventService;

	/**
	 * 이벤트 화면 초기 데이터 Setting
	 * @param request, session
	 * @return ModelAndView
	 */
	@RequestMapping(value="/evtFrame.do")
	public ModelAndView viewLoginView(HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> param = new HashMap<String, Object>();
		
		mv.setViewName("/evt/evt");
		LoginVo loginVo 	= (LoginVo) session.getAttribute("userInfo");
		String userDiv 		= loginVo.getUser_div();		// 회원 구분
		String userId		= loginVo.getUser_id();			// 회원 ID
		String userCodeVal	= loginVo.getUser_code_val();	// 회원 코드
		
		if(userDiv.equals("ATH001")) { // 파트너 권한
			param.put("userDiv", userDiv);
			param.put("userId", userId);
			mv.addObject("partnerList", eventService.getAthList(param)); // 파트너 리스트 가져오기
			param.put("userCodeVal", userCodeVal);
			mv.addObject("clientList", eventService.getClientList(param)); // 연관된 클라이언트 리스트 가져오기
		} else if(userDiv.equals("ATH002")) { // 클라이언트 권한
			param.put("userDiv", userDiv);
			param.put("userId", userId);
			mv.addObject("clientList", eventService.getAthList(param)); // 클라이언트 리스트 가져오기
		} else { // 관리자 권한
			param.put("userDiv", "ATH001");
			mv.addObject("partnerList", eventService.getAthList(param)); // 파트너 리스트 가져오기
			param.put("userDiv", "ATH002");
			mv.addObject("clientList", eventService.getAthList(param)); // 클라이언트 리스트 가져오기
		}
		
		mv.addObject("revList", eventService.getRevList()); // 예약현황 리스트 가져오기
		
		return mv;
	}
	
	/**
	 * 이벤트 목록 조회 - dataTable용
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/evtList.do", method = RequestMethod.POST)
	public Map<String, Object> getEvtList(@RequestParam Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", eventService.getEvtList(param)); // 이벤트 리스트 가져오기
		
		return result;
	}
	
	/**
	 * 이벤트 저장
	 * @param request
	 * @return
	 */
	@ResponseBody
	@SuppressWarnings("finally")
	@RequestMapping(value="/saveEvt.do")
	public Map<String, Object> saveEvt(@RequestBody Map<String, Object> param, HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("rsCd", 0);
		result.put("rsMsg", "처리 중 문제가 발생하였습니다.");
		
		try {
			LoginVo loginVo = (LoginVo) session.getAttribute("userInfo");
			String userDiv = loginVo.getUser_div();		// 회원 구분
			
			if(userDiv.equals("ATH999") || userDiv.equals("ATH001")) {
				InetAddress ipAddress = InetAddress.getLocalHost();
				param.put("evtIp", ipAddress.getHostAddress());
				int cnt = 0;
				
				if(param.get("state").equals("C")) { // 추가
					cnt = eventService.saveEvt(param);
				} else { // 수정
					param.put("userDiv", userDiv);
					cnt = eventService.updateEvt(param);
				}
				
				if(cnt >= 1) result.put("rsCd", cnt);
			} else {
				result.put("rsMsg", "관리자 및 파트너만 이용할 수 있습니다.");
			}
		} catch(Exception e) {
			System.out.println("saveEvt Error : " + e);
		} finally {
			return result;
		}
	}
	
	/**
	 * 이벤트 삭제
	 * @param request
	 * @return
	 */
	@ResponseBody
	@SuppressWarnings("finally")
	@RequestMapping(value="/removeEvt.do")
	public Map<String, Object> removeEvt(@RequestBody Map<String, Object> param, HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("rsCd", 0);
		result.put("rsMsg", "처리 중 문제가 발생하였습니다.");
		
		try {
			LoginVo loginVo = (LoginVo) session.getAttribute("userInfo");
			String userDiv = loginVo.getUser_div();	// 회원 구분
			
			if(userDiv.equals("ATH999")) {
				int cnt = eventService.removeEvt(param);
				
				if(cnt >= 1) result.put("rsCd", cnt);
			} else {
				result.put("rsMsg", "관리자만 이용할 수 있습니다.");
			}
		} catch(Exception e) {
			System.out.println("saveEvt Error : " + e);
		} finally {
			return result;
		}
	}
	
	/**
	 * 엑셀 다운로드
	 * @param request
	 */
	@RequestMapping(value="/excelDown.do", method = RequestMethod.GET)
	public void excelDown(SearchVo searchVo, HttpServletResponse res, HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			LoginVo loginVo = (LoginVo) session.getAttribute("userInfo");
			String userDiv = loginVo.getUser_div();		// 회원 구분
			String type = userDiv.equals("ATH001") ? "1" : "2";
			Workbook wb = new HSSFWorkbook();
			int rowNo = 0;
			int num = 0;
			
			// Vo to Map
			Field[] fields = searchVo.getClass().getDeclaredFields();
			Map<String, Object> param = new HashMap<String, Object>();
			for(Field field : fields) {
				field.setAccessible(true);
				param.put(field.getName(), field.get(searchVo));
			}
			
			// 목록 가져오기
			List<Map<String, Object>> list = eventService.getEvtList(param);
			
			Sheet sheet = wb.createSheet("이벤트 데이터");
			org.apache.poi.ss.usermodel.Row row = null;
			Cell cell = null;

			// 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();
		    
		    // 헤더 경계선 = 가늘게
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);

		    // 헤더 배경색 = 연보라
		    headStyle.setFillForegroundColor(HSSFColorPredefined.LIGHT_CORNFLOWER_BLUE.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		    // 헤더 데이터 정렬 = 가운데 정렬
		    headStyle.setAlignment(HorizontalAlignment.CENTER);

		    // 바디 경계선 = 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    
		    // 바디 배경색 = 연보라
		    bodyStyle.setFillForegroundColor(HSSFColorPredefined.WHITE.getIndex());
		    bodyStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    
		    // 바디 데이터정렬 = 가운데 정렬
		    bodyStyle.setAlignment(HorizontalAlignment.CENTER);

		    // 헤더 데이터 넣기
		    row = sheet.createRow(rowNo++);
		    
		    ArrayList<String> headList = new ArrayList<String>(Arrays.asList("no.", "클라이언트", "파트너사", "고객명", "나이", "연락처", "지면명", "신청일자", "설문1", "설문2", "설문3", "설문4", "설문5", "설문6", "메모", "예약현황"));
		    ArrayList<String> colList = new ArrayList<String>(Arrays.asList("NUM", "EVT_CLNT_NM", "EVT_PARTNER_NM", "EVT_USER_NM", "EVT_USER_AGE", "EVT_USER_PH_NUM", "EVT_AR_NM", "REG_DT_EXCEL", "EVT_SURVEY1", "EVT_SURVEY2", "EVT_SURVEY3", "EVT_SURVEY4", "EVT_SURVEY5", "EVT_SURVEY6", "EVT_DESC", "EVT_STS_NM"));
		    
		    for(int i=0; i<headList.size(); i++) {
		    	if(!(i == 2 && userDiv.equals("ATH002"))) {
		    		cell = row.createCell(num);
				    cell.setCellStyle(headStyle);
				    cell.setCellValue(headList.get(i));
				    num++;
		    	}
		    }

		    // 데이터 부분 생성
		    for(Map<String, Object> map : list) {
		        row = sheet.createRow(rowNo++);
		        num = 0;
		        for(int i=0; i<colList.size(); i++) {
		        	if(!(i == 2 && userDiv.equals("ATH002"))) {
		        		cell = row.createCell(num);
				        cell.setCellStyle(bodyStyle);
				        
				        if(i==5) {
				        	cell.setCellValue(changePh(map.get(colList.get(i)).toString(), type));
				        } else {
				        	String cellData = map.get(colList.get(i)).toString();
				        	cellData = i == 0 ? cellData.replaceAll("\\.0", "") : cellData;
				        	
				        	cell.setCellValue(cellData);
				        }
				        
					    num++;
		        	}
			    }
		    }

		    // 컨텐츠 타입과 파일명 지정
		    res.setContentType("ms-vnd/excel");
		    res.setHeader("Content-Disposition", "attachment;filename=eventList.xls");
		    
		    // 엑셀 출력
		    wb.write(res.getOutputStream());
		    wb.close();
		} catch(Exception e) {
			
		}
	}
	
	public static String changePh(String number, String type) {
		String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
		String str = "";
		
		if(number.length() == 10) {
			str = number.replaceAll(regEx, "$1 - " + (type == "1" ? "***" : "$2") + " - $3"); 
		} else if(number.length() == 11) {
			str = number.replaceAll(regEx, "$1 - " + (type == "1" ? "****" : "$2") + " - $3");
		}
	    
		return str;
    }
}
