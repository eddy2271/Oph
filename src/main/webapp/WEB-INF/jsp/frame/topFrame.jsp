	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/top.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/menu.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"> 
$.noConflict();
	function setLogOut() {
		if (confirm('로그아웃 하시겠습니까?')) {
			request("./logout.do",null,
					function callback(response,status) {
						alert("정상적으로 로그아웃 되었습니다.")
						location.href ="./login.do";
					},
					function error(request,status) {
						alert(status);
					});
		}
	}
	function goMenu(tab){
		if( tab == '1'){
			location.href = "${pageContext.request.contextPath}/evtFrame.do";
		}else if( tab == '2'){ 
			location.href = "${pageContext.request.contextPath}/user.do";
		}else if( tab == '3'){
			location.href = "${pageContext.request.contextPath}/code.do";
		}
	}
</script>

</head>
<body >
	<div class="header-menu" id="divHeader" 
		style="height : 10vh; width: 100%; margin-top: 2%; padding: 0 30px;">
		<div style="width: 80%; float: left;">
			<div class="two" style="height : 10vh;">
				<div style="width :auto; float : left;">
				<h1 class="top_h1">
					투엘 컴퍼니 <span>TWO.L COMPANY</span>
				</h1>
				</div>
				<c:if test='${userInfo.user_div == "ATH999"}'>
				<div class="test" style="width :22rem; float : left; margin-left :2%; padding-top :1rem;">
					<nav class="menu"> 
							<a href="javascript:goMenu('1')" name="evt" id="evt">이벤트관리</a>
							<a href="javascript:goMenu('2')" name="user" id="user">회원관리</a>
							<a href="javascript:goMenu('3')" name="code" id="code">코드관리</a>
						
						<div class="animation start-home"></div>
					</nav>
				</div>
				</c:if>
			</div>
			
		</div>
		<div style="float: right; padding-right : 4%;"> 
			<span style="font-weight :900; font-size : 1.1rem; cursor:pointer;">${userInfo.user_id }</span>
			<span>&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;</span>
			<span style="font-size : 0.9rem; cursor:pointer;" onClick="javascript:setLogOut()">로그아웃</span> 
		</div>
	</div>
</body>
</html>