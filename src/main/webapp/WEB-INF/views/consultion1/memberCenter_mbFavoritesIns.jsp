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
<title>健康運動整合平台 | 會員中心-最愛的講師</title>
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

<script>
let mbId="${mbid}";
window.onload = function(){
	let dataArea= document.getElementById("dataArea");
	console.log(mbId);
	loadData()
	findFavoriteIns();
}
//個人圖片圖取
function loadData() {
	let xhr = new XMLHttpRequest();
	let url = "<c:url value='/memberManagement/' />" + mbId;
	xhr.open("GET", url);
	xhr.send();
	xhr.onreadystatechange = function() {
		let imageURL = "<c:url value='/getImage' />";
		showimg.src = imageURL + "?mbid=" + mbId;
		showimg.style ="";
	}
}
function findFavoriteIns(){
	console.log("findFavoriteIns");
	let xhr = new XMLHttpRequest();
	let url="<c:url value='/consultion/mbfavoriteIns//'/>"+mbId;
	xhr.open("GET",url,true);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			dataArea.innerHTML = processFavoriteList(xhr.responseText);
			
		}
	}
}

function processFavoriteList(resultFavorite){
	let favorites=JSON.parse(resultFavorite);
	var imageURL = "<c:url value='/consultion/getCoverImage' />";
	let segment="";
	for(let i=0;i<favorites.length;i++){
		let favorite=favorites[i];
		segment += "<div class='container'style='background-color:#FFFFDF;border-radius:10px;"+
		"display:flex;width:500px;height:150px;border:1px solid #BEBEBE;margin-top: 20px'>";
		segment += "<div style='flex-grow: 0.05;margin:5px;'>";
		segment	+= "<img style='margin:8px;'class='rounded-circle ' width='120' height='120' "+ " src='" + imageURL + "?instructorId="  
			+  favorite.instructorId + "'>";
		segment	+= "</div>";
		segment += "<div style='flex-direction:colum;flex-grow: 1;margin:5px;'>";
		segment += "	<div style='margin-top:5px;height:80px;'>";
// 		segment += "<h2>"+favorite.instructorId+"</h2>" ;
		segment += "<h3>"+favorite.instructorName+"</h3>" ;
		segment	+="<span style='margin:2px;border:5px solid #FFDC35;background-color:#FFDC35;border-radius:5px;color:white'>"+favorite.type+"</span>";
		segment +="<span style='border:2px solid #97CBFF;margin:0 5px;background-color:	#66B3FF;border-radius:5px;color:white;'>"+favorite.speciality1+"</span>";
		segment +="<span style='border:2px solid #97CBFF;margin:0 5px;background-color:	#66B3FF;border-radius:5px;color:white;'>"+favorite.speciality2+"</span>";

// 		segment += "<span>"+ favorite.speciality1 +"  "+ favorite.speciality2+"</span>";
		segment += "	</div>";

		segment += "	<div style='margin-top:5px;height:40px;'>";
		let href="<c:url value='/consultion/insCalendar/' />"+favorite.instructorId ;
		segment +="<td><a class='btn btn-warning' href='" +href+"'>"+"即刻預約</a></td>";
		segment += "	</div>";
		
		segment += "</div>";
		segment += "</div>";
	
	}
	return segment;
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
		<%@include file="../sidebar.jsp"%>

		<!-- 內容區塊 -->
		<div class="ContentBox">

			<div class="switchBtnBox">

				<a href="<c:url value='/consultion/listPage/${mbid}'/>"class="switchBtn"> 
					<span class="switchText">諮詢明細 </span>
				</a>
				 <a href="<c:url value='/consultion/mbcalendar/${mbid}'/>"class="switchBtn"> 
				 <span class="switchText"> 諮詢月曆</span>
				</a>
				<a href="<c:url value='/consultion/mbfavoriteInsPage/${mbid}'/>"class="switchBtn info_here"> 
				 <span class="switchText"> 最愛講師</span>
				</a>
				<c:if test="${insIdStatus}">
				 <a href="<c:url value='/consultion/InsListPage'/>"class="switchBtn"> 
				 <span class="switchText"> 被諮詢明細</span>
				</a>
				<a href="<c:url value='/consultion/InsSchedulePage'/>"class="switchBtn"> 
				 <span class="switchText"> 講師月曆</span>
				</a>
				</c:if>
			</div>

			<div class="InfoBox">
				<div id="dataArea"></div>
			</div>
		</div>

	</div>




</body>

</html>