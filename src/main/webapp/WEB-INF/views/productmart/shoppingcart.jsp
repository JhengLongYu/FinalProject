<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>

<style>
html, html a {
	-webkit-font-smoothing: antialiased;
	text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.004);
}

body {
	background-color: #fff;
	color: #666;
	font-family: 'Open Sans', sans-serif;
	font-size: 62.5%;
	margin: 0 auto;
}

a {
	border: 0 none;
	outline: 0;
	text-decoration: none;
}

strong {
	font-weight: bold;
}

p {
	margin: 0.75rem 0 0;
}

h1 {
	font-size: 0.75rem;
	font-weight: normal;
	margin: 0;
	padding: 0;
}

input, button {
	border: 0 none;
	outline: 0 none;
}

button {
	background-color: #666;
	color: #fff;
}

button:hover, button:focus {
	background-color: #555;
}

img, .basket-module, .basket-labels, .basket-product {
	width: 100%;
	align:center;
}

input, button, .basket, .basket-module, .basket-labels, .item, .price,
	.quantity, .subtotal, .basket-product, .product-image, .product-details
	{
	padding:0.5px;
}

.price:before, .subtotal:before, .subtotal-value:before, .total-value:before,
	.promo-value:before {
	content: 'NT$';
	
}

.hide {
	display: none;
}

main {
	clear: both;
	font-size: 0.75rem;
	margin: 0 auto;
	overflow: hidden;
	padding: 1rem 0;
	width: 960px;
}

