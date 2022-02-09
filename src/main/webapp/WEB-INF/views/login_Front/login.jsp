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
<title>健康運動整合平台｜登入</title>
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
<link href="${pageContext.request.contextPath}/css/login.css"
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<script>

var hasError = false;	
window.onload = function() {
	var sendData = document.getElementById("sendData");
	
	const pwdRules=/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;//英+數 upp
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
			 result2c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請輸入密碼" + "</font>";
		 }else if(!pwdRules.test(($("#mbpassword").val()))){
			 result2c.innerHTML = "<font color='red' size='2'>" + "<i class='fas fa-exclamation-circle'></i> 請至少輸入超過6位英文+數字" + "</font>";
		 }else{
			 result2c.innerHTML ="";
		 }
    });
	
	sendData.onclick = function() {
	  var emailValue = document.getElementById("mbemail").value;
	  var passwordValue = document.getElementById("mbpassword").value;
		var div0 = document.getElementById('result0c');//email
		var div1 = document.getElementById('result1c');
		var div2 = document.getElementById('result2c');//password
		
		div1.innerHTML = "";
		console.log(emailValue);
		console.log(passwordValue);
	
		
// 		 if ((!emailValue)&&(!passwordValue)) {
// 			setErrorFor(div1, "<i class='fas fa-exclamation-circle'></i>請輸入帳號及密碼");
// 		}else {
// 			div1.innerHTML = "";
			
// 		}
		 if (!emailValue) {
			setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i>請輸入帳號");
		}
		else if(!IsEmail(emailValue)){
			setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i> 帳號格式不正確");
		}else {
			div0.innerHTML = "";
			 hasError = false;
			 
			 if (!passwordValue) {
					setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i>請輸入密碼");
				} else if(!pwdRules.test(passwordValue)){
					setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i>請至少輸入超過6位英文+數字");
				}
				else {
					div2.innerHTML = "";
					 hasError = false;	
				}
		}
	
		
		 if (!passwordValue) {
				setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i>請輸入密碼");
			} else if(!pwdRules.test(passwordValue)){
				setErrorFor(div2, "<i class='fas fa-exclamation-circle'></i>請至少輸入超過6位英文+數字");
			}
			else {
				div2.innerHTML = "";
				 hasError = false;
				 
				 if (!emailValue) {
						setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i>請輸入帳號");
					}
					else if(!IsEmail(emailValue)){
						setErrorFor(div0, "<i class='fas fa-exclamation-circle'></i> 帳號格式不正確");
					}else {
						div0.innerHTML = "";
					}
			}
			console.log(hasError);
		
		 if (hasError) {
				return false;
			}
 	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "<c:url value='/login/checkAccount' />", true);
	//對應到Member.java (JavaBean的field)
	  var jsonMember = {  
				"mbemail": emailValue, 	
				"mbpassword": passwordValue
	   		}
	  console.log(jsonMember);
 	  xhr.setRequestHeader("Content-Type", "application/json");
 	  xhr.send(JSON.stringify(jsonMember));
  	 console.log(JSON.stringify(jsonMember));
 		xhr.onreadystatechange = function() {
 			if (xhr.readyState == 4
					&& (xhr.status == 200 || xhr.status == 201)) {
 				result = JSON.parse(xhr.responseText);
 				var rs	=result.mb;
 				console.log(rs);
 				if(rs!=null){
 					if(rs==="false"){
 						console.log(result.mb);
 						setErrorFor(div1, "帳號或密碼不正確");
 					}
 					else if(rs==="wrong password"){
 						setErrorFor(div1, "密碼不正確");				
 					}else if(rs==="verifyfailed"){
 						setErrorFor(div1, "帳號尚未開通");	
 					}
 					else{    
 						 window.location.href = " <c:url value='/index' />"; 
 					}
 					
 				}
 				//hasError = false;
 			}	
 		}
   }
	
	$("#memberlogin").hover(function(){
		$("#m1login").show();
		$("#m2login").show();
		$("#newlogin").show();
	},function(){
		$("#m1login").hide();
		$("#m2login").hide();
		$("#newlogin").hide();
	});
	
	$("#m1login").mouseover(function(){
		$("#m1login").show();
		$("#m2login").show();
		$("#newlogin").show();
	});
	
	$("#m2login").mouseover(function(){
		$("#m1login").show();
		$("#m2login").show();
		$("#newlogin").show();
	});
	
	$("#newlogin").mouseover(function(){
		$("#m1login").show();
		$("#m2login").show();
		$("#newlogin").show();
	});
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

//會員一帳號密碼
function m1login(){
	let mbEmail = document.getElementById("mbemail");
	let mbPassword = document.getElementById("mbpassword");
	mbEmail.value = "kitty789@gmail.com";
	mbPassword.value = "test123";
}

//會員二帳號密碼
function m2login(){
	let mbEmail = document.getElementById("mbemail");
	let mbPassword = document.getElementById("mbpassword");
	mbEmail.value = "tsyifm0828@gmail.com";
	mbPassword.value = "aaaa1111";
}

//new
function newlogin(){
	let mbEmail = document.getElementById("mbemail");
	let mbPassword = document.getElementById("mbpassword");
	mbEmail.value = "tenchu998@gmail.com";
	mbPassword.value = "tenchu998";
}


</script>
</head>
<body id="page-top">
	<%@include file="../navigation.jsp"%>
<!-- 	<div class="navbg"></div> -->
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="form1" style="position:relative">
	
	<div class="con">
		<h1 class="title" id="memberlogin">會員登入</h1>
		<!-- <p class="title">請填寫資料完成會員註冊</p> -->
		<hr>
		<label for="mbemail"><b>E-mail</b></label> <span id='result0c'
			style="margin-left: 10px; height: 10px;"></span><input type="text"
			placeholder="Enter Email" name="mbemail" id="mbemail"
			class="form-control" required> <label for="mbpassword"><b>密碼</b></label><span id='result2c'
			style="margin-left: 10px; height: 10px;"></span>
		<input type="password" placeholder="Enter Password" name="mbpassword"
			id="mbpassword" class="form-control" required>
		<div id='result1c' style="height: 10px;"></div>
		<hr>
		<button class="registerbtn" id="sendData">登入</button>
		 <div
                style="display:flex; justify-content:space-between; margin-top:15px; font-size: 14px; opacity: 0.75; padding:0 5px;">
                <a href="<c:url value='/login/login_forgetPassword' />"  class="forgetPw"><i class="fas fa-lock"></i> 忘記密碼</a>
                <span>還沒加入會員嗎？
                    <a href="<c:url value='/register' />" class="goLogin" >立即註冊</a>
                </span>   
            </div>
	</div>
			<button class="btn btn-success" onclick="m1login()" id="m1login" style='position:absolute;top:250px;right:500px;display:none'>M1</button>
			<button class="btn btn-success" onclick="m2login()" id="m2login" style='position:absolute;top:250px;right:430px;display:none'>M2</button>
			<button class="btn btn-success" onclick="newlogin()" id="newlogin" style='position:absolute;top:250px;left:500px;display:none'>New</button>
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
	<script>
		$(function(){
			if(${registrationRs!=null}){
				if(${registrationRs==true}){
					window.alert("註冊成功! 請登入")
				}
			}
			});
    </script>
</body>
</html>