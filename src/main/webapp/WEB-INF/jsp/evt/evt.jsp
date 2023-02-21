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
					<li>
						<select name="" id="">
							<option value="클라이언트 선택">클라이언트 선택</option>
						</select>
					</li>
					<li>
						<select name="" id="">
							<option value="지점선택">지점선택</option>
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
	</body>
</html>