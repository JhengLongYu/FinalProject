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
<script>
var hasError = false;
	let id = "${mbid}";
	console.log(id);
	window.onload = function() {
		let mbname = document.getElementById("mbname");
		let birthday = document.getElementById("birthday");
		let male = document.getElementById("male");
		let female = document.getElementById("female");
		let phone = document.getElementById("phone");
		let address = document.getElementById("address");
		let sendData = document.getElementById("sendData");
		fileDataURL = document.getElementById("inputFileToLoad");
		let showimg = document.getElementById("showimg");
		loadData();
		inputFileToLoad.addEventListener('change', loadImageFileAsURL);
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
				console.log(xhr.responseText);
				let member = JSON.parse(xhr.responseText);
				console.log(member.mbid);
				mbid = member.mbid;
				mbname.value = member.mbname;
				birthday.value = member.birthday;
				phone.value = member.phone;
				address.value = member.address;
				//判斷member.gender是男生還女生 將預設設定在一載入的時候
				if (member.gender == "male") {
					$("#male").prop("selected", true);
				} else {
					$("#female").prop("selected", true);
				}
				//啟動載入照片檔案連結 function
				loadImageFileAsURL();
				if (!fileDataURL) {
					console.log("沒有任何照片上傳");
				}
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + id;
			showimg.style="";
		}

	}

	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("inputFileToLoad").files;
		if (filesSelected.length > 0) {
			console.log("選擇的檔案是" + filesSelected);
			let fileToLoad = filesSelected[0];
			console.log("檔案內容是" + fileToLoad);
			let fileReader = new FileReader();
			fileReader.onload = function(fileLoadedEvent) {
				fileDataURL = fileLoadedEvent.target.result;
				showimg.src = fileLoadedEvent.target.result;
			};
			fileReader.readAsDataURL(fileToLoad);

		} else {
			fileDataURL = null;
			console.log("未選擇檔案");
		}
	}

	function checkAndSendData() {
		sp4.innerHTML = "";
		hasError = false;
		let divResult = document.getElementById('resultMsg');
		let nameValue = document.getElementById("mbname").value;
		let birthdayValue = document.getElementById("birthday").value;
		let maleValue = document.getElementById("male").value;
		let femaleValue = document.getElementById("female").value;
		
		//這是最後要放入obj物件傳回後端儲存的，因為資料庫性別 
		var genderValue = null;
		let phoneValue = document.getElementById("phone").value;
		let addressValue = document.getElementById("address").value;
		nameError = document.getElementById('mbname');
		
		if (!nameValue) {
			sp3.innerHTML = "<i class='fas fa-exclamation-circle'></i> 請輸入姓名";
			hasError = true;
		} else {
			sp3.innerHTML = "";
		}
		
		if (!birthdayValue) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 請輸入生日";
			hasError = true;
		}
		else if (judgeDate(birthdayValue)<0) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 生日超過當前日期";
			hasError = true;
		}
		else if (!dateValidation(birthdayValue)) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 生日格式錯誤，正確格式為yyyy-MM-dd";
			hasError = true;
		} else {
			sp4.innerHTML = "";
		}

		if ($("#male")[0].selected) {
			genderValue = "male";
			console.log(genderValue);
		} else {
			genderValue = "female";
			console.log(genderValue);
		}
		loadImageFileAsURL();
		if (!fileDataURL) {
			console.log("沒有上傳照片檔案");
		}
	if(phoneValue!=""){
		var telreg = /^[0-9]{10}$/g;
		var myArray = telreg.test(phoneValue); 
		if(!myArray){
			sp5.innerHTML = "<i class='fas fa-exclamation-circle'></i> 手機應為10碼數字";
			hasError = true;
		}
	}
	
		
		
		if (hasError) {
			return false;
		}

		console.log("準備要以物件方式傳回後端的值為:mbid=" + mbid + "mbname=" + nameValue
				+ "birthday=" + birthdayValue + "gender=" + genderValue
				+ "phone=" + phoneValue + "address=" + addressValue
				+ "fileDataUrl=" + fileDataURL);

		let obj = {
			"mbid" : mbid,
			"mbname" : nameValue,
			"birthday" : birthdayValue,
			"gender" : genderValue,
			"phone" : phoneValue,
			"address" : addressValue,
			"fileDataUrl" : fileDataURL
		};
		//console.log(fileDataURL);

		var xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/memberUpdate'  />";
		//console.log(url);
		xhr2.open("PUT", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(obj));
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				let result = JSON.parse(xhr2.responseText);
				console.log("result="+result);
				console.log("divResult="+divResult);

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
		 window.location.href = " <c:url value='/memberCenter_editInfo' />";
		//loadData();
	}
	function judgeDate(birthdayValue){
		return new Date().getTime()-new Date(birthdayValue).getTime();
	}
	function dateValidation(str) {
		  var re = new RegExp("^([0-9]{4})[.-]{1}([0-9]{1,2})[.-]{1}([0-9]{1,2})$");
		  var days = [0, 31, 28, 31, 30,  31, 30, 31, 31, 30, 31, 30, 31];
		  var strDataValue;
		  var valid = true;
		  if ((strDataValue = re.exec(str)) != null) {
		    var y, m, d;
		    y = parseFloat(strDataValue[1]);
		    if (y <= 0 || y > 9999) { /*年*/
		      return false;
		    } 
		    m = parseFloat(strDataValue[2]);
		    
		    if (m < 1 || m > 12) { /*月*/
		        return false;
		    }
		    d = parseFloat(strDataValue[3]);
		    if ( y % 4 == 0 && y % 100 != 0 || y % 400 == 0 ){
		       days[2] = 29;
		    }  else {
		       days[2] = 28;
		    }
		    if (d <= 0 || d > days[m]) { /*日*/
		      valid = false;
		    }
		  } else {
		    valid = false;
		  }  
		  return valid;
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
<%-- 				<img src="${pageContext.request.contextPath}/images/member_0.png" --%>
				<img style="display:none;" 
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>"
				class="link link_here"> <img
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

				<a href="<c:url value='/memberCenter_editInfo'/>"
					class="switchBtn info_here"> <span class="switchText">
						基本資料 </span>
				</a> <a href="<c:url value='/memberCenter_editPassword'/>"
					class="switchBtn"> <span class="switchText"> 修改密碼 </span>
				</a>
			</div>

			<div class="InfoBox">
				<div class="inputBox">
					<label for="mbPhotoUp" class="labelText">上傳頭像</label> <input
						id="inputFileToLoad" type="file" class="input"
						accept=".jpg, .jpeg, .gif, .png" onchange="loadImageFileAsURL();">
					<span class="checkTextFalse"> </span>

				</div>
				<div class="inputBox">
					<label for="mbname" class="labelText">名字</label> <input id="mbname"
						type="text" class="input"><span id="sp3"
						class="checkTextFalse"> </span>
				</div>
				<div class="inputBox">
					<label for="birthday" class="labelText">生日</label> <input
						id="birthday" type="date" class="input"><span
						class="checkTextFalse" id="sp4"> </span>
				</div>
				<div class="inputBox">
					<label for="mbGender" class="labelText">性別</label> <select
						name="mbGender" id="mbGender" class="input">
						<option value="1" id="male">男</option>
						<option value="2" id="female">女</option>
					</select><span class="checkTextFalse"> </span>
				</div>
				<div class="inputBox">
					<label for="phone" class="labelText">手機</label> <input id="phone"
						type="text" class="input"><span id="sp5" class="checkTextFalse">
					</span>
				</div>
				<div class="inputBox">
					<label for="address" class="labelText">地址</label> <input
						id="address" type="text" class="input"><span
						class="checkTextFalse"> </span>
				</div>
				<div id='resultMsg' class="resultMsg"></div>
				<div class="submitBox">
					<button id="sendData" class="submitBtn">儲存變更</button>
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