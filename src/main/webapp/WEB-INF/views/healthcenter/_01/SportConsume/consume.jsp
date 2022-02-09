<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
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
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">

<title>consume</title>
<script>
	// var e = document.getElementById("a");
	// var value = e.options[e.selectedIndex].value;
	// var text = e.options[e.selectedIndex].text;
	// console.log(value);
	// console.log(text);
	window.onload = function() {

		var selectedCountry = "";
		var result = document.getElementById("result");
		var consume = document.getElementById("consume");
		var result1 = document.getElementById("result1");
		findAlltype();

		$(document).ready(function() {
			$("select.country").change(function() {
				selectedCountry = $(this).children("option:selected").val();
				console.log(selectedCountry);
			});
		});

		result.onclick = function() {
			let con = consume.value;
			var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
			if (!objRegex.test(con)) {
				result1.innerHTML = "<font color='red' style='font-size:30px;margin-left: 60px;'>體重須數值歐</font>";
			} else {
				result1.innerHTML = "";
				if (selectedCountry) {
					let url = "<c:url value='/healthCenter/findconsumebyname/' />?name="
							+ selectedCountry;
					console.log(url);
					let xhr = new XMLHttpRequest();
					xhr.open("GET", url);
					xhr.send();
					xhr.onreadystatechange = function() {
						// 伺服器請求完成
						if (xhr.readyState == 4
								&& (xhr.status == 200 || xhr.status == 201)) {
							let asd = xhr.responseText;
							console.log("asd = " + asd);
							asd = asd * consume.value;
							asd = asd.toFixed(0);
							console.log("asd = " + asd);
							result1.innerHTML = "<font color='green' style='font-size:30px;margin-left: 30px;'>每三十分鐘可消耗"
									+ asd
									+ "大卡</font> <br>"
									+ "<img style='width:300px;height:300px;margin-left:50px;'  src='${pageContext.request.contextPath}/images/forHealth/Jogging-rafiki.png'>";
						}

					}

				} else {
					result1.innerHTML = "<font color='red' style='font-size:30px;margin-left: 60px;'>請選擇項目</font>";
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
			showimg.style = "";
		}
	}
	function findAlltype() {
		let xhr3 = new XMLHttpRequest();
		xhr3.open("GET", "<c:url value='/healthcenter/findAllsport'/>", true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let alltypes = JSON.parse(xhr3.responseText);
				let select = document.getElementById('aassdd');
				for (let i = 0; i < alltypes.length; i++) {
					let alltype = alltypes[i];
					let opt = document.createElement('option');
					opt.value = alltype.name;
					opt.innerHTML = alltype.name;
					select.appendChild(opt);
					console.log(alltype);
				}
			}
		}
	}
</script>
<style type="text/css">
#mainNav {
	height: 100px;
	background-color: #212529;
}
</style>
</head>
<body id="page-top">
	<%@include file="../../../navigation.jsp"%>

	<!-- Navigation-->

	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img style="display: none;"
					src="${pageContext.request.contextPath}/images/member_0.png"
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

		<!-- 內容區塊 -->
		<div class="ContentBox">

			<div class="switchBtnBox">

				<a href="<c:url value='/addMemberForm' />" class="switchBtn "> <span
					class="switchText"> 基本資料 </span>
				</a> <a href="<c:url value='/healthCentercheck'  />" class="switchBtn">
					<span class="switchText"> bmi&bmr </span>
				</a> <a href="<c:url value="/healthCenter/record2/"/>" class="switchBtn">
					<span class="switchText"> 每日飲食</span>
				</a> <a href="<c:url value='/healthCenter/foods' />" class="switchBtn">
					<span class="switchText"> findfood</span>
				</a> <a href="<c:url value='/healthCenter/consume/' />"
					class="switchBtn info_here"> <span class="switchText">消耗卡路里</span>
				</a>

			</div>

			<div class="InfoBox">


				<div align="center">
					<div
						style="width: 500px; height: 500px; text-align: left; margin-top: 25px;">
						<span style="font-size: 25px; color: balck">從下方選擇一項運動：</span><br>
						<select id="aassdd" class="country"
							style="width: 150px; height: 30px; margin-left: 50px; margin-top: 20px;">
							<option value="">請選擇項目</option>

						</select> <input type="text" value="" id="consume"
							style="margin-left: 70px; width: 80px;" /> <span
							style="font-size: 25px; color: gray;">kg </span>
						<button id="result" class="btn btn-primary btn-xl "
							style="width: 120px; height: 60px; text-align: left; margin-left: 275px; margin-top: 50px; color: black;">查看</button>
						<div id="result1" style="margin-top: 30px;"></div>
						<div></div>
					</div>
				</div>


			</div>
		</div>

	</div>





</body>
</html>