.basket, aside {
	padding: 0 1rem;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.basket {
	width: 70%;
}

.basket-module {
	color: #111;
}

label {
	display: block;
	margin-bottom: 0.3125rem;
}

.promo-code-field {
	border: 1px solid #ccc;
	padding: 0.5rem;
	text-transform: uppercase;
	transition: all 0.2s linear;
	width: 48%;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-o-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
}

.promo-code-field:hover, .promo-code-field:focus {
	border: 1px solid #999;
}

.promo-code-cta {
	border-radius: 4px;
	font-size: 0.625rem;
	margin-left: 0.625rem;
	padding: 0.6875rem 1.25rem 0.625rem;
}

.basket-labels {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	margin-top: 1.625rem;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

li {
	color: #111;
	display: inline-block;
	padding: 0.625rem 0;
}

th.price:before, th.subtotal:before {
	content: '';
	
}

.item {
	width: 25%;
	font-size:1.5em;
}

.price, .quantity, .subtotal {
	width: 12%;
	font-size:1.1em
	
}

.price-heading{
padding-left: 0rem;
}

.subtotal {
	text-align: center;
}
.quantity {
		padding-left:20px;
}

.quantity1{
padding-left:12px;
}

.remove {
	bottom: 1.125rem;
	float: right;
	position: absolute;
	right: 0;
	text-align: right;
	width: 45%;
}

.remove button {
	background-color: transparent;
	color: #777;
	float: none;
	text-decoration: underline;
	text-transform: uppercase;
}

.item-heading {
	padding-left: 3.488rem;
	font-size : 20px;
/* 	-webkit-box-sizing: border-box; */
/* 	-moz-box-sizing: border-box; */
/* 	box-sizing: border-box; */
}

.basket-product {
	border-bottom: 1px solid #ccc;
	padding: 1rem 0;
	position: relative;
}

.product-image {
	width: 35%;
}

.product-details {
	width: 48%;
	font-size:1.5em;
	
}

.product-frame {
	border: 1px solid #aaa;
}

.product-details {
	padding-left: 3.488rem;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.quantity-field {
	background-color: #ccc;
	border: 1px solid #aaa;
	border-radius: 4px;
	font-size: 0.625rem;
	padding: 2px;
	width: 3.75rem;
}

aside {
	float: right;
	position: relative;
	width: 30%;
}

.summary {
	background-color: #eee;
	border: none;
	padding: 1rem; 	
 	-webkit-box-sizing: border-box; 
 	-moz-box-sizing: border-box; 
 	box-sizing: border-box; 
}

.fixed{
    position: relative;
 	botton: 200;
    left:480px;
  
	width: 420px;

}


.summary-total-items {
	color: #666;
	font-size: 0.875rem;
	text-align: center;
}

.summary-subtotal, .summary-total {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	clear: both;
	margin: 1rem 0;
	overflow: hidden;
	padding: 0.5rem 0;
}

.subtotal-title, .subtotal-value, .total-title, .total-value,
	.promo-title, .promo-value {
	color: #111;
	float: left;
	width: 25%;
	font-size:1.5em;
}

.summary-promo {
	-webkit-transition: all .3s ease;
	-moz-transition: all .3s ease;
	-o-transition: all .3s ease;
	transition: all .3s ease;
}

.promo-title {
	float: left;
	width: 70%;
}

.promo-value {
	color: #8B0000;
	float: left;
	text-align: right;
	width: 30%;
}

.summary-delivery {
	padding-bottom: 3rem;
}

.subtotal-value, .total-value {
	text-align: right;
}

.total-title {
	font-weight: bold;
	text-transform: uppercase;
}

.summary-checkout {
	display: block;
}

.checkout-cta {
	display: white;
	float: none;
	font-size: 0.75rem;
	text-align: center;
	text-transform: uppercase;
	padding: 0.625rem 0;
	width: 100%;
}

.summary-delivery-selection {
	background-color: #ccc;
	border: 1px solid #aaa;
	border-radius: 4px;
	display: block;
	font-size: 0.625rem;
	height: 34px;
	width: 100%;
}

@media screen and (max-width: 640px) {
	aside, .basket, .summary, .item, .remove {
		width: 100%;
	}
	.basket-labels {
		display: none;
	}
	.basket-module {
		margin-bottom: 1rem;
	}
	.item {
		margin-bottom: 1rem;
	}
	.product-image {
		width: 40%;
	}
	.product-details {
		width: 60%;
	}
	.price, .subtotal {
		width: 33%;
	}
	.quantity {
		text-align:center;
		width: 30%;
}
	.quantity-field {
		left: 5px;
	}
	.remove {
		bottom: 0;
		text-align: left;
		margin-top: 0.75rem;
		position: relative;
	}
	.remove button {
		padding: 0;
	}
	.summary {
		margin-top: 1.25rem;
		position: relative;
	}
}

@media screen and (min-width: 641px) and (max-width: 960px) {
	aside {
		padding: 0 1rem 0 0;
	}
	.summary {
		width: 28%;
	}
}

@media screen and (max-width: 960px) {
	main {
		width: 100%;
	}
	.product-details {
		padding: 0 1rem;
	}
}
</style>

<meta charset="UTF-8">
<title>購物車</title>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<script>
let memberId = "${mbid}";
let amountValue = 0;
let seqNo1 = 0;

	function findAll() {
		let cartArea = document.getElementById("cartArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findshoppingcarts/' />" +memberId);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				cartArea.innerHTML = processShoppingCartData(xhr.responseText);
			}
		}
	}
	window.onload = function() {
		let cfmToCheckOut = document.getElementById("cfmToCheckOut");
		let showimg = document.getElementById("showimg");
		loadData();
		cfmToCheckOut.addEventListener('click', checkOut);
		return findAll();
	}
	function loadData(){
		var imageURL = "<c:url value='/getImage' />";
		showimg.src = imageURL + "?mbid=" + memberId;
		showimg.style="";
	}
	function deleteshoppingcartitemData(seqNoValue) {
		if (confirm("請問是否確定刪除?")) {
			let xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/deleteshoppingcartitem/'  />"
					+ seqNoValue;
			console.log(url);
			xhr2.open("DELETE", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let result = JSON.parse(xhr2.responseText);
					if (result.fail) {
						alert("刪除失敗");
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

	function updateqty(id, seqNo) {
		let upd = {
			"seqNo" : seqNo,
			"qty" : id.value
		};

		let xhr3 = new XMLHttpRequest();
		let url = "<c:url value='/updateshoppingcartitem'  />";
		console.log(url);
		xhr3.open("PUT", url);
		xhr3.setRequestHeader("Content-Type", "application/json");
		xhr3.send(JSON.stringify(upd));
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let result = JSON.parse(xhr3.responseText);
			}
		}
	}

	function add(id, seqNo) {
		if (id.value < 99) {
			id.value = parseInt(id.value) + 1
			updateqty(id, seqNo);
			findAll();
		} else {
			alert("您確定要購買這麼多嗎?");
		}
		findAll();
	}

	function minus(id, seqNo) {
		if (id.value > 1) {
			id.value = (parseInt(id.value) - 1);
			updateqty(id, seqNo);
			findAll();
		} else {
			alert("至少購買一件哦！");

		}
		findAll();
	}
	
	function checkOut() {
		console.log(amountValue);
		console.log(seqNo1);
		let xhr4 = new XMLHttpRequest();
		let url4 = "<c:url value='/createOrderWithShoppingCarts'/>";
		let paymentMethod = $('input[name=paymentMethod]:checked').val()
		console.log(paymentMethod);
		let obj = {
				"seqNo":seqNo1,
			"memberId":memberId,
			"totalAmount":amountValue,
			"paymentMethod":paymentMethod
		}
		console.log(obj);
		xhr4.open("POST", url4);
		xhr4.setRequestHeader("Content-Type", "application/json");
		xhr4.send(JSON.stringify(obj));
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				let result4 = JSON.parse(xhr4.responseText);
				if (result4.fail) {
					alert(result4.fail);
				} else if (result4.success) {
					alert(result4.success);
					window.location.href = "<c:url value='/orderManagementByUser'/>";
				}
			}
		}
		
	}

	function processShoppingCartData(jsonString) {
		let shoppingCarts = JSON.parse(jsonString);
		var imageURL = "<c:url value='/product/getPicture'/>";
		var amount = 0;
		var seqNo;
		let segment = "<table class='basket-labels'>";
		segment += ""		
		segment += "<tr><th style='font-size:20px;padding-left:3px'>產品圖片</th><th class='item item-heading'>產品敘述</th><th class='price price-heading' style='font-size:20px';>價格</th><th class='quantity' style='font-size:20px';>數量</th><th class='subtotal' style='font-size:20px';>小計</th></tr>";
		for (let n = 0; n < shoppingCarts.length; n++) {
			let shoppingCart = shoppingCarts[n];

			itemId = shoppingCart.itemId

// 			let linkDelete = "<input type='button'  value='刪除'style='border:none;border-radius:4px;color:white;background-color:#f44336'onclick=deleteshoppingcartitemData("
// 					+ shoppingCart.seqNo + ")>";
//             let linkDelete = "<img src='${pageContext.request.contextPath}/images/trash1.png' style='width:35px;height:35px;' onclick=deleteshoppingcartitemData("
// 				+ shoppingCart.seqNo + ")>";
            let linkDelete = "<i class='fas fa-trash-alt' onclick=deleteshoppingcartitemData("
				+ shoppingCart.seqNo + ") style='width:15px;height:15px'></i>"

			segment += "<tr>";
			segment += "<td><img style= 'width:85px ;height:85px;' "+"src='" + imageURL +"?id="
			+ itemId + "'></td>";
			console.log(imageURL);
			segment += "<td class='product-details'>"+ shoppingCart.description + "</td>";
			segment += "<td class='price'>" + shoppingCart.unitPrice + "</td>";
			let id = "input" + shoppingCart.itemId;
			segment += "<td class='quantity1'>"
					+ "<input onclick=minus("
					+ id
					+ ","
					+ shoppingCart.seqNo
					+ ")  type='button' style='height:29px;width:20px;' value='-' >"
					+ "<input id='"
					+ id
					+ "' style ='height:24px; width:28px; padding-left:10px' type='text' value='"
					+ shoppingCart.qty
					+ "' readonly='true' onchange='setTotal();' >"
					+ "<input onclick=add("
					+ id
					+ ","
					+ shoppingCart.seqNo
					+ ")  type='button' style='height:29px;width:20px;' value='+' >"
					+ "</td>";
			var total = "total" + shoppingCart.itemId;
			segment += "<td id='"+total+"' class='subtotal'>"
					+ shoppingCart.unitPrice * shoppingCart.qty + "</td>";

			// 			segment += "<td>" + shoppingCart.seqNo + "</td>";
			// 			segment += "<td>" + shoppingCart.orderNo + "</td>";
			// 			segment += "<td>" + shoppingCart.itemId + "</td>";

		

			amount += shoppingCart.unitPrice * shoppingCart.qty;
			console.log(amount);
			segment += "<td>" + linkDelete + "</td>";
			segment += "</tr>";
		}
		segment += "</table>";
		segment += "<br>";
		segment += "<br>";
		segment += "<br>";
		segment += "<br>";
		segment += "<br>";
		segment += "<br>";


// 		let gocheck = "<input type='button' value='結帳去' style='width:159px;height:40px;border:2px blue none;background-color:pink;' onclick=checkOut(" + amount + "," + seqNo + ")>";
		let gocheck = "<input type='button' value='結帳去' style='width:212px;height:40px;border:2px blue none;background-color:pink;' data-bs-toggle='modal' data-bs-target='#exampleModal'>";

		segment += "<table class='summary fixed'>";
		segment += "<tr><th class='subtotal-title'>商品總計</th><th class='subtotal-value final-value'> "+amount+"</th></tr>"
		segment += "<tr><th class='subtotal-title'>Free Tax</th><th class='subtotal-value final-value'>0</th></tr>"
		
		segment += "<tr><th class='summary-promo hide'></th></tr>";
		segment += "<tr><th class='promo-title'></th></tr>";
		segment += "<tr><th class='summary-delivery'></th></tr>";
		segment += "<tr><th class='total-title'></th></tr>";
		amountValue = amount;
		seqNo1 = seqNo;
		segment += "<tr><th class='subtotal-title'>總價格</th><th class='subtotal-value' <div class='subtotal-value' id='amount'>"+amount+"</div></th></tr>";
// 		segment += "<tr><th class='summary-checkout'>結帳去</th></tr>";
		segment += "<td>" + gocheck + "</td>";
		segment += "</table>";
		return segment;
	}
</script>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/css/styles2.css"
	rel="stylesheet" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.min.css">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">
</head>
<body id="page-top" style="background-color:#eee;">
	<%@include file="../navigation.jsp"%>
	<div class="navbg"></div>

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
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link"> <img
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
	
	<main>
	<div id='cartArea' align='center' style='height:800px;'></div>
	</main>
	</div>
	

    <!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"> -->
<!--   Launch demo modal -->
<!-- </button> -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">請選擇付款方式 (確認後即產生訂單)</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align:center">
        <label for="cashOnDelivery"> <input type="radio" id="cashOnDelivery"
				name="paymentMethod" value="貨到付款"> 貨到付款
		</label> 
		<label for="paypal"> <input type="radio" id="paypal"
				name="paymentMethod" value="信用卡結帳"> 信用卡結帳
		</label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="cfmToCheckOut">確認</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>