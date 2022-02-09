<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>健康運動整合平台｜註冊</title>
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
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/register.css"
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script> 
	var hasError = false;
	var emailValue = null;
	var div0 =null;
	window.onload = function() {
		var alink = document.getElementById("accountCheck");
		 div0 = document.getElementById('result0c');
		emailValue=document.getElementById("mbemail").value;
		//一鍵輸入的值
		var qq = document.getElementById("qq");
		qq.onclick = function() {
			 $("#mbname").val("王曉明");
			 $("#mbemail").val("tenchu998@gmail.com");
			 $("#mbpassword").val("tenchu998");
			 $("#mbpasswordcheck").val("tenchu998");
			 $("#birthday").val("1991-12-25");
			 $("#male").prop("checked", true);
		}
		
		
		
		alink.onclick = function() {
			emailValue=document.getElementById("mbemail").value;
			console.log("使用者輸入的email為"+emailValue);
			if (!emailValue) {
				div0.innerHTML = "<font color='blue' size='-1'>請輸入帳號</font>";
				return;
			}
			console.log(IsEmail(emailValue));
			if(!IsEmail(emailValue)){
				setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i> 帳號格式不正確");
				return;
			}
			
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "<c:url value='/register/checkEmail' />", true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.send("mbemail=" + emailValue);
			var message = "";
			xhr.onreadystatechange = function() { // 伺服器請求完成
				if (xhr.readyState == 4 && xhr.status == 200) {
					var result = JSON.parse(xhr.responseText);
					if (result.mbemail.length == 0) {
						message = "<font color='green' size='-2'>帳號可用</font>";
					} else if (result.mbemail.startsWith("Error")) {
						message = "<font color='red' size='-2'>發生錯誤: 代號"
								+ result.mbemail + "</font>";
					} else {
						message = "<font color='red' size='-2'>帳號重複，請重新輸入帳號</font>";
					}
					div0.innerHTML = message;
				}
			}
		}
		//這邊是onblur開始
		const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
		 $("#mbname").blur(function(){
			 if(!($("#mbname").val())){
				 result3c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入姓名" + "</font>";
			 }else{
				 result3c.innerHTML ="";
			 }
         });
		 $("#mbemail").blur(function(){
			 if(!($("#mbemail").val())){
				 result0c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入帳號" + "</font>";
			 }else if(!IsEmail($("#mbemail").val())){
				 result0c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 帳號格式不正確" + "</font>";
			 }else{
				 result0c.innerHTML ="";
			 }
         });
		 $("#mbpassword").blur(function(){
			 if(!($("#mbpassword").val())){
				 result1c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入密碼" + "</font>";
			 }else if(!pwdRules.test(($("#mbpassword").val()))){
				 result1c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請至少輸入超過6位英文+數字" + "</font>";
			 }else{
				 result1c.innerHTML ="";
			 }
         });
		 $("#mbpasswordcheck").blur(function(){
			 if(($("#mbpassword").val())!=($("#mbpasswordcheck").val())){
				 result2c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入與密碼相同之密碼" + "</font>";
			 }else if(!$("#mbpasswordcheck").val()){
				 result2c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入確認密碼" + "</font>";
			 }else{
				 result2c.innerHTML ="";
			 }
         });
		 $("#birthday").blur(function(){
			 if(!($("#birthday").val())){
				 result4c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i>請輸入生日" + "</font>";
			 }else if(judgeDate($("#birthday").val())<0){
				 result4c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i>生日超過當前日期" + "</font>";
			 }else if (!dateValidation($("#birthday").val())) {
				 result4c.innerHTML ="<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 生日格式錯誤，正確格式為yyyy-MM-dd" + "</font>";
			 }else{
				 result4c.innerHTML ="";
			 }
		  });

		var sendData = document.getElementById("sendData");
		sendData.onclick = function() {
		
			
			div0.innerHTML = "";
			//console.log(div0);
			hasError = false;
			// 讀取欄位資料
			 emailValue = document.getElementById("mbemail").value;
			//console.log(emailValue);
			var passwordValue = document.getElementById("mbpassword").value;
			var checkValue = document.getElementById("mbpasswordcheck").value;//確認密碼
			var nameValue = document.getElementById("mbname").value;
			var birthdayValue = document.getElementById("birthday").value;
			var maleValue = document.getElementById("male").value;
			var femaleValue = document.getElementById("female").value;
			var genderValue =null;
			
			const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
		
			var div3 = document.getElementById('result3c');//姓名
			div0 = document.getElementById('result0c');//EMAIL
			var div1 = document.getElementById('result1c');//password
			var div2 = document.getElementById('result2c');//確認密碼
			var div4 = document.getElementById('result4c');//birthday
			var div5 = document.getElementById('result5c');//gender
			 var nowDate = new Date();
			//console.log(div0);
			//var divResult = document.getElementById('resultMsg');
		////////	
			
		verify();
			
	    ////////
			
			
			
			
			if (!emailValue) {
				setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i> 請輸入帳號");
				
			}else {
				IsEmail(emailValue);
				//console.log("判斷帳號是否有亂打");
				console.log(IsEmail(emailValue));
				if(IsEmail(emailValue)){
					sendDataCheckEmail();
				}else{
					setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i> 帳號格式不正確");
				}
			}
			
			if (!passwordValue) {
				setErrorFor(div1, "<i class='fas fa-exclamation-circle'></i> 請輸入密碼");
			} else {
				div1.innerHTML = "";
			}
			if(passwordValue!=""){
				if(!pwdRules.test(passwordValue)){
					setErrorFor(div1,
					"<i class='fas fa-exclamation-circle falseIcon'></i>請至少輸入超過6位英文+數字");
				}else {
					div1.innerHTML = "";
				}
			}
			if (checkValue != passwordValue) {
				setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i> 請輸入與密碼相同之密碼");
			} else if(!checkValue){
				setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i> 請輸入確認密碼");
			}else{
				div2.innerHTML = "";
			}
			if (!nameValue) {
				setErrorFor(div3, "<i class='fas fa-exclamation-circle'></i> 請輸入姓名");
			} else {
				div3.innerHTML = "";
			}
			
			//https://blog.csdn.net/hadues/article/details/89334944
// 			console.log("使用者輸入的日期是"+new Date(birthdayValue).getTime());
// 			console.log("今天的日期是     "+new Date().getTime());	
			if (!birthdayValue) {
				setErrorFor(div4, "<i class='fas fa-exclamation-circle'></i> 請輸入生日");
			}
			else if (judgeDate(birthdayValue)<0) {
				setErrorFor(div4,"<i class='fas fa-exclamation-circle'></i> 生日超過當前日期")
			}
			else if (!dateValidation(birthdayValue)) {
				setErrorFor(div4, "<i class='fas fa-exclamation-circle'></i> 生日格式錯誤，正確格式為yyyy-MM-dd");
			} else {
				div4.innerHTML = "";
			}
			var select =document.querySelector('input[name="gender"]:checked');
			if (select==null) {
				setErrorFor(div5, "<i class='fas fa-exclamation-circle'></i> 請選擇性別");
			} else if (select.value==maleValue) {
				genderValue="male";
				div5.innerHTML = "";
				console.log(genderValue);
				
			} else if(select.value==femaleValue) {
				div5.innerHTML = "";
				genderValue="female";
				console.log(genderValue);
			} else{
				div5.innerHTML = "";
				console.log("這行應該跑不到");
			}
		
			if (hasError) {
				return false;
			}
			
			
			var xhr1 = new XMLHttpRequest();
			xhr1.open("POST", "<c:url value='/rigesterMember' />", true);
			// 下方為一個Javascript物件
			var jsonMember = {
				"mbemail" : emailValue,
				"mbpassword" : passwordValue,
				"mbname" : nameValue,
				"birthday" : birthdayValue,
				"gender" : genderValue
			}
			xhr1.setRequestHeader("Content-Type", "application/json");
			xhr1.send(JSON.stringify(jsonMember));

			xhr1.onreadystatechange = function() { // 伺服器請求完成
				if (xhr1.readyState == 4
						&& (xhr1.status == 200 || xhr1.status == 201)) {
					result = JSON.parse(xhr1.responseText);
					if (result.fail) {
// 						divResult.innerHTML = "<font color='red' >"
// 								+ result.fail + "</font>";
                          console.log(result.fail);
					} else if (result.success) {
						
						sendRegisterSuccessEmail(emailValue);
						
						 window.location.href = " <c:url value='/registerSuccess/' />"+nameValue+"/"+emailValue;
						 
					} else {
						if (result.emailError) {
							div0.innerHTML = "<font color='green' size='-2'>"
									+ result.emailError + "</font>";
						} else {
							div0.innerHTML = "";
						}
						if (result.passwordError) {
							div1.innerHTML = "<font color='green' size='-2'>"
									+ result.passwordError + "</font>";
						} else {
							div1.innerHTML = "";
						}
						if (result.nameError) {
							div3.innerHTML = "<font color='green' size='-2'>"
									+ result.nameError + "</font>";
						} else {
							div3.innerHTML = "";
						}
					}
				}
				
			}
			//alert("註冊成功!!");
			
		}

	}
	
	function IsEmail(emailValue) {
		//初版
		 // var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		//二版 參考https://ithelp.ithome.com.tw/articles/10094951
		  var regex = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
		  if(!regex.test(emailValue)) {
		    return false;
		  }else{
		    return true;
		  }
		}
	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='2'>" + message + "</font>";
		hasError = true;
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
	function sendRegisterSuccessEmail(email){
		
		var xhremail = new XMLHttpRequest();
		xhremail.open("POST", "<c:url value='/send' />", true);
		
		let msg="請點選以下連結，確認您要以此 email 註冊：";
		var mailDetail={
				"recipient":email,
				"subject":"會員註冊成功通知信",
				"message":msg
				
		}
		console.log(mailDetail);
		xhremail.setRequestHeader("Content-Type", "application/json");
		xhremail.send(JSON.stringify(mailDetail));
		xhremail.onreadystatechange = function() {
			if (xhremail.readyState == 4 && xhremail.status == 200) {
				var result = xhremail.responseText;
			}
		}
	}
	function sendDataCheckEmail(){
		//var emailValue = document.getElementById("mbemail").value;
			console.log("使用者輸入的EMAIL="+emailValue);
		 div0 = document.getElementById('result0c');
		var xhr2 = new XMLHttpRequest();
		xhr2.open("POST", "<c:url value='/register/checkEmail' />", true);
		xhr2.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr2.send("mbemail=" + emailValue);
		var message = "";
		xhr2.onreadystatechange = function() { // 伺服器請求完成
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				var result = JSON.parse(xhr2.responseText);
				if (result.mbemail.length == 0) {//如果資料庫沒資料result會是空字串
					message = "";
				} else if (result.mbemail.startsWith("Error")) {
					message = "<font color='red' size='-2'>發生錯誤: 代號"
							+ result.mbemail + "</font>";
				} else {
					message = "<font color='red' size='-2'><i class='fas fa-exclamation-circle'></i>帳號已註冊，請重新輸入帳號</font>";
				}
				div0.innerHTML = message;
			}
		}
	}

	function judgeDate(birthdayValue){
		return new Date().getTime()-new Date(birthdayValue).getTime();
	}
	function verify(){
		if(grecaptcha.getResponse()){
			var token=grecaptcha.getResponse();
			console.log(token);//this is  token
			
			var xhr4 = new XMLHttpRequest();
			xhr4.open("POST", "<c:url value='/robot' />", true);
			var json = {"token" : token}
			console.log(json);
			xhr4.setRequestHeader("Content-Type", "application/json");
			xhr4.send(JSON.stringify(json));

// 			xhr4.onreadystatechange = function() { // 伺服器請求完成
// 				if (xhr4.readyState == 4 && xhr4.status == 200) {
// 					var result = JSON.parse(xhr4.responseText);
// 					//console.log(result);
// 				}			
//			}

			return true;
		}else{
			hasError = true;
			alert("請驗證您不是機器人");
			return false;
		}
	}
