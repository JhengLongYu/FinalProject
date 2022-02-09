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
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<!-- 會員中心的樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script>
	let mbid = "${mbid}";
	window.onload = function() {
		let showimg = document.getElementById("showimg");
		let collectArea = document.getElementById("collectArea");
		let messageNum = document.getElementById("messageNum");
		let loadAllBtn = document.getElementById("loadAllBtn");
		loadData();
		findMessageData();
	}

	function loadData() {
		let xhr = new XMLHttpRequest();
		let url = "<c:url value='/memberManagement/' />" + mbid;
		xhr.open("GET", url);
		xhr.send();
		xhr.onreadystatechange = function() {
			let imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + mbid;
			showimg.style ="";
		}
	}
	
	//讀取訊息
	function findMessageData() {
		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/article/findCommentByArId'/>?art_user_id=" + mbid;
		xhr2.open("GET", url);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				collectArea.innerHTML = showCommentData(xhr2.responseText);
			}
		}
	}
	
	function showCommentData(jsonString) {
		let comments = JSON.parse(jsonString);
		let segment = "";
		let imageURL = "<c:url value='/getImage' />"
		if(comments.length != 0){
			messageNum.innerHTML = comments.length;
			segment += "<button id='loadAllBtn' class='btn btn-primary' style='position: absolute; top: 57px; left: 855px;' onclick='loadAllMessage()'>全部標示為已讀</button>"
			for (let n = 0; n < comments.length; n++) {
				let comment = comments[n];
				segment += "<div class='card-body' style='padding: 0.5rem;'>";
				segment += "<div class='row g-0 ms-3'>";
				segment += "<img src='" + imageURL + "?mbid=" + comment.user_id + "' style='width:50px; height:50px; border-radius:50%'>";
				segment += "<div class='col-10  ms-2'>";
				segment += "<p class='card-title' style='font-size:16px;margin:0px'><span style='font-weight:bolder; font-size:18px'>"+ comment.mbname +"</span>&nbsp;"+ comment.com_create_time +"&nbsp;在你的文章&nbsp;<a href='<c:url value='/article/articleContent?art_id=" + comment.art_id + "'/>'>" + comment.art_title + "</a>&nbsp;留言</p>";
				segment += "<p class='card-text' style='font-size:16px'>"+ comment.com_content + "</p>";
				segment += "</div></div></div>";
				segment += "<hr style='padding: 0; margin: 0'>";
			}
			return segment;		
		}else{
			segment += "<h3 style='text-align:center;margin-top:10px'>目前無新留言</h3>";
			return segment;
		}
	}
	
	//全部讀取按鈕
	function loadAllMessage(){
		let xhr3 = new XMLHttpRequest();
		let url = "<c:url value='/comment/changeCommentState'/>?art_user_id=" + mbid;
		xhr3.open("GET", url);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				window.location.href = "<c:url value='/articleCenter_editMessage' />";
			}
		}
	}
	
</script>
</head>

<body id="page-top">
	<%@include file="../navigation.jsp"%>

	<!-- Navigation-->

	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img src="${pageContext.request.contextPath}/images/member_0.png" style="display:none"
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>"
				class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>

		<!-- 內容區塊 -->
		<div class="ContentBox" style="position: relative;">

			<div class="switchBtnBox">

				<a href="<c:url value='/articleCenter_editInfo'/>" class="switchBtn ">
					<span class="switchText">已收藏文章 </span>
				</a> 
				<a href="<c:url value='/articleCenter_editPublish'/>" class="switchBtn"> 
					<span class="switchText"> 已發表文章 </span>
				</a>
				<a href="<c:url value='/articleCenter_editMessage'/>" class="switchBtn info_here"> 
					<span class="switchText" style="position:relative"> 訊息通知 <span class="badge bg-secondary rounded-pill" style="font-size:100%;position:absolute;top:-15px" id="messageNum"></span></span>
				</a>
				
			</div>
			<div class="InfoBox" style="padding:0px">
				<div id="collectArea">
				</div>
			</div>
		</div>
	</div>

</body>

</html>