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
<title>健康運動整合平台 | 文章修改</title>
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
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script>
	let mbid = "${mbid}";
	window.onload = function() {
		let showimg = document.getElementById("showimg");
		let showimgArtFile = document.getElementById("showimgArtFile");
		let dataArea = document.getElementById("dataArea"); 
		let articleTitle = document.getElementById("articleTitle"); 
		let articleTag = document.getElementById("articleTag"); 
		let articleText = document.getElementById("articleText");
		fileDataURL = document.getElementById("inputFileToLoad");
		CKEDITOR.replace('articleText', {
			height:400,
			width:1000
		});
		//文章封面上傳
		inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		// 檢查及送出
		sendData.addEventListener('click', checkAndSendData);
		//Tag 類別選單
		findALLTagOption();
		loadMemberData();
		loadArticleData();
	}

	function loadMemberData() {
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
	
	//Tag 類別選單
	function findALLTagOption() {	
		let selectElement = document.getElementById("articleTag");
		let articleTagData = [];
		let xhr2 = new XMLHttpRequest();
		xhr2.open("GET", "<c:url value='/tag/findAll'/>", true);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				let tags = JSON.parse(xhr2.responseText);
				for (let i = 0; i < tags.length; i++){
					let tag = [tags[i].tag_name, tags[i].tag_id];
					articleTagData.push(tag);
				}
				for (let i = 0; i < articleTagData.length; i++) {
					let option = new Option(articleTagData[i][0], articleTagData[i][1]);
					selectElement.options[selectElement.options.length] = option;
				}
			}
		}
	}
	
	//圖片變更顯示
	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("inputFileToLoad").files;
		if (filesSelected.length > 0) {
			let fileToLoad = filesSelected[0];
			let fileReader = new FileReader();
			fileReader.onload = function(fileLoadedEvent) {
				fileDataURL = fileLoadedEvent.target.result;
				showimgArtFile.src = fileLoadedEvent.target.result;
			};
			fileReader.readAsDataURL(fileToLoad);
			showimgArtFile.style.display = 'block';
			showimgArtFile.style.width = "180px";
			showimgArtFile.style.height = "180px";
		} else {
			fileDataURL = null;
			console.log("未選擇檔案");
		}
	}
	
	function loadArticleData(){
		let xhr3 = new XMLHttpRequest();
		let url = "<c:url value='/article/articleContentFindByArtId' />?art_id=" + ${article.art_id};
		xhr3.open("GET", url);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let article = JSON.parse(xhr3.responseText); 
				articleTitle.value = article.art_title;
				articleTag.value = article.tag_id;
				CKEDITOR.instances.articleText.setData(article.art_content);
			} 
		let imageArticleURL = "<c:url value='/article/getCoverImage' />";
		showimgArtFile.src = imageArticleURL + "?art_id=" + ${article.art_id};
		showimgArtFile.style.display = 'block';
		showimgArtFile.style.width = "180px";
		showimgArtFile.style.height = "180px";
		}
	}
	
	function checkAndSendData() {
		hasError = false;
		let articleTitleVal = document.getElementById("articleTitle").value;
		let articleTagVal = document.getElementById("articleTag").value;
		let articleTextVal = CKEDITOR.instances.articleText.getData();
		var div1 = document.getElementById('result1c');
		var divResult = document.getElementById('resultMsg');

		if (!articleTitleVal) {
			setErrorFor(div1, "請輸入文章標題");
		} else {
			div1.innerHTML = "";
		}
		loadImageFileAsURL();
		if (!fileDataURL) {
			console.log("no pic" + fileDataURL);
		}
		if (hasError) {
			return false;
		}
		var article = {
			"art_id" : ${article.art_id},
			"art_user_id" : mbid,
			"art_title" : articleTitleVal,
			"tag_id" : articleTagVal,
			"art_content" : articleTextVal,
			"fileDataUrl" : fileDataURL
		}

		jsonArticle = JSON.stringify(article);
		var xhr4 = new XMLHttpRequest();
		xhr4.open("POST", "<c:url value='/article/articleContentUpdate'/>", true);
		xhr4.setRequestHeader("Content-Type", "application/json");
		xhr4.send(jsonArticle);
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				alert("修改成功");
	     		window.location.href = "<c:url value='/articleCenter_editPublish' />";
			}
		}
	}

	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		hasError = true;
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
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>"
				class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>

		<!-- 內容區塊 -->


		<div class="container" style="max-width: 1250px; margin-top: 20px">

			<div class="container-fluid">
				<div
					style='width: 1200px; margin: 10px auto; padding: 10px; background-color: white;'>


					<div class="form-group row" style='justify-content: center'>
						<label for="articleTitle" class="col-sm-2 col-form-label">文章標題</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="articleTitle"
								placeholder="請輸入文章標題" style='background-color: #FFF8D7'>
							<span id='result1c' style="height: 10px;"></span>
						</div>
					</div>

					<div class="form-group row" style='justify-content: center'>
						<label for="articleTag" class="col-sm-2 col-form-label">文章類別</label>
						<div class="col-sm-8">
							<select id="articleTag" class="form-control"
								style='background-color: #FFF8D7'>
							</select> <span id='result2c' style="height: 10px;"></span>
						</div>
					</div>

					<div class="form-group row" style='justify-content: center'>
						<label for="inputFileToLoad" class="col-sm-2 col-form-label">文章封面</label>
						<div class="col-sm-8">
							<input type="file" accept="image/jpeg, image/png"
								id="inputFileToLoad" onchange="loadImageFileAsURL();"> <img
								id="showimgArtFile" src="" />
						</div>
					</div>

					<!-- 文章內容 -->
					<div class="form-group row" style='justify-content: center'>
						<label for="" class="col-sm-2 col-form-label">文章內容</label>
						<div class="col-sm-8"></div>
					</div>
					<div class="form-group row" style='justify-content: center'>
						<textarea class="col-sm-10" id="articleText"></textarea>
					</div>


					<div class="form-group row" style='justify-content: center'>
						<div class="d-grid gap-2 col-4 mx-auto mt-5">
							<button id='sendData' class="btn btn-warning">確定送出</button>
							<span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
						</div>
					</div>
				</div>




				<div class="container" id="dataArea" align="center"></div>

			</div>
		</div>
	</div>

</body>

</html>