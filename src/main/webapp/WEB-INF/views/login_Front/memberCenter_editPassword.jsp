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
<link rel="icon" type="${pageContext.request.contextPath}/images/x-icon"
	href="image/favicon.ico" />
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
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<!-- 會員中心的樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">
<script>
	var hasError = false;
	var pwdCheckMsg = null;
	var pwdDoubleCheckMsg = null;
	let id = "${mbid}";
	window.onload = function() {
		//let mbemail = document.getElementById("mbemail");
		let mbpassword = document.getElementById("mbpassword"); //原密碼
		let newPassword = document.getElementById("newPassword");//新密碼
		let checkNewPassword = document.getElementById("checkNewPassword");//新密碼確認
		let sendData = document.getElementById("sendData");
		let showimg = document.getElementById("showimg");
		loadData();
		//送出使用者可輸入的欄位上的資料前啟動檢查及送出的function
		sendData.addEventListener('click', checkAndSendData);
	}
	function loadData() {
		var xhr = new XMLHttpRequest();
		//以mbid
		let url = "<c:url value='/memberCenter/' />" + id;
		xhr.open("GET", url);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				//console.log(xhr.responseText);
				let member = JSON.parse(xhr.responseText);
				console.log(member.mbid);
				mbid = member.mbid;
				mbpassword.value = member.mbpassword;
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + id;
			showimg.style="";
		}
	}

	function checkAndSendData() {
		hasError = false;
		let divResult = document.getElementById('resultMsg');
		pwdCheckMsg = document.getElementById('result0c');
		pwdDoubleCheckMsg = document.getElementById('result1c');
		let passwordValue = document.getElementById("mbpassword").value;
		let newPasswordValue = document.getElementById("newPassword").value;
		let checkNewPasswordValue = document.getElementById("checkNewPassword").value;

		//這是最後要放入obj物件傳回後端儲存的，因為資料庫性別 

		console.log("準備要以物件方式傳回後端的值為:");
		console.log("mbid=" + mbid + "  , 原本密碼為" + passwordValue);
		console.log("新密碼為" + newPasswordValue);
		console.log("確認新密碼為" + checkNewPasswordValue);
	//const pwdRules=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;大小寫都要+數字 6up
	const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
	console.log(pwdRules.test(newPasswordValue));
		if (!newPasswordValue) {
			setErrorFor(pwdCheckMsg,
					"<i class='fas fa-exclamation-circle falseIcon'></i>您尚未輸入新密碼");
		} else {
			pwdCheckMsg.innerHTML = "";
		}
		if (!checkNewPasswordValue) {
			setErrorFor(pwdDoubleCheckMsg,
					"<i class='fas fa-exclamation-circle falseIcon'></i>您尚未輸入確認新密碼");
		} else {
			pwdDoubleCheckMsg.innerHTML = "";
		}

		if (newPasswordValue == passwordValue) {
			setErrorFor(pwdCheckMsg,
					"<i class='fas fa-exclamation-circle falseIcon'></i>新密碼與原本密碼相符");
		}

		if (checkNewPasswordValue != newPasswordValue) {
			setErrorFor(pwdDoubleCheckMsg,
					"<i class='fas fa-exclamation-circle falseIcon'></i>請重複輸入新密碼");

		}
		
		if(!pwdRules.test(newPasswordValue)){
			setErrorFor(pwdCheckMsg,
			"<i class='fas fa-exclamation-circle falseIcon'></i>請至少輸入超過6位英文+數字");
		}
		
		

		if (hasError) {
			return false;
		}

		let obj = {
			"mbid" : mbid,
			"mbpassword" : newPasswordValue
		};
		var xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/memberUpdate'  />";
		//console.log(url);
		xhr2.open("PUT", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(obj));
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				let result = JSON.parse(xhr2.responseText);
				console.log("result=" + result);
				console.log("divResult=" + divResult);

// 				if (result.fail) {
// 					divResult.innerHTML = "<font color='red' >" + result.fail
// 							+ "</font>";
// 				} else if (result.success) {
// 					divResult.innerHTML = "<font color='GREEN'>"
// 							+ result.success + "</font>";
// 				}
			}
		}
		alert("修改成功");
		window.location.href = " <c:url value='/memberCenter_editPassword' />";
	}

	function setErrorFor(input, message) {
		input.innerHTML = message;
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
			<img style="display:none;"
<%-- 				<img src="${pageContext.request.contextPath}/images/member_0.png" --%>
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link"> <img
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
				<a href="<c:url value='/memberCenter_editInfo'/>" class="switchBtn">
					<span class="switchText"> 基本資料 </span>
				</a> <a href="<c:url value='/memberCenter_editPassword'/>"
					class="switchBtn info_here"> <span class="switchText">
						修改密碼 </span>
				</a>
			</div>

			<div class="InfoBox">
				<!-- 				<div class="inputBox"> -->
				<!-- 					<label for="mbEmail" class="labelText">帳號</label> <span -->
				<!-- 						class="input_disable">123@gmail.com</span> -->
				<!-- 				</div> -->
				<div class="inputBox">
					<label for="mbpassword" class="labelText">目前密碼</label> <input
						id="mbpassword" type="password" class="input" readonly>
				</div>
				<div class="inputBox">
					<label for="newPassword" class="labelText">新密碼</label> <input
						id="newPassword" type="password" class="input"> <span
						class="checkTextFalse" id='result0c'> </span>
					<!-- 						  <i class="fas fa-exclamation-circle falseIcon"></i> -->
				</div>
				<div class="inputBox">
					<label for="checkNewPassword" class="labelText">確認新密碼</label> <input
						id="checkNewPassword" type="password" class="input"> <span
						class="checkTextFalse" id='result1c'> </span>
				</div>
				<div id='resultMsg' class="resultMsg"></div>
				<div class="submitBox">
					<button class="submitBtn" id="sendData">儲存變更</button>
				</div>
			</div>
		</div>

	</div>



	<!-- Footer-->
<!-- 	<div class="container"> -->
<!-- 		<div class="row align-items-center"> -->
<!-- 			<div class="col-lg-4 text-lg-start">Copyright &copy; Your -->
<!-- 				Website 2021</div> -->
<!-- 			<div class="col-lg-4 my-3 my-lg-0"> -->
<!-- 				<a class="btn btn-dark btn-social mx-2" href="#!"><i -->
<!-- 					class="fab fa-twitter"></i></a> <a class="btn btn-dark btn-social mx-2" -->
<!-- 					href="#!"><i class="fab fa-facebook-f"></i></a> <a -->
<!-- 					class="btn btn-dark btn-social mx-2" href="#!"><i -->
<!-- 					class="fab fa-linkedin-in"></i></a> -->
<!-- 			</div> -->
<!-- 			<div class="col-lg-4 text-lg-end"> -->
<!-- 				<a class="link-dark text-decoration-none me-3" href="#!">Privacy -->
<!-- 					Policy</a> <a class="link-dark text-decoration-none" href="#!">Terms -->
<!-- 					of Use</a> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

</body>

</html>