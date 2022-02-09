<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>food record</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />

<!-- Font Awesome icons (free version) 要改根目錄-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link href="${pageContext.request.contextPath}/css/health/record.css"
	rel="stylesheet" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">


<script type="text/javascript">
	window.onload = function() {
		
		if("${food.foodid}"){
			var imageURL = "<c:url value='/getfoodImage' />";
			showimgs.src  = imageURL + "?foodid=" + "${food.foodid}";
			showimgs.style.display = 'block';
			showimgs.style.width = "900px";
			showimgs.style.height = "400px";
		}else{
			
		}
		
		let foodid = document.getElementById('foodid');
		let food = "${food}";
		console.log(${mbid});
		if (food) {
			name.innerHTML = "${food.name}";
			weight.innerHTML = "${food.weight}";
			calorie.innerHTML = "${food.calorie}";
			carbohydrates.innerHTML = "${food.carbohydrates}";
			fat.innerHTML = "${food.fat}";
			protein.innerHTML = "${food.protein}";

		}
		console.log(${mbid} != null );
		if (${mbid} != null){
			
		
		foodid.onclick = function() {
		
				hasError = false;

				var xhr1 = new XMLHttpRequest();
				let url = "<c:url value='/healthCenter/foodidsave'/>?foodid="+ ${food.foodid}+"&idfrom=" + ${mbid};
				console.log(url);
				xhr1.open("GET", url, true);
				xhr1.send();

				console.log("確定送出");
				xhr1.onreadystatechange = function() {
					// 伺服器請求完成
					if (xhr1.readyState == 4
							&& (xhr1.status == 200 || xhr1.status == 201)) {
						result = JSON.parse(xhr1.responseText);
						if (result.fail) {
							alert(result.fail);
						} else if (result.success) {
							alert(result.success);
							window.location.href = "<c:url value='/healthCenter/food/all2/'/>";
						}
					
				}
			}
		}
	}
		
		let showimg = document.getElementById("showimg");
		//以mbid
		var xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/memberManagement/' />" + "${mbid}";
		xhr2.open("GET", url);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				//console.log(xhr.responseText);
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + "${mbid}";
			showimg.style="";
		}
}		
	
</script>
<style type="text/css">
#mainNav {
	background-color: #212529;
}
</style>
</head>
<body>

	<%@include file="../../../navigation.jsp"%>

	<!-- Navigation-->
	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent" style="height: 800px;">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img style="display: none;" src="${pageContext.request.contextPath}/images/member_0.png"
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
			</a> <a href="<c:url value='/addMemberForm' />" class="link link_here">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>


		<div class="container px-4 px-lg-5">
			<!-- Heading Row-->
			<div class="row gx-4 gx-lg-5 align-items-center my-5">
				<div class="col-lg-7">
					<img id='showimgs' class="img-fluid rounded mb-4 mb-lg-0" src=""
						alt="..." />
				</div>

				<div class="w3-third w3-margin-bottom" style="width: 500px;">
					<ul class="w3-ul w3-border w3-center w3-hover-shadow">
						<li class="w3-xlarge w3-padding-32"
							style="background-color: #ffd306;">${food.category}</li>
						<li class="w3-padding-16"><b id="name"></b> ${food.name}</li>
						<li class="w3-padding-16"><b id="weight"></b> 重量</li>
						<li class="w3-padding-16"><b id="calorie"></b> 卡洛里</li>
						<li class="w3-padding-16"><b id="carbohydrates"></b> 碳水化合物</li>
						<li class="w3-padding-16"><b id="fat"></b> 脂肪</li>
						<li class="w3-padding-16"><b id="protein"> </b> 蛋白质</li>
						<li class="w3-light-grey w3-padding-24">
							<button class="w3-button  w3-padding-large" id="foodid"
								style="background-color: #ffd306;">存取</button>
						</li>
					</ul>
				</div>
			</div>
			<a class="w3-button  w3-padding-large"
				href="<c:url value='/healthCenter/food/all2/'/>"
				style="background-color: #ffd306; text-align: center;">回上頁</a>
		</div>

	</div>

</body>
</html>