<html>
<head>
<meta http-equiv="p3p" content='CP="CAO DSP AND SO " policyref="/w3c/p3p.xml"' >
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<%@ include file="/WEB-INF/jsp/common.jsp"%>
</head>
  
   <script type="text/javascript">
    
   function enterkey() {
		if (window.event.keyCode == 13) {
	    	// 엔터키가 눌렸을 때
	    	login();
	    }
	}
   
    function login() {
    	if ($("#inputId").val() == '') {
        	alert('로그인할 사용자 아이디를 입력하지 않으셨습니다.\n\n사용자 아이디를 입력하여 주십시요.');
        	$("#inputId").focus();
        	return; 
    	}

    	if ($("#inputPassword").val() == '') {
        	alert('로그인할 사용자 비밀번호를 입력하지 않으셨습니다.\n\n사용자 비밀번호를 입력하여 주십시요.');
        	$("#inputPassword").focus();
        	return;
    	}

    	
    	var params = {
    			userId : $("#inputId").val(),
    			userPw : $("#inputPassword").val()
    	}

		request("./loginUser.do",params,
				function callback(response,status) {
				console.log(response);
					if ("1" == response.result) {
						//저장 후 아래 로직 수행
						location.href = "./evtFrame.do";
					} else {
						alert(response.message);
					}
				},
				function error(request,status) {
					alert(status);
				});
    	
    	
    }
    
    </script>
    
<body> 
<!-- <div class="intro-wrap">
    <div class="wrap-inner">
        <h1 class="logo"></h1>
        <h2 class="title">
            <strong></strong>
        </h2>
        intro-menu-wrap
        <div class="intro-menu-wrap" >
            <div class="left">
                <div class="box">
                    <h3 class="box-tit">LOGIN</h3>
                    
                    <div class="login-wrap">
                    <input type="radio" id="userDiv" name="userDiv">클라이언트 회원</input>
                    <input type="radio" id="userDiv" name="userDiv">파트너사 회원</input>
                        <ul>
                            <li><input id="inputEmail" placeholder="ID" type="text"></li>
                            <li><input id="inputPassword" placeholder="비밀번호" type="password"></li>
                        </ul>
                      
                        <div class="btn">
                            <button onclick="login()">로그인</button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        // intro-menu-wrap

    </div>
</div> -->
  <div class="container">
    <div class="img">
      <img src="${pageContext.request.contextPath}/image/bg.svg">
    </div>
    <div class="login-content">
      <form>
        <h2 class="title">로그인</h2>
<!--        		  <input type="radio" id="userDiv" name="userDiv" value="ATH002" checked> 클라이언트 회원</input> -->
<!--                <input type="radio" id="userDiv" name="userDiv" value="ATH001"> 파트너사 회원</input> -->
              <div class="input-div one">
                 <div class="i">
                    <i class="fas fa-user"></i>
                 </div>
                 <div class="div">
                    <input type="text" placeholder="아이디를 입력하세요." style="font-weight:600" onkeyup="enterkey()" class="input" id="inputId">
                 </div>
              </div>
              <div class="input-div pass">
                 <div class="i"> 
                    <i class="fas fa-lock"></i>
                 </div>
                 <div class="div">
                   
                    <input type="password" placeholder="패스워드를 입력하세요." style="font-weight:600" class="input"  onkeyup="enterkey()" id="inputPassword">
                 </div>
              </div>
              <div onclick="login();" style="padding-top:3.5%;" class="btn">로그인</div>
            </form>
        </div>
    </div>
</body>
</html>