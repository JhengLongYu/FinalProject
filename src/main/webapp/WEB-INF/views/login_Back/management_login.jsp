<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" />
<title>健康運動整合平台 | 後台登入</title>

<!-- 引入jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<!-- 新增css樣式表     -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css//management_login.css">

<!-- 新增fontawsome  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- <script src="https://www.google.com/recaptcha/api.js" async defer></script> -->
<script>
	var hasError = false;
	window.onload = function() {
		var sendData = document.getElementById("sendData");
		sendData.onclick = function() {
			var nameValue = document.getElementById("name").value;
			var passwordValue = document.getElementById("password").value;
			var div1 = document.getElementById('result1c');//帳號跟password
			if ((!nameValue) && (!passwordValue)) {
				setErrorFor(div1, "請輸入帳號及密碼");
			} else if (!nameValue) {
				setErrorFor(div1, "請輸入帳號");
			} else if (!passwordValue) {
				setErrorFor(div1, "請輸入密碼");
			} else {
				div1.innerHTML = "";
			}

			var xhr = new XMLHttpRequest();
			xhr
					.open("POST", "<c:url value='/back/login/checkAccount' />",
							true);
			var jsonManager = {
				"name" : nameValue,
				"password" : passwordValue
			}
			console.log(jsonManager);
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify(jsonManager));
			console.log(JSON.stringify(jsonManager));
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4
						&& (xhr.status == 200 || xhr.status == 201)) {
					result = JSON.parse(xhr.responseText);
					console.log(result);
					var rs = result.mg;

					if (rs != null) {
						if (rs === "false") {
							console.log(result.mg);
							setErrorFor(div1, "帳號或密碼不正確");
						} else if (rs === "wrong password") {
							setErrorFor(div1, "密碼不正確");
						} else if (rs === "no manager") {
							setErrorFor(div1, "帳號不存在");
						}

						else {
							console.log("!!!!!!!!!!!!");
							window.location.href = " <c:url value='/management' />";
						}
					}
				}
			}
		}
	}
	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		hasError = true;
	}
// 	function verify(token) {
// 		console.log(token);
	
// 		// 把 token 送到後端
// 	}

//一鍵登入功能
	function memberlogin(){
		let name = document.getElementById("name");
		let password = document.getElementById("password");
		//帳號
		name.value = "eeit131";
		//密碼
		password.value = "eeit131";
	}
</script>
</head>

<body>
	<div class="bggray">
		<h2 class="logo">Come Better</h2>
		<div class="loginBox">
			<h1 class="title" onclick="memberlogin()">後台登入</h1>
			<div class="inputBox">
				<label for="name" class="label">帳號</label> <input id="name"
					type="text" class="input">
			</div>

			<div class="inputBox">
				<label for="password" class="label">密碼</label> <input id="password"
					type="password" class="input">
			</div>
<!-- 			<div class="g-recaptcha" -->
<!-- 				data-sitekey="6LdJdyIcAAAAAAAF7KBgESmY2r0ph0XmZXP2Bcgi" -->
<!-- 				data-callback="verify"></div> -->

			<div id="result1c" class="resultMsg"></div>
			<button class="loginBtn" id="sendData">登入</button>
		</div>
	</div>
</body>

</html>