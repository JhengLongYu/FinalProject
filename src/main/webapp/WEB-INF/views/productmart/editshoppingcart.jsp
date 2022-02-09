<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' href="<c:url value='/css/style.css' />"
	type="text/css" />
<title>Insert title here</title>
<script>
	let sseqNo = "${seqNob}";
	let pk = 0;
	window.onload = function() {
		var divResult = document.getElementById('resultMsg');
		let seqNo = document.getElementById("seqNo");
		let orderNo = document.getElementById("orderNo");
		let itemId = document.getElementById("itemId");
		let description = document.getElementById("description");
		let unitPrice = document.getElementById("unitPrice");
		let qty = document.getElementById("qty");
		let editshoppingcartData = document.getElementById("editshoppingcartData");
		

		let xhr = new XMLHttpRequest();

		xhr.open("GET", "<c:url value='/getshoppingcartitem?seqNo=' />" + sseqNo);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {

				let shoppingcart = JSON.parse(xhr.responseText);		
				seqNo.value = shoppingcart.seqNo;
				orderNo.value = shoppingcart.orderNo;
				itemId.value = shoppingcart.itemId;
				description.value = shoppingcart.description;
				unitPrice.value = shoppingcart.unitPrice;
				qty.value = shoppingcart.qty;
			}
		}

		editshoppingcartData.onclick = function() {
			let seqNoValue = document.getElementById("seqNo").value;
			let orderNoValue = document.getElementById("orderNo").value;
			let itemIdValue = document.getElementById("itemId").value;
			let descriptionValue = document.getElementById("description").value;
			let unitPriceValue = document.getElementById("unitPrice").value;
			let qtyValue = document.getElementById("qty").value;
			

			let edit = {
				"seqNo" : seqNoValue,
				"orderNo" : orderNoValue,
				"itemId" : itemIdValue,
				"description" : descriptionValue,
				"unitPrice" : unitPriceValue,
				"qty" : qtyValue
			};


			let xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/updateshoppingcartitem'  />" ;
			console.log(url);
			xhr2.open("PUT", url);
			xhr2.setRequestHeader("Content-Type", "application/json");
			xhr2.send(JSON.stringify(edit));
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let result = JSON.parse(xhr2.responseText);
					if (result.fail) {
						divResult.innerHTML = "<font color='red' >"
								+ result.fail + "</font>";
					} else if (result.success) {
						divResult.innerHTML = "<font color='GREEN'>"
								+ result.success + "</font>";
					}

				}
			}
		}
		
		deleteshoppingcartitemData.onclick = function() {
			let seqNoValue = document.getElementById("seqNo").value;

			console.log(seqNoValue);

			let xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/deleteshoppingcartitem/'  />" +seqNoValue;
			console.log(url);
			xhr2.open("DELETE", url);
			xhr2.setRequestHeader("Content-Type", "application/json");
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let result = JSON.parse(xhr2.responseText);
					if (result.fail) {
						divResult.innerHTML = "<font color='red' >"
								+ result.fail + "</font>";
					} else if (result.success) {
						divResult.innerHTML = "<font color='GREEN'>"
								+ result.success + "</font>";
					}

				}
			}
		}
	}	

	
</script>
<link rel='stylesheet' href="<c:url value='/css/style.css' />"
	type="text/css" />
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<meta charset="UTF-8">
<title>Registration</title>
</head>
<body id="page-top">
<%@include file="../navigation.jsp"%>
<div class="navbg"></div>
	<div align='center'>
		<hr>
		<div id='resultMsg' style="height: 18px; font-weight: bold;"></div>
		<br>
		<fieldset style='display: inline-block; width: 820px;'>
			<legend>修改產品資料</legend>
			<table border='1'>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品編號: <input type="text" name="seqNo"
						id='seqNo' disabled="disabled"><br>
						<div style='font-size: 10pt; text-align: center;'></div>
					</td>
					<td width='200'>
						<div id='result0c' style="height: 10px;"></div>
						<br>
						<div id='result0s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品編號: <input type="text" name="orderNo"
						id='orderNo'><br>
						<div style='font-size: 10pt; text-align: center;'>
							<!--    				<a href='#' id='accountCheck' style='font-size: 10pt;'>檢查帳號</a> -->
						</div>
					</td>
					<td width='200'>
						<div id='result0c' style="height: 10px;"></div>
						<br>
						<div id='result0s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;商品序號: <input type="text" name="itemId"
						id='itemId'><br>
					</td>
					<td width='200' style="vertical-align: top">
						<div id='result1c' style="height: 10px;"></div>
						<br>
						<div id='result1s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品敘述: <input type="text"
						name="description" id="description"><br>
							
					</td>
					<td width='200' style="vertical-align: top">
						<div id='result2c' style="height: 10px;"></div>
						<br>
						<div id='result2s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品單價: <input type="text" name="unitPrice"
						id='unitPrice'>
					</td>
					<td width='200'>
						<div id='result3c' style="height: 10px;"></div>
						<br>
						<div id='result3s' style="height: 10px;"></div>
					</td>
				</tr>
					<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品數量: <input type="text" name="qty"
						id='qty'>
					</td>
					<td width='200'>
						<div id='result3c' style="height: 10px;"></div>
						<br>
						<div id='result3s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='50'>
				    <td colspan='3' align='center'><button id='deleteshoppingcartitemData'>刪除</button></td>
					<td colspan='3' align='center'><button id='editshoppingcartData'>送出</button></td>
				</tr>
			</table>
		</fieldset>
		<hr>
		<p>
			<a href="<c:url value='/findproductForm'  />">回產品列表</a>
		<hr>
	</div>


</body>
</html>