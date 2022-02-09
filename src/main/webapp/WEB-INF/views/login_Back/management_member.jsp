<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member.css">

<!-- 新增fontawsome  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script>
	let keyword;
	window.onload = function() {
		keyword = document.getElementById("keyword");
		//document.getElementById("searchbar").addEventListener("click", search);
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findAll' />");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processMemberData(xhr.responseText);
			}
		}
	}
	function findAll() {
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findAll' />");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processMemberData(xhr.responseText);
			}
		}
	}
	function processMemberData(jsonString) {
		let members = JSON.parse(jsonString);
		let segment = "";
		console.log(members);
		if (members.length != 0) {
			var imageURL = "<c:url value='/getImage' />";
			segment = "<table>";
			//segment += "<tr><th>ID</th><th>名字</th><th>Email</th><th>密碼</th><th>生日</th><th>性別</th><th>地址</th><th>手機</th><th>註冊日期</th><th>照片</th><th><i class='far fa-trash-alt'></i></th></tr>";
			segment += "<tr><th>ID</th><th>名字</th><th>Email</th><th>生日</th><th>性別</th><th>地址</th><th>手機</th><th>註冊日期</th><th>照片</th><th><i class='far fa-trash-alt'></i></th></tr>";
			for (let n = 0; n < members.length; n++) {
				let member = members[n];
				segment += "<tr>";
				let link = "<a href='" + "<c:url value='/findId' />?mbid="
						+ member.mbid + "'>" + member.mbid + "</a>";
				if (n == 0) {
				}
				segment += "<td>" + link + "</td>";
				segment += "<td>" + member.mbname + "</td>";
				segment += "<td>" + member.mbemail + "</td>";
				//segment += "<td>" + member.mbpassword + "</td>";
				segment += "<td>" + member.birthday + "</td>";
				segment += "<td>" + member.gender + "</td>";
				segment += "<td>" + member.address + "</td>";
				segment += "<td>" + member.phone + "</td>";
				segment += "<td >" + member.localDate + "</td>";
				segment += "<td ><img id='" + member.mbid
						+ "' width='40' height='40'" + "src='" + imageURL
						+ "?mbid=" + member.mbid + "'></td>";
				segment += "<td><button class='deletBtn' onclick=deleteData("
						+ member.mbid
						+ ")><i class='far fa-trash-alt'></i></button></td>";
				segment += "</tr>";
			}
			segment += "</table>";
			return segment;
		} else {
			segment += "<div style='margin:6px;color:	#FF0000'>查無資料,請重新查詢</div>";
			//dataArea.innerHTML = "<div style='margin:6px;color:	#FF0000'>查無資料,請重新查詢</div>";
			return segment;
		}

	}
	function deleteData(mbid) {
		if (confirm("請問是否確定刪除會員資料?")) {
			let xhr2 = new XMLHttpRequest();

			url = "<c:url value='/memberManagement/delete'/>?mbid=" + mbid;
			xhr2.open("GET", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let delresult = JSON.parse(xhr2.responseText);
					console.log("delresult=" + delresult);
					if (delresult.fail) {
						alert("刪除失敗");
					} else if (delresult.success) {
						alert("刪除成功");
					}
					findAll();
				}
			}
		} else {
			return false;
		}
	}
	// 	function search() {
	// 		let keywordVal = keyword.value;
	// 		//	 	console.log("keywordVal"+keywordVal);
	// 		let xhr4 = new XMLHttpRequest();
	// 		let url4 = "<c:url value='/findbyNameOrEmail' />?keyword=" + keywordVal;

	// 		xhr4.open("GET", url4, true);
	// 		xhr4.send();
	// 		xhr4.onreadystatechange = function() {
	// 			if (xhr4.readyState == 4 && xhr4.status == 200) {
	// 				let result4 = xhr4.responseText;
	// 				console.log(result4);
	// 				//if (result4 != "") {
	// 					//console.log("result4");
	// 					dataArea.innerHTML = processMemberData(result4);
	// 					//	 				console.log(result4);
	// 				//} else {
	// 				//  document.getElementById("searchdiv").innerHTML +="<div style='margin:6px;color:	#FF0000'>查無此資料</div>";
	// 				//	dataArea.innerHTML = "<div style='margin:6px;color:	#FF0000'>查無資料,請重新查詢</div>";
	// 		//}
	// 			}
	// 		}
	// 	}
	function keyup(val) {
		let xhr4 = new XMLHttpRequest();
		url = "<c:url value='/findbyNameOrEmail'/>?keyword=" + val;
		xhr4.open("GET", url, true);
		xhr4.send();
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				dataArea.innerHTML = processMemberData(xhr4.responseText);
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
			<div class="container-fluid">
				<!--請將內容寫在此處-->
				<div class="mbContent">
					<input type="text" name="" id="keyword" class="searchBox"
						placeholder="請輸入會員Email/名字" onkeyup="keyup(this.value)"> 
<!-- 						<input type="button" id="searchbar" value="搜尋" class="searchBtn"> -->
						<span class="searchBtn"><i class="fas fa-search"></i></span>
					<h1 class="tittle">會員資料管理</h1>
					<div id='dataArea' align='center' class="tbBox"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>