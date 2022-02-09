<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>健康運動整合平台 | 會員中心</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<!--Boostrap CDN-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<!-- <script type="text/javascript" -->
<%-- 	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script> --%>
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<!-- 會員中心的樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">
<style>
body {
	color: #566787;
	background: #f5f5f5;
	font-family: 'Varela Round', sans-serif;
	font-size: 13px;
}

.table-responsive {
	margin: 30px 0;
}

.table-wrapper {
	min-width: 1000px;
	background: #fff;
	padding: 20px 25px;
	border-radius: 3px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-wrapper .btn {
	float: right;
	color: #333;
	background-color: #fff;
	border-radius: 3px;
	border: none;
	outline: none !important;
	margin-left: 10px;
}

.table-wrapper .btn:hover {
	color: #333;
	background: #f2f2f2;
}

.table-wrapper .btn.btn-primary {
	color: #fff;
	background: #03A9F4;
}

.table-wrapper .btn.btn-primary:hover {
	background: #03a3e7;
}

.table-title .btn {
	font-size: 13px;
	border: none;
}

.table-title .btn i {
	float: left;
	font-size: 21px;
	margin-right: 5px;
}

.table-title .btn span {
	float: left;
	margin-top: 2px;
}

.table-title {
	color: #fff;
	background: #4b5366;
	padding: 16px 25px;
	margin: -20px -25px 10px;
	border-radius: 3px 3px 0 0;
}

.table-title h2 {
	margin: 5px 0 0;
	font-size: 24px;
}

.show-entries select.form-control {
	width: 60px;
	margin: 0 5px;
}

.table-filter .filter-group {
	float: right;
	margin-left: 15px;
}

.table-filter input, .table-filter select {
	height: 34px;
	border-radius: 3px;
	border-color: #ddd;
	box-shadow: none;
}

.table-filter {
	padding: 5px 0 15px;
	border-bottom: 1px solid #e9e9e9;
	margin-bottom: 5px;
}

.table-filter .btn {
	height: 34px;
}

.table-filter label {
	font-weight: normal;
	margin-left: 10px;
}

.table-filter select, .table-filter input {
	display: inline-block;
	margin-left: 5px;
}

.table-filter input {
	width: 200px;
	display: inline-block;
}

.filter-group select.form-control {
	width: 110px;
}

.filter-icon {
	float: right;
	margin-top: 7px;
}

.filter-icon i {
	font-size: 18px;
	opacity: 0.7;
}

table.table tr th, table.table tr td {
	border-color: #e9e9e9;
	padding: 12px 15px;
	vertical-align: middle;
}

table.table tr th:first-child {
	width: 60px;
}

table.table tr th:last-child {
	width: 80px;
}

table.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fcfcfc;
}

table.table-striped.table-hover tbody tr:hover {
	background: #f5f5f5;
}

table.table th i {
	font-size: 13px;
	margin: 0 5px;
	cursor: pointer;
}

table.table td a {
	font-weight: bold;
	color: #566787;
	display: inline-block;
	text-decoration: none;
}

table.table td a:hover {
	color: #2196F3;
}

table.table td a.view {
	width: 30px;
	height: 30px;
	color: #2196F3;
	border: 2px solid;
	border-radius: 30px;
	text-align: center;
}

table.table td a.view i {
	font-size: 22px;
	margin: 2px 0 0 1px;
}

table.table .avatar {
	border-radius: 50%;
	vertical-align: middle;
	margin-right: 10px;
}

.status {
	font-size: 30px;
	margin: 2px 2px 0 0;
	display: inline-block;
	vertical-align: middle;
	line-height: 10px;
}

.text-success {
	color: #10c469;
}

.text-info {
	color: #62c9e8;
}

.text-warning {
	color: #FFC107;
}

.text-danger {
	color: #ff5b5b;
}

.pagination {
	float: right;
	margin: 0 0 5px;
}

.pagination li a {
	border: none;
	font-size: 13px;
	min-width: 30px;
	min-height: 30px;
	color: #999;
	margin: 0 2px;
	line-height: 30px;
	border-radius: 2px !important;
	text-align: center;
	padding: 0 6px;
}

.pagination li a:hover {
	color: #666;
}

.pagination li.active a {
	background: #03A9F4;
}

.pagination li.active a:hover {
	background: #0397d6;
}

.pagination li.disabled i {
	color: #ccc;
}

.pagination li i {
	font-size: 16px;
	padding-top: 6px
}

