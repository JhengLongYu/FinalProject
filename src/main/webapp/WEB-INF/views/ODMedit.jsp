<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|編輯講師</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>        
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>

<script>
let sid = "${idid}";
let orderNo  = 0;
window.onload = function() {
	var divResult 			= document.getElementById('resultMsg');
	let orderNo				= document.getElementById('orderNo');
	let memberId 			= document.getElementById("memberId");
	let shippingAddress 	= document.getElementById("shippingAddress");
	let paymentMethod 		= document.getElementById("paymentMethod");
	let createTime 			= document.getElementById("createTime");
	let amount 				= document.getElementById("amount");
	let sendData 			= document.getElementById("sendData");

	let xhr = new XMLHttpRequest();

	xhr.open("GET", "<c:url value='/findOrderNo?orderNo=' />" + sid);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			
			let orderDetails 		= JSON.parse(xhr.responseText);
			console.log(xhr.responseText);
			console.log(orderDetails.memberId);
			memberId.value 			= orderDetails.memberId;
			paymentMethod.value 	= orderDetails.paymentMethod;
			shippingAddress.value 	= orderDetails.shippingAddress;
			amount.value 			= orderDetails.amount;
			orderNo.value			= orderDetails.orderNo;
			createTime.value 		= orderDetails.createTime;
		}
	}
	
	sendData.onclick = function(){
		let memberIdValue 		= document.getElementById("memberId").value;
		let amountValue 		= document.getElementById("amount").value;
		let createTimeValue 		= document.getElementById("createTime").value;
		let shippingAddressValue 	= document.getElementById("shippingAddress").value;
		let orderNoValue		= document.getElementById("orderNo").value;
		let paymentMethodValue		= document.getElementById("paymentMethod").value;

		let obj = {
		   "orderNo": orderNoValue,
		   "memberId": memberIdValue,
		   "amount": amountValue,
		   "createTime": createTimeValue,
		   "shippingAddress": shippingAddressValue,
		   "paymentMethod": paymentMethodValue
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
			window.location.href = "<c:url value='/ordersManagement'/>";
			}
		}
	}
}
</script>
</head>
<body>
	 <div class="d-flex" id="wrapper">
	 
              <%@include file="mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
                <%@include file="mgnavigation.jsp"%>
                <!-- Page content-->
                
                <div class="container-fluid" >
                 
                   <div style='width:800px;margin:10px auto; padding:10px;background-color:white; '>	
                   		<div class="form-group row" style='justify-content:center'>
    						<label for="orderNo" class="col-sm-2 col-form-label">訂單號碼</label>
    						<div class="col-sm-8">
     						 	<input type="text" class="form-control" id="orderNo" disabled="disabled" style='background-color:#FFF8D7'>
    							<span id='result1c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="memberId" class="col-sm-2 col-form-label">會員編號</label>
    						<div class="col-sm-8">
     						 	<input class="form-control" id='memberId' style='background-color:#FFF8D7'></input>
    							<span id='result2c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="createTime" class="col-sm-2 col-form-label">訂單成立時間</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="createTime" disabled="disabled">
    							<span id='result3c' style="margin-top:5px" style="height: 10px;"></span>
    							
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="paymentMethod" class="col-sm-2 col-form-label">付款狀態</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="paymentMethod">
    							<span id='result4c' style="margin-top:5px;height: 10px;" ></span>
    							
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="shippingAddress" class="col-sm-2 col-form-label">出貨地址</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="shippingAddress">
    							<span id='result5c' style="margin-top:5px;height: 10px;" ></span>
    							
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="amount" class="col-sm-2 col-form-label">訂單金額</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="amount">
    							<span id='result6c' style="margin-top:5px;height: 10px;" ></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
  							<div class="col-sm-8" style='margin-left:auto'>
  								<button id='sendData' class="btn btn-success">送出</button>
  								<span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
  							</div>
  						</div>
  					</div>
                   
                   
                </div>
            </div>
        </div>
        
        
        
</body>
</html>