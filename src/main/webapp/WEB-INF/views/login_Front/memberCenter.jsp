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
<title>健康運動整合平台 | 會員中心</title>
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
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css" rel="stylesheet" />
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
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<!-- 會員中心的樣式 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css//memberCenter.css">

</head>

<body id="page-top">
<%@include file="../navigation.jsp"%>
	<!-- Navigation-->

	<div class="navbg"></div>

	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mbCenterCardsbg">
		<div class="mbCenterCards">

			<a href="<c:url value='/memberCenter_editInfo'/>" class="linkCard"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-07.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">會員資料</h3>
			</a> <a href="<c:url value='/addMemberForm' />" class="linkCard"> 
			<img src="${pageContext.request.contextPath}/images/memberCenterIcon-08.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">健康紀錄</h3>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="linkCard"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-09.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">文章收藏</h3>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="linkCard"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-10.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">購物車</h3>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="linkCard"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-11.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">訂單查詢</h3>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="linkCard"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-12.png" alt="linkImg"
				class="linkCard_img">
				<h3 class="linkTitle">預約諮詢</h3>
			</a>

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