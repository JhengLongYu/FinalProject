<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>健康運動整合平台|論壇</title>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- <script -->
<!-- 	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script> -->
<%-- <script src="${pageContext.request.contextPath}/js/scripts.js"></script> --%>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>

<!-- <link rel="stylesheet" -->
<%-- 	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' /> --%>
<!-- <script type="text/javascript" -->
<%-- 	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script> --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

<style>
.img_head {
	position: relative;
	width: 35px;
	height: 35px;
	/*padding-top: 5px;*/
	border-radius: 2px;
}

.custom-width {
	max-width: 1320px;
}

.m_over {
	margin-left: 175px;
}

.tag_img {
	padding: 4px 12px;
	border-radius: 99em;
}

a {
	text-decoration:none
}


</style>

<script>
	let mbId="${mbid}";
	window.onload = function() {
		findAllArticle();
		findAllTagOption();
		findAllCarousel();
		document.getElementById("publishArticlebtn").addEventListener("click",publishArticle);
		
		
		
		function publishArticle(){
			if(mbId==""){
	     		alert("請先登入帳號");
	     		window.location.href = "<c:url value='/login' />";
	     	 }else{
	     		window.location.href = "<c:url value='/article/publishArticle' />";
	     	 }
		}
		
	}
	
	//顯示全部文章
	function findAllArticle() {
		let xhr3 = new XMLHttpRequest();
		xhr3.open("GET", "<c:url value='/articleForum/findAll'/>", true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				articleData.innerHTML = showArticleData(xhr3.responseText);
			}
		}
	}
		
	//文章管理-Tag選單
	function findAllTagOption() { 
		let selectElement = document.getElementById("articleTag");
		let articleTagData = [];
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/tag/findAll'/>", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let tags = JSON.parse(xhr.responseText);
				for (let i = 0; i < tags.length; i++) {
					let tag = [ tags[i].tag_name, tags[i].tag_id ];
					articleTagData.push(tag);
				}
				for (let i = 0; i < articleTagData.length; i++) {
					let option = new Option(articleTagData[i][0],
							articleTagData[i][1]);
					selectElement.options[selectElement.options.length] = option;
				}
			}
		}

		selectElement.onchange = function() {
			let tagId = selectElement.options[selectElement.selectedIndex].value;
			let xhr2 = new XMLHttpRequest();
			url = "<c:url value='/article/findArticleByTag/forum'/>?tag_id=" + tagId;
			xhr2.open("GET", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					articleData.innerHTML = showArticleData(xhr2.responseText);
				}
			}
		}
	}
		
	function showArticleData(jsonString){
		let articles = JSON.parse(jsonString);
		if(articles.length!=0){
			let imageURL = "<c:url value='/getImage' />";
			let imageArticleURL = "<c:url value='/article/getCoverImage' />";
			let segment = "";
			for (let n = 0; n < articles.length; n++) {
				let article = articles[n];
				segment += "<div class='card mb-2'>";
				segment += "<div class='card-header bg-transparent border-bottom-0'>";
				segment += "<img src='" + imageURL + "?mbid=" + article.member.mbid + "' class='img_head'>";
				segment += "<span class='ms-3'>" + article.member.mbname +"</span>";
				segment += "<span class='mx-3 tag_img' style='background-color: rgba(238, 232, 232, 0.918);'>&nbsp;" + article.tag_name + "&nbsp;</span>";
				segment += "<span class='mx-3'>發表時間:" + article.art_create_time + "</span>";
				segment += "<span class='mx-3'>最新回覆:" + article.com_create_time + "</span></div>";
				segment += "<div class='row g-0 ms-3'>";
				segment += "<img src='" + imageArticleURL + "?art_id=" + article.art_id + "' style='width: 200px;height: 100px'>";
				segment += "<div class='col-9 ms-2'>";
				segment += "<a href='<c:url value='/article/articleContent?art_id=" + article.art_id + "'/>'><h5 class='card-title'>" + article.art_title + "</h5></a>";
				segment += "<p class='card-text' style='font-size:16px'>" + article.art_content + "<a href='<c:url value='/article/articleContent?art_id=" + article.art_id + "'/>'>繼續閱讀</a></p></div>";
				segment += "<div class='card-footer bg-transparent border-top-0'><div class='row'>";
				segment += "<div class='col-2'><i class='bi bi-chat-dots'></i>&nbsp;" + article.art_com_num + "</div>";
				segment += "<div class='col-2'><i class='bi bi-heart-fill' style='color:red'></i>&nbsp;" + article.art_collect_num + "</div>";
				segment += "<div class='col-2'><i class='bi bi-hand-thumbs-up' style='color:blue'></i>&nbsp;" + article.art_like_num + "</div>";
				segment += "<div class='col-2'><i class='bi bi-eye-fill'></i>&nbsp;" + article.art_view + "</div>";
				segment += "</div></div></div></div>";
			}
		return segment;
		}else{
			let segment = "";
			segment += "<h2 style='text-align:center; margin-top:20px'>查無相關文章</h2>";
			return segment;
		}
		
	}
		
	function keyup(val){
		let xhr4 = new XMLHttpRequest();
		url = "<c:url value='/articleForum/searchKeyword'/>?keyword=" + val;
		xhr4.open("GET", url, true);
		xhr4.send();
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				articleData.innerHTML = showArticleData(xhr4.responseText);
			}
		}
	}
		
	function findAllCarousel(){
		let carouselArea = document.getElementById("carouselArea");
		let xhr5 = new XMLHttpRequest();
		xhr5.open("GET", "<c:url value='/carousel/findAll'/>", true);
		xhr5.send();
		xhr5.onreadystatechange = function() {
			if (xhr5.readyState == 4 && xhr5.status == 200) {
				carouselArea.innerHTML = showCarouselData(xhr5.responseText);
			}
		}
	}
		
	function showCarouselData(jsonString){
		let carousels = JSON.parse(jsonString);
		let imageArticleURL = "<c:url value='/article/getCoverImage' />";
		let segment = "";
		if(carousels.length != 0){
		segment += "<div id='carouselExampleCaptions' class='carousel slide' data-bs-ride='carousel' style='heigh:300px'>";
		segment += "<div class='carousel-indicators'>";
			for (let n = 0; n < carousels.length; n++) {
				if(n == 0){
					segment += "<button type='button' data-bs-target='#carouselExampleCaptions' data-bs-slide-to='" + n +"' class='active' aria-current='true' aria-label='Slide " + (n+1) +"'></button>";
				}else{
					segment += "<button type='button' data-bs-target='#carouselExampleCaptions' data-bs-slide-to='" + n +"' aria-label='Slide " + (n+1) +"'></button>";
				}
			}
			segment += "</div>";
			segment += "<div class='carousel-inner' style='background:black'>";
			for (let n = 0; n < carousels.length; n++) {
				let carousel = carousels[n];
				if(n == 0){
					segment += "<div class='carousel-item active'>";
					segment += "<a href='<c:url value='/article/articleContent?art_id=" + carousel.art_id + "'/>'><img src='" + imageArticleURL + "?art_id=" + carousel.art_id + "' class='d-block w-100' style='width: 800px;height: 330px; opacity:0.5'></a>";
					segment += "<div class='carousel-caption d-none d-md-block'>";
					segment += "<h2>"+ carousel.art_title +"</h2>";
					segment += "</div></div>";
				}else{
					segment += "<div class='carousel-item'>";
					segment += "<a href='<c:url value='/article/articleContent?art_id=" + carousel.art_id + "'/>'><img src='" + imageArticleURL + "?art_id=" + carousel.art_id + "' class='d-block w-100' style='width: 800px;height: 330px; opacity:0.5'></a>";
					segment += "<div class='carousel-caption d-none d-md-block'>";
					segment += "<h2>"+ carousel.art_title +"</h2>";
					segment += "</div></div>";
				}
			}
			segment += "</div>";
			segment += "<button class='carousel-control-prev' type='button' data-bs-target='#carouselExampleCaptions' data-bs-slide='prev'>";
			segment += "<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
			segment += "<span class='visually-hidden'>Previous</span></button>";
			segment += "<button class='carousel-control-next' type='button' data-bs-target='#carouselExampleCaptions' data-bs-slide='next'>";
			segment += "<span class='carousel-control-next-icon' aria-hidden='true'></span>";
			segment += "<span class='visually-hidden'>Next</span></button></div>";
			return segment;
		}else{
			segment += "<div id='carouselExampleSlidesOnly' class='carousel slide' data-bs-ride='carousel' style='heigh:300px'>";
			segment += "<div class='carousel-inner'>";
			segment += "<div class='carousel-item active'>";
			segment += "<img src='${pageContext.request.contextPath}/images/noImage.jpg' class='d-block w-100' style='width: 800px;height: 330px; opacity:0.5'></div>";
			segment += "</div></div>";
			return segment;
		}
	}
		
	function autoCarousel(){
 		var myCarousel = document.querySelector('#carouselExampleCaptions')
 		var carousel = new bootstrap.Carousel(myCarousel, {
 		  interval: 3000,     //設定輪播下一張的秒數 3秒
 		  wrap: true		  //設定自動輪播
 		});
	};
	
	$(function (){
		setTimeout('autoCarousel()', 500); //延遲0.5秒 載入
	})
		
