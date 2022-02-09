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
		loadData();
		findArticleData();
		findMessageData();
		
		//inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		//sendData.addEventListener('click', checkAndSendData);
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
	
	//已發表文章管理
	function findArticleData() {
		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/article/findArticleByArtUserId'/>?art_user_id=" + mbid;
		xhr2.open("GET", url);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				collectArea.innerHTML = showPublishCollectData(xhr2.responseText);
			}
		}
	}
	
	function showPublishCollectData(jsonString) {
		let articles = JSON.parse(jsonString);
		let segment = "";
		if(articles.length != 0){
			segment += "<table class='table'>";
			segment += "<thead><tr><th>標題</th><th>標籤</th><th>留言數</th><th>收藏數</th><th>點讚數</th><th>瀏覽量</th><th>發文時間</th><th>操作</th></tr></thead>";
			segment += "<tbody>";
			for (let n = 0; n < articles.length; n++) {
				let article = articles[n];
				segment += "<tr>";
				segment += "<td><a href='<c:url value='/article/articleContent?art_id=" + article.art_id + "'/>'>" + article.art_title + "</a></td>";
				segment += "<td>" + article.tag_name + "</td>";
				segment += "<td>" + article.art_com_num + "</td>";
				segment += "<td>" + article.art_collect_num + "</td>";
				segment += "<td>" + article.art_like_num + "</td>";
				segment += "<td>" + article.art_view + "</td>";
				segment += "<td>" + article.art_create_time+ "</td>";
				let deletelink = "<button class='btn btn-danger btn-sm' onclick=deleteArticleData(" + article.art_id + ")><i class='bi bi-trash'></i></button>";
				let editlink = "<a href='<c:url value='/article/articleContentEdit?art_id=" + article.art_id + "'/>'><button class='btn btn-primary btn-sm me-2'><i class='bi bi-pencil-square'></i></button></a>";
				segment += "<td>" + editlink + deletelink + "</td></tr>";
			}
			segment += "</tbody>";
			segment += "</table>";
			return segment;
		}else{
			segment += "<h3 style='text-align:center;margin:10px'>目前無發表文章</h3>";
			return segment;
		}
	}
	
	function deleteArticleData(artId){
		if (confirm("請問是否確定刪除?")) {
			let xhr3 = new XMLHttpRequest();
			let url = "<c:url value='/article/articleContentDelete'/>?art_id=" + artId;
			xhr3.open("GET", url);
			xhr3.send();
			xhr3.onreadystatechange = function() {
				if (xhr3.readyState == 4 && xhr3.status == 200) {
					let delresult = JSON.parse(xhr3.responseText);
					if(delresult.fail) {
						alert("刪除失敗");
					}else if (delresult.success) {
						alert("刪除成功");
					}
					findArticleData();
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

				<a href="<c:url value='/articleCenter_editInfo'/>" class="switchBtn">
					<span class="switchText">已收藏文章 </span>
				</a> 
				<a href="<c:url value='/articleCenter_editPublish'/>" class="switchBtn info_here"> 
					<span class="switchText"> 已發表文章 </span>
				</a>
				<a href="<c:url value='/articleCenter_editMessage'/>" class="switchBtn"> 
					<span class="switchText" style="position:relative"> 訊息通知 <span class="badge bg-secondary rounded-pill" style="font-size:100%;position:absolute;top:-15px" id="messageNum"></span></span>
				</a>
			</div>
			<div class="InfoBox" style="max-width:1300px;padding:0px 10px">
				<div id="collectArea">
					
				</div>
			</div>
		
		</div>
	</div>

</body>

</html>