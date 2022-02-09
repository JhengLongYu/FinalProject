<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Top navigation-->
<nav
	class="navbar navbar-expand-lg navbar-light bg-light border-bottom "
	style="height: 60px;">
	<div class="container-fluid">
		<c:choose>
			<c:when test="${loginStatus_Manager}">
				<div class="collapse navbar-collapse " id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mt-2 mt-lg-0">
						<li class="nav-item active"><a class="nav-link"
							style="color: #495057; font-weight: bold;"> 管理者 ${manager}
								，您好 </a></li>
						<li class="nav-item active"><a class="nav-link"
							style="color: #495057; font-weight: bold;"
							href="<c:url value='/management' />">回首頁</a></li>
						<li class="nav-item active"><a class="nav-link"
							style="color: #495057; font-weight: bold;"
							href="<c:url value='/back/logout' />"
							onclick="return confirm('請問確認是否要登出?');">登出</a></li>

					</ul>
				</div>
			</c:when>
			<c:otherwise>
				
			<a class="nav-link"
					style="color: #495057;margin-left:1500px; font-weight: bold;"
					href="<c:url value='/backindex' />">登入</a>
			</c:otherwise>
		</c:choose>
<!-- 		<div class="collapse navbar-collapse " id="navbarSupportedContent"> -->
<!-- 			<ul class="navbar-nav ms-auto mt-2 mt-lg-0"> -->
<!-- 				<li class="nav-item active"><a class="nav-link" -->
<%-- 					style="color: #495057; font-weight: bold;"> 管理者 ${manager} ，您好 --%>
<!-- 				</a></li> -->
<!-- 				<li class="nav-item active"><a class="nav-link" -->
<!-- 					style="color: #495057; font-weight: bold;" -->
<%-- 					href="<c:url value='/management' />">回首頁</a></li> --%>
<!-- 				<li class="nav-item active"><a class="nav-link" -->
<!-- 					style="color: #495057; font-weight: bold;" -->
<%-- 					href="<c:url value='/back/logout' />" --%>
<!-- 					onclick="return confirm('請問確認是否要登出?');">登出</a></li> -->

<!-- 			</ul> -->
<!-- 		</div> -->
	</div>
</nav>
