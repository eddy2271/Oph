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
					
			        // 상세수정 버튼 클릭 시 이벤트
			    	$("#modalCodeDiv").val(item[0]);
					$("#modalCodeDiv").attr("disabled",true); 
					$("#modalCodeVal").val(item[1]);
					$("#modalCodeVal").attr("disabled",true); 
					$("#modalCodeDivDesc").val(item[2]);
					$("#modalCodeValDesc").val(item[3]);
		            
					$(".modal-last").append('<button type="button" onclick="del()" id="btnDel" class="w-btn saveBtn">코드 삭제</button>');
					
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
			selectValList();
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
				$("#headerName").text("코드 등록");
				$("#btnTxt").text("코드 등록");
				$("#modal").show();
				mode = "C";
			} else if(type == "M") {
				$("#headerName").text("코드 상세/수정");
				$("#btnTxt").text("코드 수정");
				$("#modal").show();
				mode = "M";
			} else if(type == "D") { // 닫기
				$("#headerName").text("");
				$("#modal").hide();
				
				// modal 안의 모든 input 값 초기화
				$("#modal").find('input[type=text]').each(function() {
					$(this).val("");
				});
				$("#modalCodeDiv").removeAttr("disabled"); 
				$("#modalCodeVal").removeAttr("disabled"); 
				
				$("#btnDel").remove();
				
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
		
		// 모달 닫기
		function modalClose() {
			modal("D");
		}
		
		function dataAdd() {
			var params = {
				mode : mode,
				codeDiv : $("#modalCodeDiv").val(),
				codeVal : $("#modalCodeVal").val(),
				codeDivDesc : $("#modalCodeDivDesc").val(),
				codeValDesc : $("#modalCodeValDesc").val()
			}
			
			request("./codeChange.do", params, function callback(res) {
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
    
<body> 
	<div class="wrap">
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
					<select name="userDiv" id="userDiv" onchange="selectValList()">
						<option value="">회원 구분</option>
						<c:if test="${!empty valList }">
							<c:forEach items="${valList }" var="valList" varStatus="status">
								<option value="${valList.CODE_VAL }">${valList.CODE_VAL_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
				</li>
				<li>
					<select name="userSts" id="userSts" onchange="selectValList()">
						<option value="">회원 상태</option>
						<c:if test="${!empty stsList }">
							<c:forEach items="${stsList }" var="stsList" varStatus="status">
								<option value="${stsList.CODE_VAL }">${stsList.CODE_VAL_DESC }</option>
							</c:forEach>
						</c:if>
					</select>
				</li>
			</ul>
			<button onclick="search()">검색</button>
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
	    	<div class="modal-body" style="height:18%">
	    		<div class="body_header">기본 정보</div>
	    		<table class="modal_tbl">
	    			<tr>
	    				<th>코드 구분</th>
	    				<td>
	    					<input type="text" id="modalCodeDiv" name="modalCodeDiv" class="inputFull"/>
	    				</td>
	    				<th>코드 구분 설명</th>
	    				<td>
	    					<input type="text" id="modalCodeDivDesc" name="modalCodeDivDesc" class="inputFull"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>코드 값</th>
	    				<td><input type="text" id="modalCodeVal" name="modalCodeVal" class="inputFull"/></td>
	    				<th>코드 값 설명</th>
	    				<td><input type="text" id="modalCodeValDesc" name="modalCodeValDesc" class="inputFull"/></td>
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