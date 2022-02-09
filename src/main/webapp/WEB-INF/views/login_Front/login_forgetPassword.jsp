<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>健康運動整合平台｜登入</title>
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
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}//css/login.css"
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
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	window.onload = function() {
		var sendData = document.getElementById("sendData");//使用者確認送出欄位
		//console.log(sendData);
		sendData.onclick = function() {
			var emailValue = document.getElementById("mbemail").value;//使用者填寫email欄位
			//console.log(emailValue);
			var div0 = document.getElementById('result0c');//帳號判斷提示位置
			//console.log(div0);
			if (!emailValue) {
				div0.innerHTML = "<font color='red' size='2'>請輸入帳號</font>";
				return;
			} else {
				div0.innerHTML = "";
			}
			if (!IsEmail(emailValue)) {
				setErrorFor(div0,
						"<i class='fas fa-exclamation-circle'></i> 帳號格式不正確");
				return;
			} else {
				div0.innerHTML = "";
			}

			var xhr = new XMLHttpRequest();
			//借用註冊時的checkemail的ajax來判斷email是否已經註冊 ,如果沒註冊過就不發送新密碼
			xhr.open("POST", "<c:url value='/register/checkEmail' />", true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			console.log("mbemail=" + emailValue);
			xhr.send("mbemail=" + emailValue);

			xhr.onreadystatechange = function() { // 伺服器請求完成
				if (xhr.readyState == 4 && xhr.status == 200) {
					var result = JSON.parse(xhr.responseText);

					console.log(result);
					if (result.mbemail.length == 0) {
						message = "<font color='red' size='2'>此帳號尚未註冊</font>";
					} else if (result.mbemail.startsWith("Error")) {
						message = "<font color='red' size='-1'>發生錯誤: 代號"
								+ result.mbemail + "</font>";
					} else {
						//要做的事情放這裡
						sendPasswordEmail(result.mbemail);
						alert("密碼重置信件已成功發送至信箱");
						message = "";
						window.location.href = " <c:url value='/login' />"
					}
					div0.innerHTML = message;
				}
			}

		}

	}

	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		hasError = true;
	}
	function sendPasswordEmail(email) {
		var xhremail = new XMLHttpRequest();
		xhremail.open("POST", "<c:url value='/send/resetPasswordAndSend' />",
				true);
		var mailDetail = {
			"recipient" : email,
			"subject" : "重置會員密碼通知信",
			"message" : "這邊會被controller直接改掉"
		}
		//console.log(mailDetail);
		xhremail.setRequestHeader("Content-Type", "application/json");
		xhremail.send(JSON.stringify(mailDetail));
		xhremail.onreadystatechange = function() {
			if (xhremail.readyState == 4 && xhremail.status == 200) {
				var result = xhremail.responseText;
			}

		}
	}
	function IsEmail(emailValue) {
		//初版
		// var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		//二版 參考https://ithelp.ithome.com.tw/articles/10094951
		var regex = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
		if (!regex.test(emailValue)) {
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body id="page-top">
	<!-- Navigation-->
	<%@include file="../navigation.jsp"%>
<!-- 	<div class="navbg"></div> -->
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="form1">
		<div class="con">
			<h1 class="title">忘記密碼</h1>
			<hr>
			<div
				style="display: flex; align-items: center; justify-content: center; margin: -16px 0 25px 0; padding: 15px 0; background-color: #eee;">
				<i class="fas fa-envelope"
					style="width: 50px; height: 50px; padding: 12px; border-radius: 50%; color: #fff; background-color: #ffd900;"></i>
				<span style="color: #777; font-size: 14px; margin-left: 20px;">請輸入您註冊時填寫的帳號
					<br> 系統將發送重設密碼變更信至您的註冊信箱
				</span>
			</div>
			<label for="mbemail"><b>會員帳號</b></label><span id='result0c'
				style="margin-left: 10px; height: 10px;"></span> <input type="text"
				name="mbemail" id="mbemail" class="form-control"
				placeholder="請輸入您註冊時填寫的帳號" required>
			<hr>
			<button id="sendData" class="registerbtn">確認送出</button>
			<div
				style="text-align: end; margin-top: 15px; font-size: 14px; opacity: 0.75; padding: 0 5px;">
				<a href="<c:url value='/login' />">返回登入</a>
			</div>
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