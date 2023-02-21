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
	div#header{
	    position:fixed;
	    width:100%;
	    top:0;
	    left:0;
	}

	div#logo{

		float:left;

		width:50%;

		padding:10px 0 0 20px;

	}

	ul.nav{

		float:left;

		list-style:none;

		width:45%;

	}

	ul.nav li{

		float:left;

	}

	ul.nav a{

		line-height:40px;

		color:#FFFFFF;

		padding:0 15px;

		text-decoration: none;

	}

</style>
<body>

    <div class="header-menu" id="divHeader">201Company</div>
	<div id="header">
     <div>
        <ul class="nav">
           <li><a href="#">이벤트관</a></li>
        </ul>

     </div> 

</div>
</body>
</html>