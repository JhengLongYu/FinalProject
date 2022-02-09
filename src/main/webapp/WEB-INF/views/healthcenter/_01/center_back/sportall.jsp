<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member.css">
<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- 新增fontawsome  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<link rel='stylesheet'
	href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"
	type="text/css" />
<script
	src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<!-- <script src="https://cdn.datatables.net/1.10.19/js/.dataTables.min.js"></script> -->

<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.onload = function() {
		let del = "${delete}";
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/CenterBack/sports' />");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processMemberData(xhr.responseText);
			}
		}
	}

	function processMemberData(jsonString) {
		console.log(jsonString);
		let sports = JSON.parse(jsonString);
		let segment = "<table border='1' id='example' class='display' width='100%'>";
		segment += "<thead style='background-color: #FFDC35;'><tr style='text-align:center;'><th colspan='10'>運動資料表</th></tr>";
		segment += "<tr><th>ID</th><th>消耗</th><th>項目名</th><th><i class='far fa-trash-alt'></i></th></tr></thead><tbody>";
		$(document).ready(function() {
			$('#example').DataTable();
		});
		for (let n = 0; n < sports.length; n++) {

			let sport = sports[n];
			segment += " <tr>";
			let link = "<a href='"
					+ "<c:url value='/healthCenter/sport/editForm' />?pk="
					+ sport.pk + "'>" + sport.pk + "</a>";
			let link1 = "<a href='"
					+ "<c:url value='/healthCenter/sport/delete' />?pk=" + sport.pk
					+ "' >"
					+ "<i class='far fa-trash-alt' style='color: white;' ></i>"
					+ "</a>";
			if (n == 0) {
				console.log(link);
			}
			segment += "<td>" + link + "</td>";
			segment += "<td>" + sport.consume + "</td>";
			segment += "<td>" + sport.name + "</td>";
			segment += "<td><button class='deletBtn'>" + link1
					+ "</button></td>";
			segment += "</tr>";
		}
		segment += "</tbody></table>";
		return segment;

	}
</script>
</head>
<body>
	<div class="d-flex" id="wrapper">
		<%@include file="../../../mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="../../../mgnavigation.jsp"%>
			<a id="as" class="w3-button  w3-padding-large" href="<c:url value='/CenterBack/sports/save' />"
				style="width: 100px; background-color: #FFDC35; margin-left: 5px; margin-top: 3px;">新增</a>
			<div align='center' id='resultMsg'
				style="height: 18px; font-weight: bold;"></div>
			<div id='dataArea' align='center'></div>
			<div align='center'></div>
		</div>
	</div>
</body>
</html>