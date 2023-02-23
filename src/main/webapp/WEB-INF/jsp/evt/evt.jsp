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
		</div>
		<table id="example" class="table is-striped" style="width: 100%">
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
			<tbody>
			</tbody>
		</table>
	</body>
	<script>
		$( document ).ready(function() {
			var data = [{"no1": "1",
				"no2": "2",
				"no3": "3",
				"no4": "2",
				"no5": "3",
				"no6": "2",
				"no7": "3",
				"no8": "2",
				"no9": "3",
				"no10": "2",
				"no11": "3",
				"no12": "3",
			}];
			$('#example').DataTable();
			
			$("#example").dataTable({
				destroy: true,
				columnDefs: [ { // 요건 컬럼 정의 
					'targets' : 0, // 맨앞을 설정하겠다.checkbox 넣으려고 비워뒀던 그거
					'searchable' : false,
					'orderable' : false,
					'className' : 'dt-body-center chkCenter'
				} ],
				order: [ [ 1, 'asc' ] ],
				data: data,
				columns: [
					{data: 'no1', render: function(data, type, full, meta) {
						return '<input type="checkbox">';
					}}, //SEQ
                    {data: 'no2', render: $.fn.dataTable.render.text()}, //대금성격
                    {data: 'no3', render: $.fn.dataTable.render.text()}, //공급가액
                    {data: 'no4', render: $.fn.dataTable.render.text()}, //부가가치세액
                    {data: 'no5', render: $.fn.dataTable.render.text()}, //지급금액
                    {data: 'no6', render: $.fn.dataTable.render.text()}, //SEQ
                    {data: 'no7', render: $.fn.dataTable.render.text()}, //대금성격
                    {data: 'no8', render: $.fn.dataTable.render.text()}, //공급가액
                    {data: 'no9', render: $.fn.dataTable.render.text()}, //부가가치세액
                    {data: 'no10', render: $.fn.dataTable.render.text()}, //지급금액
                    {data: 'no11', render: $.fn.dataTable.render.text()}, //부가가치세액
                    {data: 'no12', render: $.fn.dataTable.render.text()}, //지급금액
			  	]
			});
		});
	</script>
</html>