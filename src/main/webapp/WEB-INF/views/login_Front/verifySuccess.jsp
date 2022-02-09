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
<title>健康運動整合平台｜開通成功</title>
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
<script>
	var verifycode = "${verifycode}";

	//console.log(verifycode);
	window.onload = function() {
		var picture = document.getElementById("picture");
		var trueFalse = document.getElementById("trueFalse");
		var xhr = new XMLHttpRequest();//post需要obj物件迴船後端
		let url = "<c:url value='/changeEnabled/' />" + verifycode;

		xhr.open("GET", url, true);

		// 		xhr.setRequestHeader("Content-Type",
		// 				"application/x-www-form-urlencoded");
		xhr.send();

		xhr.onreadystatechange = function() { // 伺服器請求完成
			if (xhr.readyState == 4 && xhr.status == 200) {

				let result = xhr.responseText;
				console.log(trueFalse);

				if (result === "驗證成功") {
					picture.src = "${pageContext.request.contextPath}/images/Completed.png";
					trueFalse.innerHTML = result
							+ "<br>您已經開通"
							+ "<span class='logo' style='color:#222222' value=''>Health</span>"
							+ "帳號";
				} else {
					picture.src = "${pageContext.request.contextPath}/images/Failed.png";
					trueFalse.innerHTML = result + "<br>Oops!您的連結似乎不正確呢";

				}

			}

		}

	}
</script>
</head>
<body id="page-top">
	<form action="" class="form1" style="margin: 0; height: 100vh;">
		<div class="con" style="margin: -7px auto;">
			<img id="picture" src="" alt="" class="sendEmailPng"
				style="width: 300px; margin: 0 auto; display: block;">
			<div style="text-align: center;">

				<span class="logo" id="trueFalse"
					style="color: #222222; font-family: 'Noto Sans TC', sans-serif; text-align: center; font-weight: 500;">
					<span class="logo" style="color: #222222;">Health</span>帳號開通確認中
				</span>
			</div>
			<hr style="opacity: 0.4;">
			<p
				style="text-align: center; color: #696969; margin-top: 5px; letter-spacing: 1px;">
				請回到首頁，享受美好體驗！</p>
			<div style="text-align: center;">
				<a href="${pageContext.request.contextPath}/index" type="submit"
					style="display: inline-block; padding: 10px 50px; text-decoration: none; text-align: center; background-color: #ffd900; color: black; border-radius: 5px; margin: 0 auto;">立即前往</a>
			</div>

		</div>
	</form>
</body>
</html>