<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<!-- CSS Style Sheet import -->
<title></title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/top.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						parent.mainFrame.location = "${pageContext.request.contextPath}/evtFrame.do";
					});

	function setLogOut() {
		if (confirm('로그아웃 하시겠습니까?')) {
			
			request("./logout.do",null,
					function callback(response,status) {
						alert("정상적으로 로그아웃 되었습니다.")
						window.top.document.location ="./login.do";
					},
					function error(request,status) {
						alert(status);
					});
		}
	}
</script>

</head>
<body>
	<div class="header-menu" id="divHeader"
		style="width: 100%; padding-left: 2%; margin-top: 2%;">
		<div style="width: 80%; float: left;">
			<div class="two" style="padding-left: 2%;">
				<h1>
					201 컴퍼니 <span>201 Company</span>
				</h1>
			</div>
		</div>
		<div style="float: right; padding-right : 4%;">
			<span style="font-weight :900; font-size : 13pt;">${userInfo.user_id }</span>
			<c:if test='${userInfo.user_div == "ATH999"}'>
				<span>&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;</span>
				<span style="font-size :13pt;">관리</span>
			</c:if>
			<span>&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;</span>
			<span style="font-size : 13pt;" onClick="javascript:setLogOut()">로그아웃</span> 
		</div>
	</div>
</body>
</html>