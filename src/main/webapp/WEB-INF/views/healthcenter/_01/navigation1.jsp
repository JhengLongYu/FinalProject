<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="#page-top">
				<h1 class="logo">Health</h1>
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars ms-1"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					
					<li class="nav-item"><a class="nav-link" href="<c:url value='/healthCenterfrontpage'  />">健康紀錄</a></li>
					<li class="nav-item"><a class="nav-link" href="">論壇專欄</a></li>
					<li class="nav-item"><a class="nav-link" href="">人氣商品</a></li>
					<li class="nav-item"><a class="nav-link" href="">線上諮詢</a></li>
					<li class="nav-item"><a class="nav-link">|</a></li>
					
					<c:choose>
						<c:when test="${loginStatus}">
							<li class="nav-item">
							<a class="nav-link" href="accountLogout.controller?" onclick="return confirm('請問確認是否要登出?');">登出</a>
							</li>
							<li class="nav-item">
							<a class="nav-link" style="color: #ffc800;"> 您好 ${user}</a>
							</li>
						</c:when>
						<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="loginPage.controller?">登入</a></li>
						<li class="nav-item"><a class="nav-link" href="registrationPage.controller?">註冊</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>
		<nav class="w3-sidebar w3-collapse "
		style="z-index: 3; width: 250px; background: rgba(0, 0, 0, 0.0);margin-top: 100px;"
		id="mySidebar">
		<div class="w3-container w3-display-container w3-padding-16">
			<i onclick="w3_close()"
				class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>

		</div>
		<div class="w3-padding-64 w3-large w3-text-grey"
			style="font-weight: bold;">
			<a href="<c:url value='/healthCenterfrontpage' />" class="w3-bar-item w3-button">首頁</a>
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