<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|論壇管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">	
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script>
	window.onload = function() {
		let articleArea = document.getElementById("articleArea");
		findAllArticle();
		findALLTagOption();
	}
	
	function findAllArticle() {
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/article/findAll'/>", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				articleArea.innerHTML = showArticleData(xhr.responseText);
			}
		}
	}
	
	function showArticleData(jsonString) {		//文章管理
		let articles = JSON.parse(jsonString);
		let segment = "<table class='table'>";
		segment += "<thead><tr><th>標題</th><th>發文者</th><th>標籤</th><th>留言數</th><th>收藏數</th><th>點讚數</th><th>瀏覽量</th><th>發文時間</th><th>操作</th></tr></thead>";
		segment += "<tbody>";
		if(articles.length!=0){
			for (let n = 0; n < articles.length; n++) {
				let article = articles[n];
				segment += "<tr>";
				segment += "<td>" + article.art_title + "</td>";
				segment += "<td>" + article.member.mbname + "</td>";
				segment += "<td>" + article.tag_name + "</td>";
				segment += "<td>" + article.art_com_num + "</td>";
				segment += "<td>" + article.art_collect_num + "</td>";
				segment += "<td>" + article.art_like_num + "</td>";
				segment += "<td>" + article.art_view + "</td>";
				segment += "<td>" + article.art_create_time+ "</td>";
				let deletelink = "<button class='btn btn-danger btn-sm' onclick=deleteArticleData(" + article.art_id + ")><i class='bi bi-trash'></i></button>";
				segment += "<td>" + deletelink + "</td></tr>";
			}
		}else{
			segment += "<tr>";
			segment += "<td colspan='9' align='center'>查無資料</td>";
		}
		segment += "</tbody>";
		segment += "</table>";
		return segment;
	}
	
	function deleteArticleData(delId) {
		if (confirm("請問是否確定刪除?")) {
			let xhr2 = new XMLHttpRequest();
			url = "<c:url value='/article/articleContentDelete'/>?art_id=" + delId;
			xhr2.open("GET", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let delresult = JSON.parse(xhr2.responseText);
					if (delresult.fail) {
						alert("刪除失敗");
					} else if (delresult.success) {
						alert("刪除成功");
					}
					findAllArticle();
				}

			}
		} else {
			return false;
		}
	}
	
	function findALLTagOption() {	//文章管理-Tag選單
		let selectElement = document.getElementById("articleTag");
		let articleTagData = [];
		let xhr3 = new XMLHttpRequest();
		xhr3.open("GET", "<c:url value='/tag/findAll'/>", true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let tags = JSON.parse(xhr3.responseText);
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
		
		selectElement.onchange = function(){
			let tagId = selectElement.options[ selectElement.selectedIndex ].value;
			let xhr4 = new XMLHttpRequest();
			url = "<c:url value='/article/findArticleByTag'/>?tag_id=" + tagId;
			xhr4.open("GET", url, true);
			xhr4.send();
			xhr4.onreadystatechange = function() {
				if (xhr4.readyState == 4 && xhr4.status == 200) {
					articleArea.innerHTML = showArticleData(xhr4.responseText);
				}
			}
			
		}
		
		/* function showTagDataById(jsonString) {
			let articles = JSON.parse(jsonString);
			let segment = "<table class='table'>";
			segment += "<thead><tr><th>標題</th><th>發文者</th><th>標籤</th><th>留言數</th><th>收藏數</th><th>點讚數</th><th>瀏覽量</th><th>發文時間</th><th>操作</th></tr></thead>";
			segment += "<tbody>";
			for (let n = 0; n < articles.length; n++) {
				let article = articles[n];
				segment += "<tr>";
				segment += "<td>" + article.art_title + "</td>";
				segment += "<td>" + "發文者" + "</td>";
				segment += "<td>" + article.tag_name + "</td>";
				segment += "<td>" + article.art_com_num + "</td>";
				segment += "<td>" + article.art_collect_num + "</td>";
				segment += "<td>" + article.art_like_num + "</td>";
				segment += "<td>" + article.art_view + "</td>";
				segment += "<td>" + article.art_create_time+ "</td>";
				let deletelink = "<button class='btn btn-danger btn-sm' onclick=deleteArticleData(" + article.art_id + ")>刪除</button>";
				segment += "<td>" + deletelink + "</td></tr>";
			}
			segment += "</tbody>";
			segment += "</table>";
			return segment;
			
		} */
	}
	
	function keyup(val) {
		let xhr5 = new XMLHttpRequest();
		url = "<c:url value='/articleManagement/searchKeyword'/>?keyword=" + val;
		xhr5.open("GET", url, true);
		xhr5.send();
		xhr5.onreadystatechange = function() {
			if (xhr5.readyState == 4 && xhr5.status == 200) {
				articleArea.innerHTML = showArticleData(xhr5.responseText);
			}
		}
	}
	
</script>
</head>
<body>
	<div class="d-flex" id="wrapper">
		<%@include file="../mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="../mgnavigation.jsp"%>
			<!-- Page content-->

			<div class="container-fluid" >
				<div class="container" id="dataArea">
					<div class="row mb-2 position-relative">
						<div class="col-12 d-flex">
							<input type="text" class="border rounded" style="width:400px;height:38px" placeholder="請輸入搜尋關鍵字" id="searchData" onkeyup="keyup(this.value)">
							<span class="input-group-text border-0" id="searchbar"><i class="fas fa-search"></i></span>	
							<select id='articleTag' class="form-select position-absolute top-0 end-0" style="width:150px"></select>
						</div>
							
					</div>
					<div id="articleArea">
						&nbsp;
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>