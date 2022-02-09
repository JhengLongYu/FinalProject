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
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- 新增css樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member_edit.css">

<!-- 編輯程式 -->
<script>
	var hasError = false;
	let sid = "${mbid}";
	let fileDateURL = null;
	let mbid = 0;
	window.onload = function() {

		let mbname = document.getElementById("mbname");
		let mbemail = document.getElementById("mbemail");
		//let mbpassword = document.getElementById("mbpassword"); //原密碼
		//let newPassword = document.getElementById("newPassword");//新密碼
		//let checkNewPassword = document.getElementById("checkNewPassword");//新密碼確認
		let birthday = document.getElementById("birthday");
		let male = document.getElementById("male");
		let female = document.getElementById("female");
		let phone = document.getElementById("phone");
		let address = document.getElementById("address");
		let sendData = document.getElementById("sendData");

		fileDataURL = document.getElementById("inputFileToLoad");

		loadData();

		let showimg = document.getElementById("showimg");
		
		//這邊是onblur開始
		const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
		 $("#mbname").blur(function(){
			 if(!($("#mbname").val())){
				 result3c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入姓名" + "</font>";
			 }else{
				 result3c.innerHTML ="";
			 }
         });
		
		 $("#birthday").blur(function(){
			 if(!($("#birthday").val())){
				 sp4.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i>請輸入生日" + "</font>";
			 }else if(judgeDate($("#birthday").val())<0){
				 sp4.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i>生日超過當前日期" + "</font>";
			 }else if (!dateValidation($("#birthday").val())) {
				 sp4.innerHTML ="<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 生日格式錯誤，正確格式為yyyy-MM-dd" + "</font>";
			 }else{
				 sp4.innerHTML ="";
			 }
		  });
		 
		 
		 
		 $("#phone").blur(function(){
		 if(($("#phone").val())!=""){
				var telreg = /^[0-9]{10}$/g;
				var myArray = telreg.test($("#phone").val()); 
				if(!myArray){
					sp5.innerHTML = "<i class='fas fa-exclamation-circle'></i> 手機應為10碼數字";
				}else{
					sp5.innerHTML = "";
				}
			}
		 });
		
	
		inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		//送出後啟動function checkAndSendData()
		sendData.addEventListener('click', checkAndSendData);
	}

	function loadData() {
		var xhr = new XMLHttpRequest();
		let url = "<c:url value='/memberManagement/' />" + sid;
		xhr.open("GET", url);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let member = JSON.parse(xhr.responseText);
				mbid = member.mbid;
				mbname.value = member.mbname;
				mbemail.value = member.mbemail;
				let mbpasswordValue = member.mbpassword;
				//console.log(mbpasswordValue);
				birthday.value = member.birthday;
				phone.value = member.phone;
				address.value = member.address;

				if (member.gender == "male") {
					$("#male").prop("checked", true);
					//console.log($("#male").prop);
				} else {
					$("#female").prop("checked", true);
				}
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + sid;
		}

	}

	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("inputFileToLoad").files;
		if (filesSelected.length > 0) {
			console.log(filesSelected);
			let fileToLoad = filesSelected[0];
			console.log(fileToLoad);
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
		hasError = false;
		var divResult = document.getElementById('resultMsg');
		let nameValue = document.getElementById("mbname").value;
		let emailValue = document.getElementById("mbemail").value;
 		//pwdCheckMsg = document.getElementById('result1c');
 		//pwdDoubleCheckMsg = document.getElementById('result2c');
		//let passwordValue = document.getElementById("mbpassword").value;
		//let newPasswordValue = document.getElementById("newPassword").value;
		//let checkNewPasswordValue = document.getElementById("checkNewPassword").value;
		let birthdayValue = document.getElementById("birthday").value;
		//console.log("使用者輸入的密碼為" + newPasswordValue);
		//console.log("使用者輸入的確認密碼為" + checkNewPasswordValue);
		const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
		let maleValue = document.getElementById("male").value;
		let femaleValue = document.getElementById("female").value;
		let phoneValue = document.getElementById("phone").value;
		let addressValue = document.getElementById("address").value;
		var genderValue = null;
		var div3 = document.getElementById('result3c');//姓名
		
		//var div1 = document.getElementById('result1c');//NewPassword
		//var div2 = document.getElementById('result2c');//確認密碼
		var div4 = document.getElementById('result4c');//birthday
		var div5 = document.getElementById('result5c');//gender
		 var nowDate = new Date();
		
		//檢查條件開始
		if (!nameValue) {
				setErrorFor(div3, "<i class='fas fa-exclamation-circle'></i> 請輸入名字");
			} else {
				div3.innerHTML = "";
			}
// 		if (newPasswordValue == passwordValue) {
// 			setErrorFor(pwdCheckMsg,
// 					"<i class='fas fa-exclamation-circle falseIcon'></i>新密碼與原本密碼相符");
// 		}else {
// 			pwdCheckMsg.innerHTML = "";
// 		}
// 		if (checkNewPasswordValue != newPasswordValue) {
// 			setErrorFor(pwdDoubleCheckMsg,
// 					"<i class='fas fa-exclamation-circle falseIcon'></i>請重複輸入新密碼");
// 		}else {
// 			pwdDoubleCheckMsg.innerHTML = "";
// 		}
// 		if(newPasswordValue!=""){
// 			if(!pwdRules.test(newPasswordValue)){
// 				setErrorFor(pwdCheckMsg,
// 				"<i class='fas fa-exclamation-circle falseIcon'></i>請輸入超過6位英文+數字");
// 			}
// 		}
// 		if(newPasswordValue==""){
// 			newPasswordValue=passwordValue;
// 		}
		
		if (!birthdayValue) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 請輸入生日";
			hasError = true;
		}else if (judgeDate(birthdayValue)<0) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 生日超過當前日期";
			hasError = true;
		}
		else if (!dateValidation(birthdayValue)) {
			sp4.innerHTML = "<i class='fas fa-exclamation-circle'></i> 生日格式錯誤，正確格式為yyyy-MM-dd";
			hasError = true;
		} else {
			sp4.innerHTML = "";
		}
		if ($("#male")[0].checked) {
			genderValue = "male";
			console.log(genderValue);

		} else {
			genderValue = "female";
			console.log(genderValue);
		}
		loadImageFileAsURL();
		if (!fileDataURL) {
			console.log("no pic");
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
		
		
		let obj = {
			"mbid" : mbid,
			"mbname" : nameValue,
			"mbemail" : emailValue,
			//"mbpassword" : newPasswordValue,
			"birthday" : birthdayValue,
			"gender" : genderValue,
			"phone" : phoneValue,
			"address" : addressValue,
			"fileDataUrl" : fileDataURL
		};
		console.log(fileDataURL);

		var xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/managerUpdate'  />";
		//console.log(url);
		xhr2.open("PUT", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(obj));
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				let result = JSON.parse(xhr2.responseText);
				console.log(result);
				console.log(divResult);

				if (result.fail) {
					divResult.innerHTML = "<font color='red' >" + result.fail
							+ "</font>";
				} else if (result.success) {
					divResult.innerHTML = "<font color='GREEN'>"
							+ result.success + "</font>";
				}
			}
		}
		alert("修改成功");
		window.location.href = " <c:url value='/memberManagement' />";
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
	
	function judgeDate(birthdayValue){
		return new Date().getTime()-new Date(birthdayValue).getTime();
	}

	function setErrorFor(input, message) {
		//input.innerHTML = "<font color='red' size='-1'>" + message + "</font>";
		input.innerHTML = "<font>" + message + "</font>";
		hasError = true;
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

					<div class="Content">
						<h1 class="tittle">會員資料修改</h1>

						<div class="div__photo">
							<img class="image" id="showimg" src="" alt="" />
						</div>

						<div class="inputBox">
							<label for="mbPhotoUp"> 上傳照片 </label> <input type="file"
								class="input" name=image id="inputFileToLoad"
								accept=".jpg, .png, .jpeg, .gif"
								onchange="loadImageFileAsURL();" />
						</div>

						<div class="inputBox">
							<label for="name"> 名字 </label> <input type="text" name="mbname"
								id="mbname" class="input"><span id="result3c"
								class="checkTextFalse"></span>
						</div>


						<div class="inputBox">
							<label for="email"> E-mail </label> <input type="text"
								name="mbemail" id="mbemail" class="input" required disabled>
						</div>
<!-- 						<div class="inputBox"> -->
<!-- 							<label for="mbpassword" class="labelText">目前密碼</label> <input -->
<!-- 								id="mbpassword" type="text" class="input" disabled> -->
<!-- 						</div> -->

<!-- 						<div class="inputBox"> -->
<!-- 							<label for="newPassword"> 新密碼 </label> <input type="password" -->
<!-- 								name="newPassword" id="newPassword" class="input"><span -->
<!-- 								class="checkTextFalse" id="result1c"></span> -->
<!-- 						</div> -->

<!-- 						<div class="inputBox"> -->
<!-- 							<label for="checkNewPassword"> 確認新密碼 </label> <input -->
<!-- 								type="password" name="checkNewPassword" id="checkNewPassword" -->
<!-- 								class="input"><span class="checkTextFalse" id="result2c"></span> -->
<!-- 						</div> -->

						<div class="inputBox">
							<label for="birthDate"> 生日 </label> <input type="date"
								id="birthday" name="birthday" class="input"><span
								class="checkTextFalse" id="sp4"></span>
						</div>

						<div class="inputBox">
							<label> 性別 </label>
							<div class="input inputGender">
								<label for="male"> <input type="radio" id="male"
									name="gender" value="1"> 男性
								</label> <label for="female"> <input type="radio" id="female"
									name="gender" value="2"> 女性
								</label>
							</div>
						</div>

						<div class="inputBox">
							<label for="phone"> 手機 </label> <input type="text" name="phone"
								id="phone" class="input"><span class="checkTextFalse"
								id="sp5"></span>
						</div>

						<div class="inputBox">
							<label for="address"> 地址 </label> <input type="text"
								name="address" id="address" class="input">
						</div>

						<!-- 						<div id='resultMsg' class="resultMsg"></div> -->

						<button id="sendData" class="sureEditBtn">確認修改</button>

					</div>
				</div>


			</div>
		</div>
	</div>



</body>

</html>