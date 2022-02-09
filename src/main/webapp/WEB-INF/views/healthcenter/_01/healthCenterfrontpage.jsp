<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登入前頁面喔</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<!-- Font Awesome icons (free version) 要改根目錄-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<!-- Favicon-->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
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


<style>
.w3-sidebar a {
	font-family: "Roboto", sans-serif;
}

body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}

.flo {
	margin-top: 200px;
	margin-left: 400px;
}

.mathead {
	padding-top: 10.5rem;
	padding-bottom: 6rem;
	text-align: center;
	color: #fff;
	background-image: url("${pageContext.request.contextPath}/images/header-bg.jpg");
	background-repeat: no-repeat;
	background-attachment: scroll;
	background-position: center center;
	background-size: cover;
}
</style>

</head>
<body>
<body class="w3-content" style="max-width: 4000px" >

	<!-- Sidebar/menu -->
<%@include file="../../navigation.jsp"%>

		<nav class="w3-sidebar w3-collapse "
		style="z-index: 3; width: 250px; background: rgba(0, 0, 0, 0.0);"
		id="mySidebar">
		<div class="w3-container w3-display-container w3-padding-16">
			<i onclick="w3_close()"
				class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>

		</div>
		<div class="w3-padding-64 w3-large w3-text-grey"
			style="font-weight: bold;margin-top: 100px;">

			<a onclick="myAccFunc()" href="javascript:void(0)"
				class="w3-button w3-block  w3-left-align" id="myBtn"
				style="background: rgba(0, 0, 0, 0.0);"> 功能專區 
				<i	class="fa fa-caret-down"></i>
			</a>
		
			<div id="demoAcc"
				class="w3-bar-block w3-hide w3-padding-large w3-medium w3-show">
				<a href="<c:url value='/healthCenter' />" class="w3-bar-item w3-button">更新資料</a>
				<a href="<c:url value="/healthCenter/record2/"/>" class="w3-bar-item w3-button">食品中心</a>
				<a href="<c:url value='/healthCenter/foods' />" class="w3-bar-item w3-button">食品分析</a>
				<a href="<c:url value='/healthCenter/consume/' />" class="w3-bar-item w3-button">運動燃燒的卡路里</a>

			</div>

		</div>
	</nav>

	<header class="mathead asd" style="height: 800px;">
		<div class="container flo">
			<div class="masthead-heading text-uppercase">Keeping health</div>
			<a class="btn btn-primary btn-xl text-uppercase"
				href="<c:url value='/healthCenterfrontpage' />">這是首頁</a>
				
		</div>
	</header>

	<footer class="footer py-4">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-4 text-lg-start">Copyright &copy; Your
					Website 2021</div>
				<div class="col-lg-4 my-3 my-lg-0">
					<a class="btn btn-dark btn-social mx-2" href="#!"><i
						class="fab fa-twitter"></i></a> <a
						class="btn btn-dark btn-social mx-2" href="#!"><i
						class="fab fa-facebook-f"></i></a> <a
						class="btn btn-dark btn-social mx-2" href="#!"><i
						class="fab fa-linkedin-in"></i></a>
				</div>
				<div class="col-lg-4 text-lg-end">
					<a class="link-dark text-decoration-none me-3" href="#!">Privacy
						Policy</a> <a class="link-dark text-decoration-none" href="#!">Terms
						of Use</a>
				</div>
			</div>
		</div>
	</footer>

	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script>
		// Accordion 
		function myAccFunc() {
			var x = document.getElementById("demoAcc");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}

		// Click on the "Jeans" link on page load to open the accordion for demo purposes
		document.getElementById("myBtn").click();

		// Open and close sidebar
		function w3_open() {
			document.getElementById("mySidebar").style.display = "block";
			document.getElementById("myOverlay").style.display = "block";
		}

		function w3_close() {
			document.getElementById("mySidebar").style.display = "none";
			document.getElementById("myOverlay").style.display = "none";
		}
	</script>

</body>
</html>