</script>
</head>
<body id="page-top" style="background-color: #ecf0f5">
<%-- 	<%@include file="../navigation.jsp"%> --%>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color:black;padding:24px 16px" id="mainNav">
		<div class="container" style="margin:0px 173.6px;padding:0px 15px">
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

	<div class="navbg"></div>
	<div class="container bg-body custom-width">
		<div id="carouselArea" class="pt-2">
		</div>
	
		<div class="row justify-content-around pt-2">
			<div class="col-9">
				<div class="row mb-2">
				
					<!-- 類別選單 -->
					<div class="col-4 d-flex">
						<select  class="form-select" id='articleTag' style="width:165px"></select>
					</div>
					<!-- 類別搜尋 -->
					<div class="col-8 d-flex">
						<input type="text" class="border rounded" style="width:400px" placeholder="請輸入搜尋關鍵字" id="searchData" onkeyup="keyup(this.value)">
						<span class="input-group-text border-0" id="searchbar">
   							<i class="fas fa-search"></i>
  						</span>						
					</div>
				</div>
				<div id=articleData></div>
			</div>


			<!-- 右邊區域 -->
			<div class="col-3">
				<div class="row mb-2">
					<div class="col-6 d-flex">
						<button class="btn btn-success" id="publishArticlebtn">發表文章</button>
					</div>
				</div>
				<div class="card mb-3">
					<div class="card-header">瀏覽數最高文章</div>
					<ul class="list-group list-group-flush">
						<c:forEach var='view' items='${artOrderByView}'>
							<li class="list-group-item">
							    <a href="<c:url value='/article/articleContent?art_id=${view.art_id}'/>">${view.art_title}</a>
							</li>
					    </c:forEach>
					</ul>
				</div>
				<div class="card mb-3">
					<div class="card-header">按讚數最高</div>
						 <ul class="list-group list-group-flush">
						    <c:forEach var='like' items='${artOrderByLike}'>
							<li class="list-group-item">
								<a href="<c:url value='/article/articleContent?art_id=${like.art_id}'/>">${like.art_title}</a>
							</li>
					    	</c:forEach>
						 </ul>
				</div>
			</div>

		</div>
	</div>
	
</body>
</html>