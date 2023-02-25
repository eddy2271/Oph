<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<!-- CSS Style Sheet import -->
<title></title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/top.css" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/menu.css" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">


	$(document).ready(function(){
		parent.mainFrame.location = "${pageContext.request.contextPath}/evtFrame.do";
	});
	
	function setLogOut() 
	{
		if(confirm('로그아웃 하시겠습니까?')){
			parent.mainFrame.location = '${pageContext.request.contextPath}/logout.do?';
		}
	} 
	function goMenu(tab){
		if( tab == '1'){
			parent.mainFrame.location = "${pageContext.request.contextPath}/evtFrame.do";
			$("#code").removeClass();
			$("#user").removeClass();
			$("#evt").addClass("on");
			
		}else if( tab == '2'){ 
			parent.mainFrame.location = "${pageContext.request.contextPath}/user.do";
			$("#evt").removeClass();
			$("#code").removeClass();
			$("#user").addClass("on");
		}else if( tab == '3'){
			parent.mainFrame.location = "${pageContext.request.contextPath}/code.do";
			$("#evt").removeClass();
			$("#user").removeClass();
			$("#code").addClass("on");
		}
	}
</script>

</head>
<body>
    
	<div id="contents" >
		<ul class="webtong_tab_type02">
			<li id="evt" class="on"><a href="javascript:goMenu('1')">이벤트관리</a></li>
			<c:if test='${userInfo.user_div == "ATH999"}'>
				<li id="user" ><a href="javascript:goMenu('2')">회원관리</a></li>
				<li id="code" ><a href="javascript:goMenu('3')">코드관리</a></li>
			</c:if>
			
		</ul>
	</div>
</body>
</html>