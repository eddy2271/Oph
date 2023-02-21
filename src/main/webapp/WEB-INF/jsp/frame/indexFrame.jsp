<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>OPH</title>
</head> 

<frameset rows="200,*"  frameborder="no" border="0" framespacing="0">
    <frame src="${pageContext.request.contextPath}/topFrame.do" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
    <frameset rows="45,*,45" cols="*" framespacing="0" frameborder="no" border="0">
        <frame src="${pageContext.request.contextPath}/html/empty.html" name="mainFrame" id="mainFrame" title="mainFrame"/>
    </frameset>
</frameset>
 
</html>