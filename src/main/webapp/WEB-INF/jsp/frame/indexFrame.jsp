<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>OPH</title>
</head> 

<frameset rows="160, 60,*"  frameborder="no" border="0" framespacing="0">
    	<frame style="background:200px;" src="${pageContext.request.contextPath}/topFrame.do" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
    	<frame style="background:200px;" src="${pageContext.request.contextPath}/menuFrame.do" name="topFrame" scrolling="No" noresize="noresize" id="menuFrame" title="menuFrame" />
        <frame src="${pageContext.request.contextPath}/frame/empty.jsp" style="padding : 1%;" name="mainFrame" id="mainFrame" title="mainFrame"/>
</frameset>
</html>