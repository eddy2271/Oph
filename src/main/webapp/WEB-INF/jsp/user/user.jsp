<html>
<head>
<meta http-equiv="p3p" content='CP="CAO DSP AND SO " policyref="/w3c/p3p.xml"' >
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<%@ include file="/WEB-INF/jsp/common.jsp"%>
<link rel="stylesheet" type="text/css" href="css/evt.css" />
<!-- <meta http-equiv="refresh" content="0; url=landing.do"/> -->
</head>
	<script type="text/javascript">
		var tb = "";
		var mode = "";
		var dupCheck = false;
		var pwdCompare = false;
	
		// 화면 진입 호출부
		$(function(){
			init();
			
			$('#userTable tbody').on('click', 'tr', function () {
		        if ($(this).hasClass('selected')) {
		            $(this).removeClass('selected');
		        } else {
					tb.$('tr.selected').removeClass('selected');
					$(this).addClass('selected');
					var item = $.map(tb.row('.selected').data(), function(item){
						return item;
					});
					
					console.log("0"+item[0]);
					console.log("1"+item[1]);
					console.log("2"+item[2]);
					console.log("3"+item[3]);
					console.log("4"+item[4]);
					console.log("5"+item[5]);
					console.log("6"+item[6]);
					console.log("7"+item[7]);
					console.log("8"+item[8]);
					console.log("9"+item[9]);
					console.log("10"+item[10]);
					console.log("11"+item[11]);
					// 회원 ID세팅
					$("#modalUserId").val(item[7]);
					$("#modalUserId").attr("disabled",true); 
					// 회원 명세팅
					$("#modalUserNm").val(item[3]);
					// 비밀번호 세팅
					$("#modalUserPw").val(item[10]);
					// 비밀번호 확인 세팅
					$("#modalUserPwChk").val(item[10]);
					// 구분 세팅
					$("#modalUserDivInput").val(item[6]);
					// 코드세팅
					$("#modalUserCodeValInput").val(item[5]);
					// 휴대폰번호 세팅
					var regExp = /[^0-9]/g;
					var regExp1 = /(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/;
					$("#modalUserPhNum").val(item[2].replace(regExp, "").replace(regExp1, "$1-$2-$3").replace("--", "-"));
					// 회원상태 세팅
					$("#modalUserSts").val(item[8]).prop("selected", true);
					// 이벤트(광고)코드 세팅
					$("#modalUserEvtCode").val(item[11]);
					
					$(".modal-last").append('<button type="button" onclick="del()" id="btnDel" class="w-btn delBtn">회원 삭제</button>');
					// 처음 수정화면 진입시 비밀번호 확인한 것으로 판단
					pwdCompare = true;
		            modal("M");
		        }
		    });
			
		});
   		
		function del() {
			mode = "D";
			dataAdd();
		}
		
		function init() {
			// 선택된 구분에 대한 값 세팅
			search();
			setDataTable();
		}
		
		function search() {
			var params = {
				userId : $("#userId").val(),
				userDiv : $("#userDiv").val(),
				userSts : $("#userSts").val()
			}	
			
			request("./userList.do",params, function callback(res) {
				if(res.result > 0) {
					setDataTable(res.userList);
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
		
		function setDataTable(data) {
			$('#userTable').DataTable().destroy();
			
			tb = $("#userTable").DataTable({
				dom: 'Bfrtip',
				destroy: true,
				bFilter: false, // 검색란 제어
				processing: true,
				pageLength : 10, // 페이징은 10개씩
				columnDefs: [ { // 요건 컬럼 정의 
					'searchable' : false,
					'orderable' : false,
					'className' : 'dt-body-center chkCenter',
					'render' : function(data, type, full, meta) {
						return '<input type="checkbox">';
					}
				} ],
				order: [ [ 1, 'asc' ] ],
				data: data,
				columns: [
                    {data: 'USER_ID', render: $.fn.dataTable.render.text()}, //코드구분
                    {data: 'USER_NM', render: $.fn.dataTable.render.text()}, //코드구분
                    {data: 'USER_DIV_DESC', render: $.fn.dataTable.render.text()}, //코드값
                    {data: 'USER_EVT_CODE', render: $.fn.dataTable.render.text()}, //코드설명
                    {data: 'USER_STS_DESC', render: $.fn.dataTable.render.text()}, //코드설명
                    {data: 'REG_DT', render: $.fn.dataTable.render.text()}, //코드설명
			  	],
			  	buttons: [{
					text: '등록하기',
					className: 'w-btn w-btn-blue',
					action: function(e, dt, node, config) {
						modal("C");
					}
				}]
			});
			// 조회된 count 세팅			
			$("#rowCount").text(tb.page.info().recordsTotal);
			
			tb.rows({selected:true}).data();
		}
		
		function modal(type) {
			if(type == "C") {
				$("#headerName").text("회원 등록");
				$("#btnTxt").text("회원 등록");
				$("#modal").show();
				$("#modalUserDiv").show(); // 회원 구분 선택 selecbox영역 보이기
				$("#modalUserCodeVal").show(); // 회원 코드 선택 selectbox영역 보이기
				$("#evtCodeTr").hide(); // 이벤트(광고) 코드 영역 숨기기
				$("#modalUserDivInput").hide(); // 회원 구분 선택 input영역 숨기기
				$("#modalUserCodeValInput").hide(); // 회원 코드 선택 input영역 숨기기
				$("#modalUserId").attr('class','inputHalf');
				$("#idDupCheck").show();
				mode = "C";
				selectValList();
			} else if(type == "M") {
				$("#headerName").text("회원 상세/수정");
				$("#btnTxt").text("회원 수정");
				$("#modal").show();
				$("#modalUserDiv").hide(); // 회원 구분 선택 selecbox영역 숨기기
				$("#modalUserCodeVal").hide(); // 회원 코드 선택 selectbox영역 숨기기
				$("#evtCodeTr").show(); // 이벤트(광고) 코드 영역 보이기
				$("#modalUserDivInput").show(); // 회원 구분 선택 input영역 보이기
				$("#modalUserCodeValInput").show(); // 회원 코드 선택 input영역 숨기기
				$("#idDupCheck").hide();
				$("#modalUserId").attr('class','inputFull');
				mode = "M";
			} else if(type == "D") { // 닫기
				$("#headerName").text("");
				$("#modal").hide();
				
				// modal 안의 모든 input 값 초기화
				$("#modal").find('input').each(function() {
					$(this).val("");
				});
				
				$("#pwdChkTxt").hide(); 
				
				$("#modalUserId").removeAttr("disabled"); 
				
				$("#btnDel").remove();
				
				search();
			}
		}
		
		// 선택된 코브구분에 따른 코드 값 세팅
		function selectValList() {
			$("#modalUserCodeVal").empty();
			
			var modalUserDiv = $("#modalUserDiv").val();
			
			request("./userValList.do",{userDiv : modalUserDiv}, function callback(res) {
				if(res.result > 0) {
					if(res.valList.length > 0) {
						var option = "";
						for(var i=0; i<res.valList.length; i++) {
							option += '<option value="'+res.valList[i].CODE_VAL+'">'+res.valList[i].CODE_VAL_DESC+'</option>'
						}
						$("#modalUserCodeVal").append(option);
					} else {
						var option = "";
						if(modalUserDiv == "ATH001") { // 파트너등급
							option = '<option value="">등록가능 파트너 코드가 없습니다.</option>';
						} else if(modalUserDiv == "ATH002") { // 클라이언트등급
							option = '<option value="">등록가능 클라이언트 코드가 없습니다.</option>';
						}
						
						$("#modalUserCodeVal").append(option);
					}
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
		// ID 중복체크
		function idDupCheck() {
			var userId = $("#modalUserId").val();
			
			if(userId == "") {
				alert("회원ID를 입력해주세요.");
				return $("#modalUserId").focus();
			}
			
			if(userId.length < 4) {
				alert("최소4자리 이상 입력해주세요.");
				return $("#modalUserId").focus();
			}
			
			request("./idCheck.do", {userId : userId}, function callback(res) {
				if(res.result > 0) {
					alert(res.message);
					$("#modalUserId").val('');
					
					$("#modalUserId").focus();
					dupCheck = false;
					return;
				}  else {
					alert(res.message);
					$("#modalUserNm").focus();
					dupCheck = true;
				}
			},
			function error(request,status) {
				alert(status);
			});		
		}
		
		// 비밀번호 체크
		function pwdCheckOri(v) {
			var modalUserPwChk = $("#modalUserPwChk").val();
			
			if(modalUserPwChk.length > 0) {
				if(modalUserPwChk != v.value) {
					pwdCompare = false;
					$("#pwdChkTxt").text("비밀번호가 일치하지 않습니다.");
				} else {
					pwdCompare = true;
					$("#pwdChkTxt").text("");
				}
			}
		}
		
		// 비밀번호 체크
		function pwdCheck(v) {
			var modalUserPw = $("#modalUserPw").val();
			if(modalUserPw == "") {
				alert("비밀번호 먼저 입력해주세요.");
				return $("#modalUserPw").focus();
			} 
			
			if(modalUserPw != v.value) {
				pwdCompare = false;
				$("#pwdChkTxt").text("비밀번호가 일치하지 않습니다.");
			} else {
				pwdCompare = true;
				$("#pwdChkTxt").text("");
			}
			
		}
		
		// 아이디 특수문자체크
		function idCheck(v) {
			var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\s\#$%&\\\=\(\'\"]/g;
			
			if(regExp.test(v.value)) {
				$("#modalUserId").val(v.value.replace(regExp, ""));
			}
		} 
		
		// 휴대폰번호 '-' 넣기
		function phNumSet(v) {
			var regExp = /[^0-9]/g;
			var regExp1 = /(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/;
			$("#modalUserPhNum").val(v.value.replace(regExp, "").replace(regExp1, "$1-$2-$3").replace("--", "-"));
		}
		
		// 모달 닫기
		function modalClose() {
			modal("D");
		}
		
		function dataAdd() {
			var userId = $("#modalUserId").val();
			var userNm = $("#modalUserNm").val();
			var userPw = $("#modalUserPw").val();
			var userPwChk = $("#modalUserPwChk").val();
			var userDiv = $("#modalUserDiv").val();
			var userCodeVal = $("#modalUserCodeVal").val();
			var userPhNum = $("#modalUserPhNum").val().replaceAll('-', '');
			var userSts = $("#modalUserSts").val();
			
			if(mode == "C") {
				if(userId == "") {
					alert("회원ID 입력해주세요.");
					return $("#modalUserId").focus();
				}
				if(userId.length < 4) {
					alert("최소4자리 이상 입력해주세요.");
					return $("#modalUserId").focus();
				}
				if(!dupCheck){
					alert("ID 중복체크를 진행해주세요.");
					return;
				}
				if(userNm == "") {
					alert("회원명을 입력해주세요.");
					return $("#modalUserNm").focus();
				}
				if(userPw == "") {
					alert("비밀번호를 입력해주세요.");
					return $("#modalUserPw").focus();
				}
				if(userPwChk == "") {
					alert("비밀번호 확인 입력을 해주세요.");
					return $("#modalUserPwChk").focus();
				}
				if(!pwdCompare) {
					alert("패스워드가 일치하지 않습니다.");
					$("#modalUserPwChk").val('');
					return $("#modalUserPwChk").focus();
				}
				if(userDiv == "") {
					alert("회원구분을 선택해주세요.");
					return;
				}
				if(userCodeVal == "") {
					if(userDiv == "ATH001") {
						alert("파트너를 선택해주세요.");
					} else if(userDiv == "ATH002") {
						alert("클라이언트를 선택해주세요.");
					}
					return;
				}
				if(userPhNum == "") {
					alert("휴대폰번호를 입력해주세요.");
					return $("#modalUserPhNum").focus();
				}
				if(userSts == "") {
					alert("회원상태를 선택해주세요.");
					return;
				}
			} else if(mode == "M") {
				if(userNm == "") {
					alert("회원명을 입력해주세요.");
					return $("#modalUserNm").focus();
				}
				if(userPw == "") {
					alert("비밀번호를 입력해주세요.");
					return $("#modalUserPw").focus();
				}
				if(userPwChk == "") {
					alert("비밀번호 확인 입력을 해주세요.");
					return $("#modalUserPwChk").focus();
				}
				if(!pwdCompare) {
					alert("패스워드가 일치하지 않습니다.");
					$("#modalUserPwChk").val('');
					return $("#modalUserPwChk").focus();
				}
				if(userPhNum == "") {
					alert("휴대폰번호를 입력해주세요.");
					return $("#modalUserPhNum").focus();
				}
				if(userSts == "") {
					alert("회원상태를 선택해주세요.");
					return;
				}
			}
			
			var params = {
				mode : mode,
				userId : userId,
				userNm : userNm,
				userPw : userPw,
				userDiv : userDiv,
				userCodeVal : userCodeVal,
				userPhNum : userPhNum,
				userSts : userSts,
				userEvtCode : $("#modalUserEvtCode").val()
			}
			
			request("./userChange.do", params, function callback(res) {
				if(res.result > 0) {
					alert(res.message);
					location.reload();
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});		
		}
    </script>
    
<body class="wrap scrollDiv"> 
	<div>
		<div class="title_box">
			<h1>회원관리</h1>
			<p>홈 > 회원관리</p>
		</div>
		<div class="search_box">
			<p>검색조건 총 (<span id="rowCount">0</span>개)</p>
			<ul>
				<li>
					<input name="userId" id="userId" type="text" placeholder="ID로 검색">
				</li>
				<li>
					<select name="userDiv" id="userDiv">
						<option value="">회원 구분(전체)</option>
						<c:if test="${!empty valList }">
							<c:forEach items="${valList }" var="valList" varStatus="status">
								<option value="${valList.CODE_VAL }">${valList.CODE_VAL_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
				</li>
				<li>
					<select name="userSts" id="userSts">
						<option value="">회원 상태(전체)</option>
						<c:if test="${!empty stsList }">
							<c:forEach items="${stsList }" var="stsList" varStatus="status">
								<option value="${stsList.CODE_VAL }">${stsList.CODE_VAL_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
				</li>
			</ul>
			<button class="search_btn" onclick="search()">검색</button>
		</div>
	</div>
	<table id="userTable" class="table is-striped" style="width: 100%">
		<thead>
			<tr>
				<th>
					<div>회원 ID</div>
				</th>
				<th>
					<div>회원 명</div>
				</th>
				<th>
					<div>회원 구분</div>
				</th>
				<th>
					<div>회원 이벤트(광고) 코드</div>
				</th>
				<th>
					<div>회원 상태</div>
				</th>
				<th>
					<div>회원 등록일</div>
				</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	<!-- modal Layer -->
	<div id="modal">
	    <div class="modal_content">
	    	<div class="modal-header">
	    		<span id="headerName" class="headerName"></span>
	    		<button type="button" onclick="modalClose()" class="close-area">X</button>
	    	</div>
	    	<div class="modal-body">
	    		<div class="body_header">기본 정보</div>
	    		<table class="modal_tbl">
	    			<tr>
	    				<th>회원 ID</th>
	    				<td>
	    					<input type="text" id="modalUserId" name="modalUserId" maxlength="12" class="inputHalf" onkeyup="idCheck(this)" placeholder="영문,영숫자혼합 (4~12자 이내) 특수문자 금지"/>
		    				<button type="button" onclick="idDupCheck()" id="idDupCheck" class="w-btn-1 checkBtn">중복체크</button>
	    				</td>
	    				<th>회원 명</th>
	    				<td>
	    					<input type="text" id="modalUserNm" name="modalUserNm" class="inputFull"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>비밀번호</th>
	    				<td>
	    					<input type="password" id="modalUserPw" name="modalUserPw" maxlength="20" onkeyup="pwdCheckOri(this)" class="inputFull"/>
	    				</td>
	    				<th>비밀번호 확인</th>
	    				<td class="wrapper">
	    					<input type="password" id="modalUserPwChk" name="modalUserPwChk" maxlength="20" onkeyup="pwdCheck(this)" class="inputFull"/>
	    					<span id="pwdChkTxt"></span>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>구분</th>
	    				<td>
							<select name="modalUserDiv" id="modalUserDiv" onchange="selectValList()" class="inputFull">
								<c:if test="${!empty valList }">
									<c:forEach items="${valList }" var="valList" varStatus="status">
										<option value="${valList.CODE_VAL }">${valList.CODE_VAL_DESC }</option>
									</c:forEach>
								</c:if>
							</select>
							<input id="modalUserDivInput" class="inputFull" disabled="disabled"/>
						</td>
	    				<th>코드</th>
	    				<td>
							<select name="modalUserCodeVal" id="modalUserCodeVal" class="inputFull">
							</select>
							<input id="modalUserCodeValInput" class="inputFull" disabled="disabled"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>휴대폰번호</th>
	    				<td>
							<input type="text" id="modalUserPhNum" name="modalUserPhNum" maxlength="13" class="inputFull" onkeyup="phNumSet(this)" placeholder="'-' 없이 입력해주세요."/>
	    				</td>
	    				<th>상태</th>
	    				<td>
							<select name="modalUserSts" id="modalUserSts" class="inputFull">
								<c:if test="${!empty stsList }">
									<c:forEach items="${stsList }" var="stsList" varStatus="status">
										<option value="${stsList.CODE_VAL }">${stsList.CODE_VAL_DESC }</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
	    			</tr>
	    			<tr id="evtCodeTr">
	    				<th>이벤트(광고)코드</th>
	    				<td colspan="3">
							<input type="text" id="modalUserEvtCode" name="modalUserEvtCode" class="inputFull" disabled="disabled"/>
	    				</td>
	    			</tr>
	    		</table>
	    	</div>
	    	<div class="modal-last">
		    	<button type="button" onclick="dataAdd()" id="btnTxt" class="w-btn saveBtn"></button>
		    </div>
	    </div>
	    <div class="modal_layer"></div>
	</div>
	
</body>
</html>