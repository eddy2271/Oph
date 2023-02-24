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
	
		// 화면 진입 호출부
		$(function(){
			init();
			
			$('#codeTable tbody').on('click', 'tr', function () {
		        if ($(this).hasClass('selected')) {
		            $(this).removeClass('selected');
		        } else {
					tb.$('tr.selected').removeClass('selected');
					$(this).addClass('selected');
					var row_data = $.map(tb.row('.selected').data(), function(item){
						return item;
					});
					alert(row_data[0] +", " +row_data[1]);
		            
// 		            modal("M");
		        }
		    });
			
		});
   		
		function init() {
			// 선택된 구분에 대한 값 세팅
			selectValList();
			search();
			setDataTable();
		}
		
		function search() {
			var params = {
				codeDiv : $("#codeDiv").val(),
				codeVal : $("#codeVal").val(),
				codeValDesc : $("#codeValDesc").val()
			}	
			
			request("./codeList.do",params, function callback(res) {
				if(res.result > 0) {
					setDataTable(res.codeList);
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
		
		function setDataTable(data) {
			$('#codeTable').DataTable().destroy();
			
			tb = $("#codeTable").DataTable({
				dom: 'Bfrtip',
				destroy: true,
				bFilter: false, // 검색란 제어
				processing: true,
				pageLength : 10, // 페이징은 10개씩
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
				$("#headerName").text("코드 등록");
				$("#modal").show();
			} else if(type == "D") { // 닫기
				$("#headerName").text("");
				$("#modal").hide();
				
				// modal 안의 모든 input 값 초기화
				$("#modal").find('input[type=text]').each(function() {
					$(this).val("");
				});
				
				search();
			}
		}
		
		// 선택된 코브구분에 따른 코드 값 세팅
		function selectValList() {
			$("#codeVal").empty();
			
			request("./codeValList.do",{codeDiv : $("#codeDiv").val()}, function callback(res) {
				if(res.result > 0) {
					if(res.valList.length > 0) {
						var option = '<option value="">코드 값 선택</option>';
						for(var i=0; i<res.valList.length; i++) {
							option += '<option value="'+res.valList[i].CODE_VAL+'">'+res.valList[i].CODE_VAL_DESC+'</option>'
						}
						$("#codeVal").append(option);
					}
				} else {
					alert(res.message);
				}
			},
			function error(request,status) {
				alert(status);
			});
		}
		
		function modalClose() {
			modal("D");
		}
    </script>
    
<body> 
	<div class="wrap">
		<div class="title_box">
			<h1>공통코드관리</h1>
			<p>홈 > 공통코드관리</p>
		</div>
		<div class="search_box">
			<p>검색조건 총 (<span id="rowCount">0</span>개)</p>
			<ul>
				<li>
					<select name="codeDiv" id="codeDiv" onchange="selectValList()">
						<c:if test="${!empty divList }">
							<c:forEach items="${divList }" var="divList" varStatus="status">
								<option value="${divList.CODE_DIV }">${divList.CODE_DIV_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
					<select name="codeVal" id="codeVal">
					</select>
				</li>
				<li>
					<input class="search_text" name="codeValDesc" id="codeValDesc" type="text" placeholder="코드 설명">
				</li>
			</ul>
			<button onclick="search()">검색</button>
		</div>
	</div>
	<table id="codeTable" class="table is-striped" style="width: 100%">
		<thead>
			<tr>
				<th>
					<div>코드 구분</div>
				</th>
				<th>
					<div>코드 값</div>
				</th>
				<th>
					<div>코드 설명</div>
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
	    				<th>코드 구분</th>
	    				<td><input type="text" id="codeDiv" name="codeDiv" class="inputFull"/></td>
	    				<th>코드 구분 설명</th>
	    				<td><input type="text" id="codeDivDesc" name="codeDivDesc" class="inputFull"/></td>
	    			</tr>
	    			<tr>
	    				<th>코드 값</th>
	    				<td><input type="text" id="codeVal" name="codeVal" class="inputFull"/></td>
	    				<th>코드 값 설명</th>
	    				<td><input type="text" id="codeValDesc" name="codeValDesc" class="inputFull"/></td>
	    			</tr>
	    		</table>
	    	</div>
	    	<div class="modal-last">
		    	<button type="button" onclick="dataAdd()" class="w-btn saveBtn">코드 등록</button>
		    </div>
	    </div>
	    <div class="modal_layer"></div>
	</div>
	
</body>
</html>