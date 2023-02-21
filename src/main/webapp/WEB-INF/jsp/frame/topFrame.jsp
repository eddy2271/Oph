<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<!-- CSS Style Sheet import -->
<title>top</title>

<script type="text/javascript">




	var selectSubMenuId = "rptRealMsgRst";
	$(document).ready(function(){
		var selectMainMenuId =  "left_contents";
		    
		$("#"+selectMainMenuId).css({background:  "#ffffff"});
		$("#"+selectSubMenuId).css({"border-left":  "5px solid #09c"});
		
		$("#left_menu ul ul").slideUp();
		if(!$("#"+selectMainMenuId).next().is(":visible"))
		{
			$("#"+selectMainMenuId).next().slideDown();
		}
		
		$("#left_menu div").hover(
				function(){
					$(this).css({background :  "#ffffff"});
				},
				function(){
					if($(this).attr("id") != selectMainMenuId){
						$(this).css({background: "#ffffff"});
					}
				}		
		);
		
		$("#left_menu ul ul li a").hover(
				function(){
					$(this).css({"border-left":  "5px solid #09c"});
				},
				function(){
					if($(this).attr("id") != selectSubMenuId){
						$(this).css({"border-left": "0px"});
					}
				}		
		);
		
		$("#left_menu div").click(function(){
			$("#left_menu div").css({background : "#ffffff"});
			$(this).css({background : "#ffffff"});
			
			selectMainMenuId = $(this).attr("id");
			
			$("#left_menu ul ul").slideUp();
			if(!$(this).next().is(":visible"))
			{
				$(this).next().slideDown();
			}
		});
		
		$("#left_menu ul ul li a").click(function(){
			$("#left_menu ul ul li a").css({"border-left":  "0px"});
			$(this).css({"border-left" : "5px solid #09c"});
			selectSubMenuId = $(this).attr("id");
		});
		
		parent.mainFrame.location = "${pageContext.request.contextPath}/userManage.do";
	});
	
	function setLogOut() 
	{
		if(confirm('로그아웃 하시겠습니까?')){
			parent.mainFrame.location = '${pageContext.request.contextPath}/logout.do?';
		}
	}
</script>

</head>

<body>
	<div id="left_all">
		<div class="left">
			<div id="left_menu">
				<ul class="left_space">
						<li>
								<div id="left_contents">
									<table class="table01">
										<tr style="display: block;">
										<td class="td01" style="font-size: 15px;">회원 관리</td>
										</tr>
									</table>
								</div>
								<ul>
									<li><a id="accountManage" href="${pageContext.request.contextPath}/userManage.do" target="mainFrame">사용자 관리</a></li>
								</ul>	
						</li>	
						<li>
								<div id="left_contents1">
									<table class="table01">
										<tr style="display: block;">
										<td class="td01" style="font-size: 15px;">그림정보 관리</td>
										</tr>
									</table>
								</div>
								<ul>
									<li><a id="accountManage" href="${pageContext.request.contextPath}/picture/pictureManage.do" target="mainFrame">그림리스트 조회</a></li>
									<li><a id="accountManage" href="${pageContext.request.contextPath}/picture/pictureDetailManage.do" target="mainFrame">그림리스트 세부조회</a></li>
								</ul>	
						</li>
						<li>
								<div id="left_contents2">
									<table class="table01">
										<tr style="display: block;">
										<td class="td01" style="font-size: 15px;">환경 설정</td>
										</tr>
									</table>
								</div>
								<ul>
									<li><a id="settingManage" href="${pageContext.request.contextPath}/settingManage.do" target="mainFrame">환경 설정</a></li>
								</ul>	
						</li>						
					
					
				</ul>						
			</div>
		</div>
	</div>
</body>
</html>