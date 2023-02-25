package com.oph.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.oph.vo.LoginVo;

public class OphInterceptorController  implements HandlerInterceptor{
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
			HttpSession session = request.getSession();
	        LoginVo userInfo = (LoginVo)session.getAttribute("userInfo");
	        if(request.getRequestURI().toString().equals("/login.do") || 
	        		request.getRequestURI().toString().equals("/loginUser.do") ||
	        		request.getRequestURI().toString().equals("/logout.do") ) {
	        	return true;
	        }else {
	        	if(userInfo == null) {
	        		goAlertURL("로그인을 하지않으셨습니다. 로그인 페이지로 이동합니다" , "./login.do" , response);
	        		return false;
	        	}else { 
	        	}
	        }
	        
	  
        
        
        return true;
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        
        System.out.println("postHandle1");
        
        
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        
        System.out.println("afterCompletion1");
        
        
    }    
    
	private static void jsExecute(String script,HttpServletResponse response) throws IOException
	{		
		response.setContentType("text/html;charset=utf-8");	
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();				
		out.println(" <script>");
		out.println(" <!-- ");		
		out.println(script);		  
		out.println(" //-->");
		out.println(" </script>");
	}
	  
	public static void goAlertURL(String msg, String url,HttpServletResponse response) throws Exception
	{
		String script = "";
		if(!msg.equals(""))
		{
			script +=" alert(\"" + msg + "\"); ";
		}
		//script += " location.href = \"" + url + "\"; ";
		script += " location.replace(\"" + url + "\"); ";
		jsExecute(script,response);
	}

}