.hint-text {
	float: left;
	margin-top: 10px;
	font-size: 13px;
}
</style>
<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
<script>
let memberId = "${mbid}";
let paymentSuccess = "${paymentSuccess}";
let od = "${orderNo}"; 
console.log(memberId);
	function findByMemberId() {
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findOrdersByMemberId?memberId=' />" + memberId);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processOrderData(xhr.responseText);
			}
		}
	}
	
	function paymentComplete(od){
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET", "<c:url value='/paymentComplete?orderNo=' />" + od);
		xhr1.send();
		xhr1.onreadystatechange = function() {
			if (xhr1.readyState == 4 && xhr1.status == 200) {
				console.log(xhr1.responseText);
				alert("付款成功");
			}
		}
	}
	
	window.onload = function() {
		console.log(paymentSuccess);
		let showimg = document.getElementById("showimg");
		loadData();
		if(paymentSuccess === "paymentSuccess"){
			paymentComplete(od);
			console.log("============================");
		}
		window.setTimeout(( () => findByMemberId() ), 500);
	}

	function loadData(){
		var imageURL = "<c:url value='/getImage' />";
		showimg.src = imageURL + "?mbid=" + memberId;
		showimg.style="";
	}
	
	function processOrderData(jsonString) {
		let orders = JSON.parse(jsonString);
		let segment = "<table id='example' class='table table-striped table-hover'>";
		segment += "<thead><tr><th colspan='7'>訂單資料列表</th></tr>";
		segment += "<tr><th>訂單號碼</th><th>訂單成立日期</th><th>會員編號</th><th>總額</th><th>出貨地址</th><th>付款狀態</th><th>明細</th></tr></thead><tbody>";
		$(document).ready(function() {
		    $('#example').DataTable();
		} );
		for (let n = 0; n < orders.length; n++) {
			let order = orders[n];
			linkDetails = "<a href='"
				+ "<c:url value='/showOrderDetailsByOrderNo' />?orderNo="
				+ order.orderNo
				+ "' class='view' title='View Details' data-toggle='tooltip'><i class='material-icons'>"
				+ "&#xE5C8;</i></a>";
			let paymentMethod = order.paymentMethod;
			console.log(linkDetails);
			segment += "<tr>";
			segment += "<td>" + order.orderNo + "</td>";
			segment += "<td>" + order.createTime + "</td>";
			segment += "<td>" + order.memberId + "</td>";
			segment += "<td>" + order.amount + "</td>";
			segment += "<td>" + order.shippingAddress + "</td>";
			if (paymentMethod ==="信用卡結帳") {
				let link = "<c:url value='/paypal/' />" + order.orderNo;
				segment += "<td>" + paymentMethod + "<a href='" + link + "'><img src='${pageContext.request.contextPath}/images/paypal icon.png'><a/></td>";
			} else {
			segment += "<td>" + paymentMethod + "</td>";
			}
			segment += "<td>" + linkDetails + "</td>";
			segment += "</tr>";
		}
		segment += "</tbody></table>";
		return segment;
	}
</script>
</head>

<body id="page-top">
	<%@include file="navigation.jsp"%>

	<!-- Navigation-->

	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img src="${pageContext.request.contextPath}/images/member_0.png"
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>"
				class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>

		<!-- 內容區塊 -->
		<div class="ContentBox">
<!-- 			<div class="table-wrapper"> -->
				<div class="table-title">
					<div class="row">
						<div class="col-sm-4">
							<h2>
								Order <b>Details</b>
							</h2>
						</div>
					</div>
				</div>
				<div id='dataArea'></div>
<!-- 			</div> -->

		</div>

	</div>



	<!-- Footer-->
	<!-- 	<div class="container"> -->
	<!-- 		<div class="row align-items-center"> -->
	<!-- 			<div class="col-lg-4 text-lg-start">Copyright &copy; Your -->
	<!-- 				Website 2021</div> -->
	<!-- 			<div class="col-lg-4 my-3 my-lg-0"> -->
	<!-- 				<a class="btn btn-dark btn-social mx-2" href="#!"><i -->
	<!-- 					class="fab fa-twitter"></i></a> <a class="btn btn-dark btn-social mx-2" -->
	<!-- 					href="#!"><i class="fab fa-facebook-f"></i></a> <a -->
	<!-- 					class="btn btn-dark btn-social mx-2" href="#!"><i -->
	<!-- 					class="fab fa-linkedin-in"></i></a> -->
	<!-- 			</div> -->
	<!-- 			<div class="col-lg-4 text-lg-end"> -->
	<!-- 				<a class="link-dark text-decoration-none me-3" href="#!">Privacy -->
	<!-- 					Policy</a> <a class="link-dark text-decoration-none" href="#!">Terms -->
	<!-- 					of Use</a> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 	</div> -->

</body>

</html>