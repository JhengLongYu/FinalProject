<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8">
<title>健康運動整合平台|管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script type="text/javascript" -->
<%-- 	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script> --%>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
	function findAll() {
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findAllOrders' />");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processOrderData(xhr.responseText);
			}
		}
	}
	
	window.onload = function() {
		return findAll();
	}

	function processOrderData(jsonString) {
		let orders = JSON.parse(jsonString);
		let segment = "<table id='example' class='table table-hover'>";
		segment += "<thead><tr><th colspan='7'>訂單資料列表</th></tr>";
		segment += "<tr><th>訂單號碼</th><th>訂單成立日期</th><th>會員編號</th><th>總額</th><th>出貨地址</th><th>付款狀態</th><th>後臺操作</th></tr></thead></tbody>";
		$(document).ready(function() {
		    $('#example').DataTable();
		} );
		for (let n = 0; n < orders.length; n++) {
			let order = orders[n];
			segment += "<tr>";

			let linkEdit = "<a href='"
					+ "<c:url value='/editForm' />?orderNo="
					+ order.orderNo
					+ "'>"
					+ "<button style='border:none;border-radius:4px;color:white;background-color:#008CBA'>"
					+ "修改" + "</button></a>";

			let linkDelete = "<input type='button' value='刪除' style='border:none;border-radius:4px;color:white;background-color:#f44336' onclick=deleteData("
					+ order.orderNo + ")>";

			
			if (n == 0) {
				console.log(linkDelete);
			}
			segment += "<td>" + order.orderNo + "</td>";
			segment += "<td>" + order.createTime + "</td>";
			segment += "<td>" + order.memberId + "</td>";
			segment += "<td>" + order.amount + "</td>";
			segment += "<td>" + order.shippingAddress + "</td>";
			segment += "<td>" + order.paymentMethod + "</td>";
			segment += "<td>" + linkEdit + linkDelete + "</td>";
			segment += "</tr>";
		}
		segment += "</tbody></table>";
		return segment;
	}
	
	function deleteData(orderNoValue) {
		if (confirm("請問是否確定刪除?")) {
			let xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/deleteOrderDetails/'/>" + orderNoValue;
			xhr2.open("DELETE", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let result = JSON.parse(xhr2.responseText);
					if (result.fail) {
						alert("刪除失敗成功");
					} else if (result.success) {
						alert("刪除成功");
					}
					findAll();
				}

			}
		} else {
			return false;
		}

	}
</script>
</head>
<body>
	<div class="d-flex" id="wrapper">
		<%@include file="mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="mgnavigation.jsp"%>
			<!-- Page content-->

			<div class="container-fluid">
				<div id='dataArea'></div>
			</div>
		</div>
	</div>
</body>
</html>