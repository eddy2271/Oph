<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" type="text/css" href="css/evt.css" />
		<%@ include file="/WEB-INF/jsp/common.jsp"%>
	</head>
	<body>
		<div class="wrap">
			<div class="title_box">
				<h1>이벤트관리</h1>
				<p>홈 > 이벤트관리 > 이벤트관리</p>
			</div>
			<div class="search_box">
				<p>검색조건 총 (11개)</p>
				<ul>
					<li>
						<select name="" id="">
							<option value="파트너 선택">파트너 선택</option>
						</select>
					</li>
					<li class="totalLine">
						<select name="" id="">
							<option value="클라이언트 선택">클라이언트 선택</option>
						</select>
					</li>
					<li>
						<input type="text" value="2022-02-13">
					</li>
					<li>
						<input type="text" value="2022-02-13">
					</li>
					<li>
						<select name="" id="">
							<option value="예약현황 선택"></option>
						</select>
					</li>
					<li>
						<select name="" id="">
							<option value="선택">선택</option>
						</select>
					</li>
					<li>
						<input class="search_text" type="text" placeholder="검색어">
					</li>
				</ul>
				<button>검색</button>
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
		    				<th>지점</th>
		    				<td></td>
		    				<th>신청일</th>
		    				<td></td>
		    			</tr>
		    			<tr>
		    				<th>클라이언트</th>
		    				<td></td>
		    				<th>파트너</th>
		    				<td></td>
		    			</tr>
		    		</table>
		    		<div class="body_header top">개인 정보</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>고객명</th>
		    				<td><input type="text" class="inputFull"/></td>
		    				<th>연락처</th>
		    				<td><input type="text" class="inputFull"/></td>
		    			</tr>
		    			<tr>
		    				<th>나이</th>
		    				<td><input type="text" class="inputFull"/></td>
		    			</tr>
		    		</table>
		    		<div class="top">
		    			<div class="body_header divLeft">상담 정보</div>
			    		<button class="divLeft ctrlBtn" id="addSurvey">add</button>
			    		<button class="divLeft ctrlBtn" id="delSurvey">delete</button>
		    		</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>예약현황</th>
		    				<td><input type="text" class="inputFull"/></td>
		    				<th>메모</th>
		    				<td><input type="text" class="inputFull"/></td>
		    			</tr>
		    			<tr>
		    				<th>지면명</th>
		    				<td><input type="text" class="inputFull"/></td>
		    				<th>설문1</th>
		    				<td><input type="text" class="inputFull"/></td>
		    			</tr>
		    			<tr class="as1 addSurvey">
		    				<th class="as1_1 addSurvey">설문2</th>
		    				<td class="as1_1 addSurvey"><input type="text" class="inputFull input1_1"/></td>
		    				<th class="as1_2 addSurvey">설문3</th>
		    				<td class="as1_2 addSurvey"><input type="text" class="inputFull input1_2"/></td>
		    			</tr>
		    			<tr class="as2 addSurvey">
		    				<th class="as2_1 addSurvey">설문4</th>
		    				<td class="as2_1 addSurvey"><input type="text" class="inputFull input2_1"/></td>
		    				<th class="as2_2 addSurvey">설문5</th>
		    				<td class="as2_2 addSurvey"><input type="text" class="inputFull input2_2"/></td>
		    			</tr>
		    			<tr class="as3 addSurvey">
		    				<th class="as3_1 addSurvey">설문6</th>
		    				<td class="as3_1 addSurvey"><input type="text" class="inputFull input3_1"/></td>
		    			</tr>
		    			<tr>
		    				<th>설명</th>
		    				<td colspan="3"><textarea class="inputFull" maxlength="4000"></textarea></td>
		    			</tr>
		    		</table>
		    	</div>
		    	<div class="modal-last">
			    	<button type="button" id="modalClose" class="w-btn saveBtn">작성완료</button>
			    </div>
		    </div>
		    <div class="modal_layer"></div>
		</div>
	</body>
	<script>
		var evtTable = ""; // 데이터 테이블 변수
		var surveyCnt = [0, 2]; // 추가 설문 항목
		
		$(document).ready(function() {
			var param = {};
			
			$("#evtTable").DataTable().destroy(); // 데이터테이블 초기화
			evtTable = $("#evtTable").DataTable({
				ajax: {
					type: 'POST',
	                url: './evtList.do',
	                data: param,
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
				buttons: [{
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
				{
					text: '엑셀 다운로드',
					className: 'w-btn w-btn-green',
					action: function(e, dt, node, config) {
						fnExcelDown();
					}
				}],
				columns: [
					{data: ''}, // 체크박스
                    {data: 'no2', render: $.fn.dataTable.render.text()}, // 번호
                    {data: 'no3', render: $.fn.dataTable.render.text()}, // 클라이언트
                    {data: 'no4', render: $.fn.dataTable.render.text()}, // 파트너사
                    {data: 'no5', render: $.fn.dataTable.render.text()}, // 고객명
                    {data: 'no6', render: $.fn.dataTable.render.text()}, // 나이
                    {data: 'no7', render: $.fn.dataTable.render.text()}, // 연락처
                    {data: 'no8', render: $.fn.dataTable.render.text()}, // 지면명
                    {data: 'no9', render: $.fn.dataTable.render.text()}, // 신청일자
                    {data: 'no10', render: $.fn.dataTable.render.text()}, // 설문1
                    {data: 'no11', render: $.fn.dataTable.render.text()}, // 설문2
                    {data: 'no12', render: $.fn.dataTable.render.text()}, // 메모
			  	]
			});
		});

		// 추가하기
		function fnAdd() {
			
		}
		
		// 삭제하기 버튼 클릭
		function fnRemove() {
			evtTable.ajax.reload();
		}
		
		// 엑셀 다운로드 버튼 클릭
		function fnExcelDown() {
			evtTable.ajax.reload();
		}
		
		// modal 컨트롤
		function modalCtrl(state) {
			if(state == "C") { // 추가
				$("#headerName").text("추가 화면");
				$("#modal").show();
			} else if(state == "U") { // 수정 & 상세
				$("#headerName").text("상세/수정 화면");
				$("#modal").show();
			} else if(state == "D") { // 닫기
				$("#headerName").text("");
				$("#modal").hide();
				
				// 설문 영역 초기화
				$(".addSurvey").hide();
				surveyCnt = [0, 2];
				
				// modal 안의 모든 input 값 초기화
				$("#modal").find('input[type=text]').each(function() {
					$(this).val("");
				});
				
				// 데이터 리로드
				evtTable.ajax.reload();
			}
		}
		
		// modal 닫기
		$("#modalClose").on("click", function() {
			modalCtrl("D");
		});
		
		// 설문 항목 추가
		$("#addSurvey").on("click", function() {
			if(surveyCnt[0] == 3 && surveyCnt[1] == 1) {
				alert("더 이상 설문을 추가할 수 없습니다.");
				return;
			} else {
				surveyCnt[1]++;
				
				if(surveyCnt[1] == 3) {
					surveyCnt[0]++;
					surveyCnt[1] = 1;
					$(".as" + surveyCnt[0]).show();
				}
				
				$(".as" + surveyCnt[0] + "_" + surveyCnt[1]).show();
				$(".input" + surveyCnt[0] + "_" + surveyCnt[1]).val("");
			}
		});
		
		// 설문 항목 제거
		$("#delSurvey").on("click", function() {
			if(surveyCnt[0] == 0 && surveyCnt[1] == 2) {
				alert("하나 이상의 설문이 필요합니다.");
				return;
			} else {
				$(".as" + surveyCnt[0] + "_" + surveyCnt[1]).hide();
				$(".input" + surveyCnt[0] + "_" + surveyCnt[1]).val("");
				
				surveyCnt[1]--;
				
				if(surveyCnt[1] == 0) {
					$(".as" + surveyCnt[0]).hide();
					surveyCnt[1] = 2;
					surveyCnt[0]--;
				}
			}
		});
	</script>
</html>