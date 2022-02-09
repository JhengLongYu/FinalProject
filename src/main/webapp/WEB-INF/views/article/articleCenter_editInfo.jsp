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
		let messageNum = document.getElementById("messageNum")
		loadData();
		findCollectData();
		findMessageData();
	}
	
	//個人圖片圖取
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
	
	//收藏文章管理
	function findCollectData() {
		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/collect/findAllCollect'/>?collect_user_id=" + mbid;
		xhr2.open("GET", url);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				collectArea.innerHTML = showCollectData(xhr2.responseText);
			}
		}
	}
	
	function showCollectData(jsonString) {
		let articles = JSON.parse(jsonString);
		let segment = "";
		let imageArticleURL = "<c:url value='/article/getCoverImage' />";
		if(articles.length != 0){
			for (let n = 0; n < articles.length; n++) {
				let article = articles[n];
				segment += "<div class='card-body' style='padding: 0.5rem; position: relative;'>";
				segment += "<div class='row g-0 ms-3 justify-content-around'>";
				segment += "<img src='" + imageArticleURL + "?art_id=" + article.art_id + "' style='width: 200px;height: 105px'>";
				segment += "<div class='col-9 ms-2'>";
				segment += "<a href='<c:url value='/article/articleContent?art_id=" + article.art_id + "'/>'><h5 class='card-title'>" + article.art_title + "</h5></a>";
				segment += "<p class='card-text' style='font-size:16px'>" + article.art_content + "<a href='<c:url value='/article/articleContent?art_id=" + article.art_id + "'/>'>繼續閱讀</a></p>";
				let deletelink = "<button class='btn btn-danger btn-sm' style='position: absolute; top: 75px; left: 790px;' onclick=deleteCollectData(" + article.collect_id + ")>取消收藏</button>";
				segment += deletelink;
				segment += "</div></div></div>";
				segment += "<hr style='padding: 0; margin: 0'>";
			}
			return segment;
		}else{
			segment += "<h3 style='text-align:center;margin:0px'>目前無收藏文章</h3>";
			return segment;
		}
	}
	
	function deleteCollectData(delId) {
		if (confirm("請問是否確定取消收藏?")) {
			let xhr3 = new XMLHttpRequest();
			url = "<c:url value='/collect/delete'/>?collect_id=" + delId;
			xhr3.open("GET", url, true);
			xhr3.send();
			xhr3.onreadystatechange = function() {
				if (xhr3.readyState == 4 && xhr3.status == 200) {
					let delresult = JSON.parse(xhr3.responseText);
					if (delresult.fail) {
						alert("取消失敗");
					} else if (delresult.success) {
						alert("取消成功");
					}
					findCollectData();
				}
			}
		} else {
			return false;
		}
	}
	
	//訊息通知
	function findMessageData() {
		let xhr4 = new XMLHttpRequest();
		let url = "<c:url value='/article/findCommentByArId'/>?art_user_id=" + mbid;
		xhr4.open("GET", url);
		xhr4.send();
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				let comments = JSON.parse(xhr4.responseText);
				let segment = "";
				if(comments.length != 0){
					messageNum.innerHTML = comments.length;
				}
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
		<div class="ContentBox">

			<div class="switchBtnBox">

				<a href="<c:url value='/articleCenter_editInfo'/>" class="switchBtn info_here">
					<span class="switchText">已收藏文章 </span>
				</a> 
				<a href="<c:url value='/articleCenter_editPublish'/>" class="switchBtn"> 
					<span class="switchText"> 已發表文章 </span>
				</a>
				<a href="<c:url value='/articleCenter_editMessage'/>" class="switchBtn"> 
					<span class="switchText" style="position:relative"> 訊息通知 <span class="badge bg-secondary rounded-pill" style="font-size:100%;position:absolute;top:-15px" id="messageNum"></span></span>
				</a>
			</div>
			<div class="InfoBox" style="max-width:1300px;padding:10px">
				<div id="collectArea">
					
				</div>
			</div>
		
		</div>
	</div>

</body>

</html>