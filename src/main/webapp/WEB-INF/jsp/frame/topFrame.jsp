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
		
		parent.mainFrame.location = "${pageContext.request.contextPath}/evtFrame.do";
	});
	
	function setLogOut() 
	{
		if(confirm('로그아웃 하시겠습니까?')){
			parent.mainFrame.location = '${pageContext.request.contextPath}/logout.do?';
		}
	} 
</script>

</head>
<style>
	*{
		list-style: none;
		text-decoration: none;
		color: inherit;
		margin: 0;
		padding: 0;
	}
	.wrap{
		width: 100%;
		height: 500px;
		margin: 0 auto;
		text-align: center; 
	}
	.fixed_menu {
		width: 100%;
		height: 60px;
		background-color: #fff;
		opacity: 0.8;
	}
	.fixed_menu li{
		display: inline-block;
		margin: 20px;
	}
	.content{
		width: 100%;
		height: 800px;
		background-image: url('img1.png');
		background-size: cover;
		background-repeat: no-repeat;
	}
	p {color: #fff; font-size: 14px; padding-top: 100px;}
</style>
<body>

    <div class="header-menu" id="divHeader">201Company</div>
	<div id="header" >
     <div>
        <ul class="nav">
           <li><a href="#">이벤트관</a></li>
        </ul>

     </div> 

</div>
</body>
</html>