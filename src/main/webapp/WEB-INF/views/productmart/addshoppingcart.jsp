<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<script>
	var hasError = false;
	window.onload = function() {


		var addshoppingcartData = document.getElementById("addshoppingcartData");
		addshoppingcartData.onclick = function() {
			hasError = false;
			// 讀取欄位資料	  
			let orderNoValue = document.getElementById("orderNo").value;
			let itemIdValue = document.getElementById("itemId").value;
			let descriptionValue = document.getElementById("description").value;
			let unitPriceValue = document.getElementById("unitPrice").value;
			let qtyValue = document.getElementById("qty").value;
			let divResult = document.getElementById('resultMsg');
			

		
		

		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST", "<c:url value='/addcarts' />", true);
		// 下方為一個Javascript物件
		let jsonShoppingCart = {
			"orderNo" : orderNoValue,
			"itemId" : itemIdValue,
			"description" : descriptionValue,
			"unitPrice" : unitPriceValue,
			"qty" : qtyValue
		}
		xhr1.setRequestHeader("Content-Type", "application/json");
		xhr1.send(JSON.stringify(jsonShoppingCart));

		xhr1.onreadystatechange = function() {
			// 伺服器請求完成
			if (xhr1.readyState == 4
					&& (xhr1.status == 200 || xhr1.status == 201)) {
				result = JSON.parse(xhr1.responseText);
				if (result.fail) {
					alert(result.fail);
					

				} else if (result.success) {
					divResult.innerHTML = "<font color='GREEN'>"
							+ result.success + "</font>";
					div0.innerHTML = "";
					div1.innerHTML = "";
					div2.innerHTML = "";
					div3.innerHTML = "";
				} else {
					if (result.idError) {
						div0.innerHTML = "<font color='green' size='-2'>"
								+ result.idError + "</font>";
					} else {
						div0.innerHTML = "";
					}
					if (result.nameError) {
						div1.innerHTML = "<font color='green' size='-2'>"
								+ result.nameError + "</font>";
					} else {
						div1.innerHTML = "";
					}
					if (result.balanceError) {
						div2.innerHTML = "<font color='green' size='-2'>"
								+ result.balanceError + "</font>";
					} else {
						div2.innerHTML = "";
					}
					if (result.birthdayError) {
						div3.innerHTML = "<font color='green' size='-2'>"
								+ result.birthdayError + "</font>";
					} else {
						div3.innerHTML = "";
					}
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
<title>新增商品</title>
</head>
<body id="page-top">
<%@include file="../navigation.jsp"%>
<div class="navbg"></div>
	<div align='center'>
		<h3>新增產品資料</h3>
		<hr>
		<div id='resultMsg' style="height: 18px; font-weight: bold;"></div>
		<br>
		<fieldset style='display: inline-block; width: 820px;'>
			<legend>新增資料至資料庫</legend>
			<table border='1'>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;產品編號: <input type="text" name="orderNo"
						id='orderNo'><br>
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
						name="description" id='description'><br>
					</td>
					<td width='200' style="vertical-align: top">
						<div id='result2c' style="height: 10px;"></div>
						<br>
						<div id='result2s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='60'>
					<td width='200'>&nbsp;</td>
					<td width='400'>&nbsp;商品價格: <input type="text" name="unitPrice"
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
					<td width='400'>&nbsp;商品數量: <input type="text" name="qty"
						id='qty'>
					</td>
					<td width='200'>
						<div id='result3c' style="height: 10px;"></div>
						<br>
						<div id='result3s' style="height: 10px;"></div>
					</td>
				</tr>
				<tr height='50'>
					<td colspan='3' align='center'><button id='addshoppingcartData'>送出</button></td>
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