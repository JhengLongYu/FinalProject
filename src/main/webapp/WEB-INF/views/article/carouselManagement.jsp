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
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">	
<script>
	window.onload = function() {
		let tagArea = document.getElementById("tagArea");
		findAllCarousel();
		findALLArticle()
	}
	
	
	//文章下拉選單
	function findALLArticle() {	
		let selectElement = document.getElementById("articleTitleTag");
		let articleTitleTagData = [];
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/articleForum/findAll'/>", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let articles = JSON.parse(xhr.responseText);
				for (let i = 0; i < articles.length; i++){
					let article = [articles[i].art_title, articles[i].art_id];
					articleTitleTagData.push(article);
				}	
				for (let i = 0; i < articleTitleTagData.length; i++) {
					let option = new Option(articleTitleTagData[i][0], articleTitleTagData[i][1]);
					selectElement.options[selectElement.options.length] = option;
				}
			}
		}
	}	

	function checkAndNewCarousel() {
		let articleTitleVal = document.getElementById("articleTitleTag").value;
		console.log(articleTitleVal);
		let xhr2 = new XMLHttpRequest();
		url = "<c:url value='/carousel/carouselSave'/>?art_id=" + articleTitleVal;
		xhr2.open("GET", url, true);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				let result = JSON.parse(xhr2.responseText);
				if (result.fail) {
					alert("輪播牆文章重複請重新挑選");
				} else if (result.success) {
					alert("新增成功");
				}
				findAllCarousel();
			}
		}	
	}
	
	function findAllCarousel() {
		let xhr3 = new XMLHttpRequest();
		xhr3.open("GET", "<c:url value='/carousel/findAll'/>", true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				carouselArea.innerHTML = showCarouselData(xhr3.responseText);
			}
		}
	}
	
 	function showCarouselData(jsonString) {		
 		let carousels = JSON.parse(jsonString);
 		let imageArticleURL = "<c:url value='/article/getCoverImage' />";
 		let segment = "<table class='table'>";
 		segment += "<thead><tr><th>文章標題</th><th>文章圖片</th><th>發文時間</th><th>操作</th></tr></thead>";
 		segment += "<tbody>";
 		for (let n = 0; n < carousels.length; n++) {
 			let carousel = carousels[n];
 			segment += "<tr>";
 			segment += "<td style='vertical-align:middle'>" + carousel.art_title + "</td>";
 			segment += "<td><img src='" + imageArticleURL + "?art_id=" + carousel.art_id + "' style='width: 80px;height: 50px'></td>";
 			segment += "<td style='vertical-align:middle'>" + carousel.art_create_time + "</td>";
 			let deletelink = "<button class='btn btn-danger btn-sm' onclick=deleteData(" + carousel.carousel_id + ")><i class='bi bi-trash'></i></button>";
 			segment += "<td style='vertical-align:middle'>" + deletelink + "</td></tr>";
 		}
 		segment += "</tbody>";
 		segment += "</table>";
 		return segment;
	}
	
 	function deleteData(delId) {
		if (confirm("請問是否確定刪除?")) {
			let xhr4 = new XMLHttpRequest();
			url = "<c:url value='/carousel/deleteCarousel'/>?carousel_id=" + delId;
			xhr4.open("GET", url, true);
			xhr4.send();
			xhr4.onreadystatechange = function() {
				if (xhr4.readyState == 4 && xhr4.status == 200) {
					let delresult = JSON.parse(xhr4.responseText);
					if (delresult.fail) {
						alert("刪除失敗");
					} else if (delresult.success) {
						alert("刪除成功");
					}
					findAllCarousel();
				}

			}
		} else {
			return false;
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
			<div class="container-fluid position-relative" class="position-relative">
				<div class="container" id="dataArea">
					<button class='btn btn-success btn-sm' data-bs-toggle="modal"
						data-bs-target="#articleNewModal" style="position: absolute; top: 10px; right: 90px;"><i class="bi bi-plus-lg"></i></button>

					<div class="modal fade" id="articleNewModal" tabindex="-1"
						aria-labelledby="articleNewModalLabel" aria-hidden="true">
						<div class="modal-dialog" style="max-width:670px">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="articleNewModalLabel">新增文章到輪播</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="row my-4">
										<label for="articleNameInput" class="col-sm-2 col-form-label">文章標題：</label>
										<div class="col-sm-8">
											<select id='articleTitleTag' class="form-select" style="width:500px"></select>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick=checkAndNewCarousel()>確定</button>
									<button type="button" class="btn btn-danger" data-bs-dismiss="modal">取消</button>
								</div>
							</div>
						</div>
					</div>
					<div id="carouselArea">&nbsp;</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>