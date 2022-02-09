<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>健康運動整合平台|管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- 新增css樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member_edit.css">

<!-- 編輯程式 -->
<script>
	var hasError = false;

	window.onload = function() {
		let sendData = document.getElementById("sendData");
		sendData.addEventListener('click', checkAndSendData);
		let sendData1 = document.getElementById("sendData1");
		sendData1.addEventListener('mouseover', movein);
		sendData1.addEventListener('mouseout', moveout);
		sendData1.addEventListener('click', SendData1);

	}
	
	function SendData1() {
		
		names.value = "睡覺";
		consume.value = "0.33";
	}
	
	function moveout() {
		sendData1.style.backgroundColor = "rgba(255,255,255,0.2)";
		sendData1.style.color = "rgba(255,255,255,0.2)";
		sendData1.style.border = "2px solid rgba(255,255,255,0.2)";
	}

	function movein() {
		sendData1.style.backgroundColor = "green";

	}


	function checkAndSendData() {
		if (confirm("請問是否確定送出?????")) {
			
		
		hasError = false;
		let consumevalue = document.getElementById("consume").value;
		let namevalue = document.getElementById("names").value;

		var div0 = document.getElementById('result0c');
		var div1 = document.getElementById('result1c');
		
		
		
		if (!consumevalue) {
			setErrorFor(div0,"<i class='fas fa-exclamation-circle'></i> 請輸入卡洛里");
		} else {
			var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
			if (!objRegex.test(consumevalue)) {
				setErrorFor(div0, "卡洛里必須是數值");
			} else {
				if (consumevalue >= 1000) {
					setErrorFor(div0, "這食物到底要多大");
				} else {
					div0.innerHTML = "";
				}
			}
		}
		if (!namevalue) {
			setErrorFor(div1, "<i class='fas fa-exclamation-circle'></i> 請輸入類別");
		} else {
			div1.innerHTML = "";
		}
		let obj = {
			"consume" : consumevalue,
			"name" : namevalue,
		
		}
		
		var xhr1 = new XMLHttpRequest();
		let objs=JSON.stringify(obj);
		let url = "<c:url value='/CenterBack/sportsave/go'  />";
		xhr1.open("POST", url, true);
		xhr1.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
		xhr1.send(objs);
		xhr1.onreadystatechange = function() {
			if (xhr1.readyState == 4
					&& (xhr1.status == 200 || xhr1.status == 201)) {
				let result = xhr1.responseText;
				console.log("result == " + result);
				if(result != ""){
					alert(result);
					window.location.href = "<c:url value='/_01/CenterBack/Allsports' />";
				}	
		}
		
		console.log("確定送出");
		return true;
		}
	}else {
			return false;
		}
}

	function setErrorFor(input, message) {
		//input.innerHTML = "<font color='red' size='-1'>" + message + "</font>";
		input.innerHTML = "<font>" + message + "</font>";
		hasError = true;
	}

</script>
</head>

<body>
	<div class="d-flex" id="wrapper">
		<%@include file="../../../mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="../../../mgnavigation.jsp"%>
			<!-- Page content-->
			<div class="container-fluid">
				<!--請將內容寫在此處-->
				<div class="mbContent">

					<div class="Content">

						<h1>項目新增</h1>
						<div class="inputBox">
							<label for="consume"> 消耗 </label> <input type="text"
								name="consume" id="consume" class="input"> <span
								id="result0c" class="checkTextFalse"></span>
						</div>


						<div class="inputBox">
							<label for="names"> 項目 </label> <input type="text" name="names"
								id="names" class="input"> <span id="result1c"
								class="checkTextFalse"></span>
						</div>

						<button id="sendData" class="sureEditBtn">確認新增</button>

					</div><button id="sendData1"
						style="width: 50px; height: 50px; background-color: rgba(255, 255, 255, 0.2); color: rgba(255, 255, 255, 0.2); border: 2px solid rgba(255, 255, 255, 0.2); border-radius: 10px;">一鍵</button>
				</div>


			</div>
		</div>
	</div>

</body>
</html>