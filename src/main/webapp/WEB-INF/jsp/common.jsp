<%@ page pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>투엘컴퍼니</title>

<fmt:formatDate value="${now}" pattern="yyyyMMddHHmmss" var="now"/>
<jsp:useBean id="now" class="java.util.Date"/>
<!-- tag lib -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- CSS Style Sheet import -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dataTable_1.css?${now}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dataTable_2.css?${now}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css?${now}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css?${now}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/datapicker.css?${now}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/evt.css?${now}" />

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTables.checkboxes.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTables.cellEdit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/datatables.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTable/dataTable_1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTable/dataTable_2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTable/dataTable_button_1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTable/dataTable_button_2.js"></script>
<link rel="stylesheet" type="text/css" href="/css/style.css?${now}" />
