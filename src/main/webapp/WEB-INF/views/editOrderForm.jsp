<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' href="<c:url value='/css/style.css' />" type="text/css" />
<title>Insert title here</title>
<script>
let sid = "${idid}";
let orderNo  = 0;
window.onload = function() {
	var divResult 	= document.getElementById('resultMsg');
	let orderNo		= document.getElementById('orderNo');
	let memberId 	= document.getElementById("memberId");
	let sendData 	= document.getElementById("sendData");
	let amount 		= document.getElementById("amount");
	let shippingAddress 	= document.getElementById("shippingAddress");
	let itemId 		= document.getElementById("itemId");
	let deleteData 	= document.getElementById("deleteData");

	let xhr = new XMLHttpRequest();

	xhr.open("GET", "<c:url value='/findOrderNo?orderNo=' />" + sid);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			
			let orderDetails 	= JSON.parse(xhr.responseText);
			memberId.value 		= orderDetails.memberId;
			itemId.value 		= orderDetails.itemId;
			shippingAddress.value 			= orderDetails.shippingAddress;
			amount.value 		= orderDetails.amount;
			orderNo.value		= orderDetails.orderNo;
			//orderNo				= orderDetails.orderNo;
		}
	}
	
	sendData.onclick = function(){
		let memberIdValue 		= document.getElementById("memberId").value;
		let amountValue 		= document.getElementById("amount").value;
		let itemIdValue 		= document.getElementById("itemId").value;
		let shippingAddressValue 	= document.getElementById("shippingAddress").value;
		let orderNoValue		= document.getElementById("orderNo").value;

		let obj = {
		   "orderNo": orderNoValue,
		   "memberId": memberIdValue,
		   "amount": amountValue,
		   "itemId": itemIdValue,
		   "shippingAddress": shippingAddressValue
		};
		console.log(orderNo);
		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/updateOrderDetails/' />";
		console.log(url);
		xhr2.open("PUT", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(obj));
		xhr2.onreadystatechange = function(){
			if (xhr2.readyState == 4 && xhr2.status == 200){
				let result 		= JSON.parse(xhr2.responseText);
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
	deleteData.onclick = function(){
		let orderNoValue		= document.getElementById("orderNo").value;

		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/deleteOrderDetails/' />"+orderNoValue;
		console.log(url);
		xhr2.open("DELETE", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send();
		xhr2.onreadystatechange = function(){
			if (xhr2.readyState == 4 && xhr2.status == 200){
				let result 		= JSON.parse(xhr2.responseText);
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
</head>
<body>
<div align='center'>
<h3>修改會員資料</h3>
<hr>
<div id='resultMsg' style="height: 18px; font-weight: bold;"></div>
	<br>
	<fieldset style='display: inline-block; width: 820px;'> 
	<legend>修改下列資料</legend>
	<table border='1'>
	<tr height='60'>
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;訂單號碼: <input type="text" name="orderNo" id='orderNo' disabled="disabled"><br>
		</td>
		<td width='200' style="vertical-align:top">
			<div id='result1c' style="height: 10px;"></div><br>
			<div id='result1s' style="height: 10px;"></div>
		</td>	
	</tr>
	<tr height='60'>
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;會員編號: <input type="text" name="memberId" id='memberId'><br>
			<div style='font-size: 10pt; text-align: center;'>
   				<a href='#' id='CheckMemberId' style='font-size: 10pt;'>檢查帳號</a>
			</div>
		</td>
		<td width='200'>
			<div id='result0c' style="height: 10px;"></div><br>
			<div id='result0s' style="height: 10px;"></div>
		</td>
	</tr>
	<tr height='60'>
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;產品編號: <input type="text" name="itemId" id='itemId'><br>
		</td>
		<td width='200' style="vertical-align:top">
			<div id='result1c' style="height: 10px;"></div><br>
			<div id='result1s' style="height: 10px;"></div>
		</td>	
	</tr>
	<tr height='60'>		
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;總額: <input type="text" name="amount" id='amount'>
		</td>	
		<td width='200'>
			<div id='result3c' style="height: 10px;"></div><br>
			<div id='result3s' style="height: 10px;"></div>			
		</td>	
	</tr>
	<tr height='60'>		
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;出貨地址: <input type="text" name="shippingAddress" id='shippingAddress'>
		</td>	
		<td width='200'>
			<div id='result3c' style="height: 10px;"></div><br>
			<div id='result3s' style="height: 10px;"></div>			
		</td>	
	</tr>
	<tr height='60'>		
		<td width='200'>&nbsp;</td>
		<td width='400'>
			&nbsp;出貨日期: <input type="text" name="shippingDate" id='shippingDate' size='24'>
		</td>	
		<td width='200'>
			<div id='result3c' style="height: 10px;"></div><br>
			<div id='result3s' style="height: 10px;"></div>			
		</td>	
	</tr>
	<tr height='50'>		
		<td colspan='3' align='center'><button id='sendData'>送出</button><button id='deleteData'>刪除</button></td>
	</tr>		
			</table>
		</fieldset>
	<hr>	
	<p>	
	<a href="<c:url value='/index'  />">回前頁</a>
<hr>
</div>


</body>
</html>