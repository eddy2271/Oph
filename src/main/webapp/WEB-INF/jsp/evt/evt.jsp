<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" type="text/css" href="css/datapicker.css" />
		<link rel="stylesheet" type="text/css" href="css/evt.css" />
		<%@ include file="/WEB-INF/jsp/common.jsp"%>
	</head>
	<body>
		<c:choose>
			<c:when test="${userInfo.user_div ne 'ATH002'}">
				<c:set var="auth" value="1" />
				<c:set var="classNm" value="totalLine2" />
				<c:set var="contextPath" value="${pageContext.request.contextPath}" />
			</c:when>
			<c:otherwise>
				<c:set var="auth" value="2" />
				<c:set var="classNm" value="totalLine1" />
			</c:otherwise>
		</c:choose>
		<div class="wrap">
			<div class="title_box">
				<h1>이벤트관리</h1>
				<p>홈 > 이벤트관리</p>
			</div>
			<div class="search_box">
				<p>검색조건 총 (<span id="listCnt"></span>개)</p>
				<ul>
					<c:if test="${auth eq '1'}">
					    <li>
							<select name="partner" id="partner">
								<c:if test="${userInfo.user_div eq 'ATH999'}">
									<option value="">파트너 전체</option>
								</c:if>
								<c:forEach items="${partnerList}" var="partner">
									<option value="${partner.CODE_VAL }">${partner.CODE_VAL_DESC}</option>
								</c:forEach>
							</select>
						</li>
					</c:if>
					<li class="${classNm}">
						<select name="client" id="client">
							<c:if test="${auth eq '1'}">
								<option value="">클라이언트 전체</option>
							</c:if>
							<c:forEach items="${clientList}" var="client">
								<option value="${client.CODE_VAL }">${client.CODE_VAL_DESC}</option>
							</c:forEach>
						</select>
					</li>
					<li>
						<input type="text" id="startDate" autocomplete="off" placeholder="시작일 선택" />
					</li>
					<li>
						<input type="text" id="endDate" autocomplete="off" placeholder="종료일 선택" />
					</li>
					<li>
						<select name="rev" id="rev">
							<option value="">예약현황 전체</option>
							<c:forEach items="${revList}" var="rev">
								<option value="${rev.CODE_VAL }">${rev.CODE_VAL_DESC}</option>
							</c:forEach>
						</select>
					</li>
					<li>
						<select name="searchKey" id="searchKey">
							<option value="">선택</option>
							<option value="name">고객명</option>
							<option value="ph">전화번호</option>
							<option value="arNm">지면명</option>
						</select>
					</li>
					<li>
						<input class="search_text" type="text" id="searchText" placeholder="검색어" />
					</li>
				</ul>
				<button class="search_btn">검색</button>
			</div>
			
			<table id="evtTable" class="table is-striped" style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>
							<div>번호</div>
						</th>
						<th>
							<div>클라이언트</div>
						</th>
						<th>
							<div>파트너사</div>
						</th>
						<th>
							<div>고객명</div>
						</th>
						<th>
							<div>나이</div>
						</th>
						<th>
							<div>연락처</div>
						</th>
						<th>
							<div>지면명</div>
						</th>
						<th>
							<div>신청일자</div>
						</th>
						<th>
							<div>설문1</div>
						</th>
						<th>
							<div>설문2</div>
						</th>
						<th>
							<div>메모</div>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<!-- modal Layer -->
		<div id="modal">
		    <div class="modal_content">
		    	<div class="modal-header">
		    		<span id="headerName" class="headerName"></span>
		    		<button type="button" id="modalClose" class="close-area">X</button>
		    	</div>
		    	<div class="modal-body">
		    		<div class="body_header">기본 정보</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>신청일</th>
		    				<td colspan="3"><span id="today"></span></td>
		    			</tr>
		    			<tr>
		    				<th>파트너</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<select name="partnerModal" id="partnerModal" class="inputFull">
											<option value="0">파트너 선택</option>
											<c:forEach items="${partnerList}" var="partner">
												<option value="${partner.CODE_VAL }">${partner.CODE_VAL_DESC }</option>
											</c:forEach>
										</select>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="partnerModal"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th>클라이언트</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<select name="clientModal" id="clientModal" class="inputFull">
											<option value="0">클라이언트 선택</option>
											<c:forEach items="${clientList}" var="client">
												<option value="${client.CODE_VAL }">${client.CODE_VAL_DESC}</option>
											</c:forEach>
										</select>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="clientModal"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    		</table>
		    		<div class="body_header top">개인 정보</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>고객명</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtUserNm" name ="evtUserNm" class="inputFull"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtUserNm"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th>연락처</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtUserPhNum" name ="evtUserPhNum" class="inputFull"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtUserPhNum"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>나이</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtUserAge" name ="evtUserAge" class="inputFull"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtUserAge"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    		</table>
		    		<div class="top">
		    			<div class="body_header divLeft">상담 정보</div>
		    			<c:if test="${userInfo.user_div eq 'ATH999'}">
		    				<button class="divLeft w-btn-2 w-btn-blue" id="addSurvey">설문 추가</button>
			    			<button class="divLeft w-btn-2 w-btn-red marginLeft" id="delSurvey">설문 제거</button>
		    			</c:if>
		    		</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>지면명</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtArNm" name ="evtArNm" class="inputFull"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtArNm"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th>예약현황</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<select name="revModal" id="revModal" class="inputFull">
											<option value="0">예약현황 선택</option>
											<c:forEach items="${revList}" var="rev">
												<option value="${rev.CODE_VAL }">${rev.CODE_VAL_DESC}</option>
											</c:forEach>
										</select>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="revModal"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>설문1</th>
		    				<td>
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey1" name ="evtSurvey1" class="inputFull"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey1"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th class="as2 addSurvey">설문2</th>
		    				<td class="as2 addSurvey">
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey2" name ="evtSurvey2" class="inputFull input2"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey2"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    			<tr class="asTr1 addSurvey">
		    				<th class="as3 addSurvey">설문3</th>
		    				<td class="as3 addSurvey">
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey3" name ="evtSurvey3" class="inputFull input3"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey3"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th class="as4 addSurvey">설문4</th>
		    				<td class="as4 addSurvey">
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey4" name ="evtSurvey4" class="inputFull input4"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey4"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    			<tr class="asTr2 addSurvey">
		    				<th class="as5 addSurvey">설문5</th>
		    				<td class="as5 addSurvey">
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey5" name ="evtSurvey5" class="inputFull input5"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey5"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<th class="as6 addSurvey">설문6</th>
		    				<td class="as6 addSurvey">
		    					<c:choose>
		    						<c:when test="${userInfo.user_div eq 'ATH999'}">
		    							<input type="text" id="evtSurvey6" name ="evtSurvey6" class="inputFull input6"/>
		    						</c:when>
		    						<c:otherwise>
		    							<span id="evtSurvey6"></span>
		    						</c:otherwise>
		    					</c:choose>
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>메모</th>
		    				<td colspan="3"><textarea class="inputFull" id="evtDesc" name ="evtDesc" maxlength="4000"></textarea></td>
		    			</tr>
		    		</table>
		    	</div>
		    	<c:if test="${userInfo.user_div eq 'ATH999'}">
		    		<div class="modal-last">
				    	<button type="button" class="w-btn saveBtn">저장하기</button>
				    </div>
		    	</c:if>
		    </div>
		    <div class="modal_layer"></div>
		</div>
	</body>
	<script>
		var date = new Date();
		var today = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2)  + '-' + ('0' + date.getDate()).slice(-2);
		var evtTable = ""; // 데이터 테이블 변수
		var surveyCnt = 1;
		var selectSeq = "";
		var delList = [];
		
		$(document).ready(function() {
			$("#startDate, #endDate").datepicker({
				dateFormat: 'yy-mm-dd',
				changeYear: true,
				changeMonth: true,
				showMonthAfterYear: true,
				yearSuffix: "년",
				nextText: '>',
				prevText: '<',
				dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
				/*showOn: "button",
				buttonImage: "/image/calImg.png"*/
			});
			
			$("#evtTable").DataTable().destroy(); // 데이터테이블 초기화
			
			// dataTable Setting
			evtTable = $("#evtTable").DataTable({
				ajax: {
					type: 'POST',
	                url: './evtList.do',
	                data: {
	                	partner: function() { return $("#partner option:selected").val() },
	    				client: function() { return $("#client option:selected").val() },
	    				startDate: function() { return $("#startDate").val() },
	    				endDate: function() { return $("#endDate").val() },
	    				searchKey: function() { return $("#searchKey option:selected").val() },
	    				searchText: function() { return $("#searchText").val() },
	    				rev: function() { return $("#rev option:selected").val() }
	                },
	                dataType: "JSON"
	            },
				dom: 'Bfrtip',
				destroy: true,
				bFilter: false, // 검색란 제어
				pageLength : 10, // 페이징은 10개씩
				columnDefs: [{ 
					'targets' : 0,
					'searchable' : false,
					'orderable' : false,
					'className' : 'dt-body-center chkCenter',
					'render' : function(data, type, full, meta) {
						return '<input type="checkbox">';
					}
				}],
				buttons: [
				<c:if test="${userInfo.user_div eq 'ATH999'}">
					{
						text: '추가하기',
						className: 'w-btn w-btn-blue',
						action: function(e, dt, node, config) {
							modalCtrl("C");
						}
					},
					{
						text: '삭제하기',
						className: 'w-btn w-btn-gray',
						action: function(e, dt, node, config) {
							fnRemove();
						}
					},
				</c:if>
				{
					text: '엑셀 다운로드',
					className: 'w-btn w-btn-green',
					action: function(e, dt, node, config) {
						fnExcelDown();
					}
				}],
				columns: [
					{data: ''}, // 체크박스
                    {data: 'NUM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 번호
                    {data: 'EVT_CLNT_NM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 클라이언트
                    {data: 'EVT_PARTNER_NM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 파트너사
                    {data: 'EVT_USER_NM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 고객명
                    {data: 'EVT_USER_AGE', render: $.fn.dataTable.render.text(), className: 'touch'}, // 나이
                    {data: 'EVT_USER_PH_NUM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 연락처
                    {data: 'EVT_AR_NM', render: $.fn.dataTable.render.text(), className: 'touch'}, // 지면명
                    {data: 'REG_DT', render: $.fn.dataTable.render.text(), className: 'touch'}, // 신청일자
                    {data: 'EVT_SURVEY1', render: $.fn.dataTable.render.text(), className: 'touch'}, // 설문1
                    {data: 'EVT_SURVEY2', render: $.fn.dataTable.render.text(), className: 'touch'}, // 설문2
                    {data: 'EVT_DESC', render: $.fn.dataTable.render.text(), className: 'touch'}, // 메모
			  	],
			  	drawCallback: function() {
			  		if($.isFunction(evtTable.data)) {
			  			$("#listCnt").text(evtTable.data().length);
			  		}
			  	}
			});
		});
		
		// validation
		function validation() {
			var msg = "";
			
			if($("#partnerModal option:selected").val() == "0") {
				msg = "파트너를 선택해주세요.";
			} else if($("#clientModal option:selected").val() == "0") {
				msg = "클라이언트를 선택해주세요.";
			} else if($("#evtUserNm").val() == "") {
				msg = "고객명을 입력해주세요.";
			} else if($("#evtUserPhNum").val() == "") {
				msg = "연락처를 입력해주세요.";
			} else if($("#evtUserAge").val() == "") {
				msg = "나이를 입력해주세요.";
			} else if($("#revModal option:selected").val() == "0") {
				msg = "예약현황을 선택해주세요.";
			} else if($("#evtArNm").val() == "") {
				msg = "지면명을 입력해주세요.";
			} else if($("#evtDesc").val() == "") {
				msg = "메모를 입력해주세요.";
			} else { // 설문 입력 체크
				for(var i=1; i<=surveyCnt[2]; i++) {
					if($("#evtSurvey" + i).val() == "") {
						msg = "설문" + i + "를 입력해주세요.";
						i = surveyCnt[2] + 1;
					}
				}
			}
			
			return msg;
		}
		
		// 검색 클릭
		$(".search_btn").on("click", function() {
			evtTable.ajax.reload();
		});
		
		// 삭제하기 버튼 클릭 
		function fnRemove() {
			if(delList.length == 0) {
				alert("선택된 이벤트가 없습니다.");
			} else {
				request("./removeEvt.do", {"delList": delList}, function callback(res) {
					if(res.rsCd != 0) {
						alert(res.rsCd + "건 삭제 완료되었습니다.");
						evtTable.ajax.reload();
					} else {
						alert(res.rsMsg);
					}
				},
				function error(request, status) {
					console.log(status);
					alert("처리 중 문제가 발생하였습니다.");
				});
			}
		}
		
		// 엑셀 다운로드 버튼 클릭
		function fnExcelDown() {
			var param = "partner=" + $("#partner option:selected").val() + "&";
			param += "client=" + $("#client option:selected").val() + "&";
			param += "startDate=" + $("#startDate").val() + "&";
			param += "endDate=" + $("#endDate").val() + "&";
			param += "searchKey=" + $("#searchKey option:selected").val() + "&";
			param += "searchText=" + $("#searchText").val() + "&";
			param += "rev=" + $("#rev option:selected").val() + "&";

			location.href = "./excelDown.do?" + param;
		}
		
		// modal 컨트롤
		function modalCtrl(state) {
			$("#today").text(today);

			if(state == "C") { // 추가
				$("#headerName").text("추가 화면");
				$("#modal").show();
				selectSeq = "";
			} else if(state == "U") { // 수정 & 상세
				$("#headerName").text("상세/수정 화면");
				$("#modal").show();
			} else if(state == "D") { // 닫기
				$("#headerName").text("");
				$("#modal").hide();
				selectSeq = "";
				
				// 설문 영역 초기화
				$(".addSurvey").hide();
				surveyCnt = 1;
				
				// modal 안의 모든 input 값 초기화
				$("#modal").find('input[type=text]').each(function() {
					$(this).val("");
				});
				
				// selectBox 초기화
				$("#partnerModal option:eq(0)").prop("selected", true);
				$("#clientModal option:eq(0)").prop("selected", true);
				$("#revModal option:eq(0)").prop("selected", true);
				
				// 메모란 초기화
				$("#evtDesc").val("")
				
				// 데이터 리로드
				evtTable.ajax.reload();
			}
		}
		
		// 날짜 선택 시
		$("#startDate, #endDate").on("change", function() {
			var startD = new Date($("#startDate").val());
			var endD = new Date($("#endDate").val());

			if(startD != "" && endD != "") {
				if(startD > endD) {
					alert("시작일이 종료일보다 최근일 수 없습니다.");
					$("#startDate").val("");
					$("#endDate").val("");
				}
			}
		});
		
		// modal 닫기
		$("#modalClose").on("click", function() {
			modalCtrl("D");
		});
		
		// 설문 항목 추가
		$("#addSurvey").on("click", function() {
			if(surveyCnt == 6) {
				alert("더 이상 설문을 추가할 수 없습니다.");
				return;
			} else {
				surveyCnt++;
				
				if(surveyCnt < 5 && surveyCnt > 2) {
					$(".asTr1").show();
				} else if(surveyCnt > 4) {
					$(".asTr2").show();
				}
				
				$(".as" + surveyCnt).show();
				$(".input" + surveyCnt).val("");
			}
		});
		
		// 설문 항목 제거
		$("#delSurvey").on("click", function() {
			if(surveyCnt == 1) {
				alert("하나 이상의 설문이 필요합니다.");
				return;
			} else {
				$(".as" + surveyCnt).hide();
				
				if(surveyCnt == 3) {
					$(".asTr1").hide();
				} else if(surveyCnt == 4) {
					$(".asTr2").hide();
				}
				
				surveyCnt--;
			}
		});
		
		// row 선택 시 상세/수정 창 열기
		$("#evtTable").on("click", "tbody tr", function (e) {
			var row = $("#evtTable").DataTable().row($(this)).data();
			selectSeq = row.EVT_SEQ;
			
			// 체크박스 영역 클릭 판단
			if($(e.target).hasClass("touch")) {
				// 데이터 넣기
				<c:choose>
					<c:when test="${userInfo.user_div eq 'ATH999'}">
						$("#partnerModal").val(row.EVT_PARTNER_CODE.substr(0,6)).prop("selected", true);
						$("#clientModal").val(row.EVT_CLNT_CODE.substr(0,6)).prop("selected", true);
						$("#revModal").val(row.EVT_STS_CD).prop("selected", true);
						
						$("#evtUserNm").val(row.EVT_USER_NM);
						$("#evtUserAge").val(row.EVT_USER_AGE);
						$("#evtUserPhNum").val(row.EVT_USER_PH_NUM);
						$("#evtArNm").val(row.EVT_AR_NM);
						
						// 설문항목 데이터 넣기
						$("#evtSurvey1").val(row.EVT_SURVEY1);
						$("#evtSurvey2").val(row.EVT_SURVEY2);
						$("#evtSurvey3").val(row.EVT_SURVEY3);
						$("#evtSurvey4").val(row.EVT_SURVEY4);
						$("#evtSurvey5").val(row.EVT_SURVEY5);
						$("#evtSurvey6").val(row.EVT_SURVEY6);
					</c:when>
					<c:otherwise>
						$("#partnerModal").text(row.EVT_PARTNER_NM);
						$("#clientModal").text(row.EVT_CLNT_NM);
						$("#revModal").text(row.EVT_STS_NM);
						$("#evtUserNm").text(row.EVT_USER_NM);
						$("#evtUserAge").text(row.EVT_USER_AGE);
						$("#evtUserPhNum").text(row.EVT_USER_PH_NUM);
						$("#evtArNm").text(row.EVT_AR_NM);
						$("#evtDesc").text(row.EVT_DESC);
						$("#evtSurvey1").text(row.EVT_SURVEY1);
						$("#evtSurvey2").text(row.EVT_SURVEY2);
						$("#evtSurvey3").text(row.EVT_SURVEY3);
						$("#evtSurvey4").text(row.EVT_SURVEY4);
						$("#evtSurvey5").text(row.EVT_SURVEY5);
						$("#evtSurvey6").text(row.EVT_SURVEY6);
					</c:otherwise>
				</c:choose>
				$("#evtDesc").val(row.EVT_DESC);
				
				surveyCnt = row.SURVEY_CNT;
				
				for(var i=2; i<=surveyCnt; i++) {
					if(i == 3) {
						$(".asTr1").show();
					} else if(i == 5) {
						$(".asTr2").show();
					}
					
					$(".as" + i).show();
				}
				
				// modal Open
				modalCtrl("U");
			} else {
				var chkbox = $(this).find('td:first-child :checkbox');
				
				if(chkbox.hasClass("checked")) { // 체크 된 상태
					chkbox.removeClass("checked");
					chkbox.attr("checked", false);
					
					if(delList.indexOf(row.EVT_SEQ) != -1) delList.pop(row.EVT_SEQ);
				} else { // 체크 해제 상태
					chkbox.addClass("checked");
					chkbox.attr("checked", true);
					
					if(delList.indexOf(row.EVT_SEQ) == -1) delList.push(row.EVT_SEQ);
				}
			}
	    });
		
		// 저장하기
		$(".saveBtn").on("click", function() {
			var msg = validation();
			
			if(msg == "") {
				var param = {
					partnerModal: $("#partnerModal option:selected").val(),
					clientModal: $("#clientModal option:selected").val(),
					evtUserNm: $("#evtUserNm").val(),
					evtUserAge: $("#evtUserAge").val(),
					evtUserPhNum: $("#evtUserPhNum").val(),
					evtArNm: $("#evtArNm").val(),
					revModal: $("#revModal option:selected").val(),
					evtDesc: $("#evtDesc").val(),
					state: $("#headerName").text() == "추가 화면" ? "C" : "U",
					evtSurvey1: "",
					evtSurvey2: "",
					evtSurvey3: "",
					evtSurvey4: "",
					evtSurvey5: "",
					evtSurvey6: "",
				}
				
				for(var i=1; i<=surveyCnt; i++) {
					var survey = $("#evtSurvey" + i).val();
					
					if(i == 1) {
						param.evtSurvey1 = survey;
					} else if(i == 2) {
						param.evtSurvey2 = survey;
					} else if(i == 3) {
						param.evtSurvey3 = survey;
					} else if(i == 4) {
						param.evtSurvey4 = survey;
					} else if(i == 5) {
						param.evtSurvey5 = survey;
					} else if(i == 6) {
						param.evtSurvey6 = survey;
					}
				}
				
				if(param.state == "U") param.evtSeq = selectSeq;
				
				request("./saveEvt.do", param, function callback(res) {
					if(res.rsCd != 0) {
						alert(res.rsCd + "건 저장 완료되었습니다.");
						modalCtrl("D");
						evtTable.ajax.reload();
					} else {
						alert(res.rsMsg);
					}
				},
				function error(request, status) {
					console.log(status);
					alert("처리 중 문제가 발생하였습니다.");
				});
			} else {
				alert(msg);
			}
		});
	</script>
</html>