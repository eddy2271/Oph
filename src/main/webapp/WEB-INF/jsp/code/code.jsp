<html>
<head>
<meta http-equiv="p3p" content='CP="CAO DSP AND SO " policyref="/w3c/p3p.xml"' >
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<%@ include file="/WEB-INF/jsp/common.jsp"%>
<!-- <meta http-equiv="refresh" content="0; url=landing.do"/> -->
</head>
  
	<script type="text/javascript">
		// 화면 진입 호출부
		window.onload=function(){
		  init();
		}
   		
		function init() {
			search();
		}
		
		function search() {
			request("./codeList.do",params, function callback(response,status) {
				if ("000" == response.RES_CD) {
					
				} else {
					alert(response.RES_MSG + "(" + response.RES_CD + ")");
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
    </script>
    
<body> 
<div class="intro-wrap">
    <div class="wrap-inner">
        <h1 class="logo"></h1>
        <h2 class="title">
            <strong>공통 코드 관리</strong>
        </h2>
        <!-- intro-menu-wrap -->
        <div class="intro-menu-wrap" >
            <div class="left">
                <div class="box">
                    <h3 class="box-tit">LOGIN</h3>
                    <div class="login-wrap">
                        <ul>
                            <li><input id="inputEmail" placeholder="ID" type="text"></li>
                            <li><input id="inputPassword" placeholder="PASSWORD" type="password"></li>
                        </ul>
                      
                        <div class="btn">
                            <button onclick="login()">로그인</button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <!-- // intro-menu-wrap -->

    </div>
</div>
</body>
</html>