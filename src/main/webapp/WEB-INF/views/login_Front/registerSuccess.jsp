<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>健康運動整合平台｜註冊</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
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
<link href="${pageContext.request.contextPath}/css/register.css"
	rel="stylesheet" />
<!--Boostrap CDN-->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- Font Awesome icons (free version)-->
<!-- <script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script> -->
<!-- Bootstrap core JS-->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script> -->
<!-- Core theme JS-->
<!-- <script src="js/scripts.js"></script> -->
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script></script>
</head>
<body id="page-top">
	<form action="" class="form1" style="margin: 0; height: 100vh;">
		<div class="con" style="margin: -7px auto;">
			<img src="${pageContext.request.contextPath}/images/sendEmail.png"
				alt="sendEmail" class="sendEmailPng"
				style="width: 300px; margin: 0 auto; display: block;">
			<div style="text-align: center;">
				<span class="logo"
					style="color: #222222; font-family: 'Noto Sans TC', sans-serif; text-align: center; font-weight: 500;">
					歡迎您加入</span> <span class="logo" style="color: #222222;">Health</span>
			</div>
			<hr style="opacity: 0.4;">
			<p
				style="text-align: center; color: #696969; margin-bottom: 5px; letter-spacing: 1px;">親愛的${username}您好,<br>已將會員認證信送至</p>
			<div id="sendToMail" style="text-align: center;">
				<span style="color: rgb(187, 144, 25);">${useremail} </span>
			</div>
			<p
				style="text-align: center; color: #696969; margin-top: 5px; letter-spacing: 1px;">
				請於24小時內完成Email驗證，開通會員功能享受美好體驗！</p>
			<div style="text-align: center;">
				<a href="${pageContext.request.contextPath}/index" type="submit"
					style="display: inline-block; padding: 10px 50px; text-decoration: none; text-align: center; background-color: #ffd900; color: black; border-radius: 5px; margin: 0 auto;">確定</a>
			</div>
		</div>
	</form>
</body>
</html>
