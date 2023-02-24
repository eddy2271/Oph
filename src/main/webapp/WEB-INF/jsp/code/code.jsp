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
		// 화면 진입 호출부
		$(function(){
			init();
		});
   		
		function init() {
			search();
			setDataTable();
		}
		
		function search() {
			
			var codeDiv = $("#codeDiv").val();
			var codeVal = $("#codeVal").val();
			var codeValDesc = $("#codeValDesc").val();
			
			var params = {
				codeDiv : codeDiv,
				codeVal : codeVal,
				codeValDesc : codeValDesc
			}	
			
			request("./codeList.do",params, function callback(res) {
				if(res.result > 0) {
					if(res.codeList.length > 0) {
						setDataTable(res.codeList);
					}
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
		
		function setDataTable(data) {
			alert(JSON.stringify(data));
			$('#codeTable').DataTable();
			
			$("#codeTable").dataTable({
				destroy: true,
				columnDefs: [ { // 요건 컬럼 정의 
					'searchable' : false,
					'orderable' : false,
					'className' : 'dt-body-center chkCenter'
				} ],
				order: [ [ 1, 'asc' ] ],
				data: data,
				columns: [
                    {data: 'CODE_DIV', render: $.fn.dataTable.render.text()}, //코드구분
                    {data: 'CODE_VAL', render: $.fn.dataTable.render.text()}, //코드값
                    {data: 'CODE_VAL_DESC', render: $.fn.dataTable.render.text()}, //코드설명
			  	]
			});
		}
    </script>
    
<body> 
	<div class="wrap">
		<div class="title_box">
			<h1>공통코드관리</h1>
			<p>홈 > 공통코드관리</p>
		</div>
		<div class="search_box">
			<p>검색조건 총 (11개)</p>
			<ul>
				<li>
					<select name="codeDiv" id="codeDiv">
						<c:if test="${!empty divList }">
							<c:forEach items="${divList }" var="divList" varStatus="status">
								<option value="${divList.CODE_DIV }">${divList.CODE_DIV_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
					<select name="codeVal" id="codeVal">
<%-- 						<c:if test="${!empty valList }"> --%>
<%-- 							<c:forEach items="${valList }" var="valList" varStatus="status"> --%>
<%-- 								<option value="${valList.CODE_VAL }">${valList.CODE_VAL_DESC }</option> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
					</select>
				</li>
				<li>
					<input class="search_text" name="codeDesc" id="codeDesc" type="text" placeholder="설명 값">
				</li>
			</ul>
			<button id="search">검색</button>
		</div>
	</div>
	<table id="codeTable" class="table is-striped" style="width: 100%">
		<thead>
			<tr>
				<th>
					<div>코드 구분 값</div>
				</th>
				<th>
					<div>코드 설명</div>
				</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</body>
</html>