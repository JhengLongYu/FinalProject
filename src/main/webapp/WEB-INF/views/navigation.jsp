<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top"  id="mainNav">
	<div class="container">
		<a class="navbar-brand" href="<c:url value='/index' />">
			<h1 class="logo">Come Better</h1>
		</a>
		<button class="navbar-toggler" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			Menu <i class="fas fa-bars ms-1"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
				                                    
				<li class="nav-item"><a class="nav-link" href="<c:url value='/addMemberForm' />">健康紀錄</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value='/articleForum'/>">論壇專欄</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value='/productmart' />">人氣商品</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value='/consultionPage'/>">線上諮詢</a></li>
				<li class="nav-item"><a class="nav-link">|</a></li>
				
				<c:choose>
					<c:when test="${loginStatus}">
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/memberCenter'/>">會員中心</a></li>
						<li class="nav-item"><a class="nav-link"
							style="color: #ffc800;"> 您好 ${user}</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/logout' />"
							onclick="return confirm('請問確認是否要登出?');">登出</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/login' />">登入</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/register' />">註冊</a></li>
					</c:otherwise>
				</c:choose>
				<li class="nav-item"><a class="nav-link" href="<c:url value='/findAllShoppingCartItem'/>">購物車</a></li>
			</ul>
		</div>
	</div>
</nav>