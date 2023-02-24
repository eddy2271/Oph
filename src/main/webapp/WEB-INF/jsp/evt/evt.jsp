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
		    		<div class="body_header top">상담 정보</div>
		    		<table class="modal_tbl">
		    			<tr>
		    				<th>예약현황</th>
		    				<td><input type="text" class="inputFull"/></td>
		    				<th>메모</th>
		    				<td><input type="text" class="inputFull"/></td>
		    			</tr>
		    			<tr>
		    				<th>설문1</th>
		    				<td><input type="text" class="inputFull"/></td>
		    				<th>설문2</th>
		    				<td><input type="text" class="inputFull"/></td>
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
				evtTable.ajax.reload();
			}
		}
		
		$("#modalClose").on("click", function() {
			modalCtrl("D");
		});
	</script>
</html>