</script>
</head>

<body id="page-top">
<%@include file="../navigation.jsp"%>
	<!-- Navigation-->
<!-- 	<div class="navbg"></div> -->
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="form1">
		<div class="con">
			<h1 class="title">註冊會員</h1>
			<p class="title">請填寫資料完成會員註冊</p>
			<hr>
			<label for="mbname"><b>名字</b></label> <span id='result3c'
				style="margin-left: 10px; height: 10px;"></span> <input type="text"
				placeholder="請輸入名字" name="mbname" id="mbname" class="form-control"
				required> <label for="mbemail"><b>E-mail</b></label> <a
				href='#' class="checkemail" id='accountCheck'
				style='font-size: 10pt;'>檢查Email</a><span id='result0c'
				style="margin-left: 10px; height: 10px;"></span> <input type="text"
				placeholder="Enter Email" name="mbemail" id="mbemail"
				class="form-control" required> <label for="mbpassword"><b>密碼</b></label><span
				id='result1c' style="margin-left: 10px; height: 10px;"></span> <input
				type="password" placeholder="Enter Password" name="mbpassword"
				id="mbpassword" class="form-control" required> <label
				for="mbpasswordcheck"><b>確認密碼</b></label> <span id='result2c'
				style="margin-left: 10px; height: 10px;"></span> <input
				type="password" placeholder="Repeat Password" name="mbpasswordcheck"
				id="mbpasswordcheck" class="form-control" required> <label
				for="birthday"><b>生日</b></label><span id='result4c'
				style="margin-left: 10px; height: 10px;"></span> <input type="date"
				id="birthday" name="birthday" class="form-control" required>
			<label><b>性別</b></label> <span id='result5c'
				style="margin-left: 10px; height: 10px;"></span>
			<div class="divsex">
				<label for="male"> <input type="radio" id="male"
					name="gender" value="1"> 男性
				</label> <label for="female"> <input type="radio" id="female"
					name="gender" value="2"> 女性
				</label>
			</div>
			<!-- 		<div style="display:flex;justify-content:flex-end ;width:100%;"> -->
			<div class="qqdiv">
			<div class="g-recaptcha"
				data-sitekey="6LdJdyIcAAAAAAAF7KBgESmY2r0ph0XmZXP2Bcgi"></div>
				<a
				 class="quick" id='qq' 
				style='font-size: 10pt;'></a>
				
				</div>
				
			<!-- 		</div> -->
			<!-- 			<script src="https://vivirenremoto.github.io/doomcaptcha/script.js?version=16" countdown="on" label="Captcha" enemies="4"></script> -->
			<hr>
			<!--                 <p class="privacy">註冊許可協議 <a class="privacy" href="#">隱私權條款</a></p> -->

			<button id="sendData" class="registerbtn">註冊</button>
			<div
				style="text-align: end; margin-top: 15px; font-size: 14px; opacity: 0.75; padding: 0 5px;">
				<span>已經有帳號了？ <a href="<c:url value='/login' />">立即登入</a>
				</span>
			</div>
		</div>
	</div>
	<!-- 	<div id="resultMsg"></div> -->



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